package com.sist.manager;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;

import com.sist.vo.WeatherVO;

@Configuration
@PropertySource("classpath:../properties/apikey.properties")
public class WeatherManager {
	@Value("${apikey}")   // 프로퍼티 값 가져오기
    private String api;
	
	public WeatherVO WeatherFind() {
		
		String city = "Seoul";
		String lang = "kr";

        String apiURL = "https://api.openweathermap.org/data/2.5/weather?q="+city+"&appid="+api+"&lang="+lang+"&units=metric";    // JSON 결과
        //String apiURL = "https://openapi.naver.com/v1/search/blog.xml?query="+ text; // XML 결과


        Map<String, String> requestHeaders = new HashMap<>();
        String responseBody = get(apiURL,requestHeaders);
		WeatherVO vo = new WeatherVO();

        try {
			JSONParser jp = new JSONParser();
			JSONObject root = (JSONObject)jp.parse(responseBody);
			JSONArray arr = (JSONArray)root.get("weather");
			for(int i = 0; i<arr.size();i++) {
				JSONObject obj = (JSONObject)arr.get(i);
				vo.setDesc((String)obj.get("description"));
				vo.setIcon((String)obj.get("icon"));
			}
			JSONObject j = (JSONObject)root.get("main");
			double temp = (double)j.get("temp");
			vo.setTemp(String.valueOf(temp));
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
        
        return vo;
    }


    private static String get(String apiUrl, Map<String, String> requestHeaders){
        HttpURLConnection con = connect(apiUrl);
        try {
            con.setRequestMethod("GET");
            for(Map.Entry<String, String> header :requestHeaders.entrySet()) {
                con.setRequestProperty(header.getKey(), header.getValue());
            }


            int responseCode = con.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) { // 정상 호출
                return readBody(con.getInputStream());
            } else { // 오류 발생
                return readBody(con.getErrorStream());
            }
        } catch (IOException e) {
            throw new RuntimeException("API 요청과 응답 실패", e);
        } finally {
            con.disconnect();
        }
    }


    private static HttpURLConnection connect(String apiUrl){
        try {
            URL url = new URL(apiUrl);
            return (HttpURLConnection)url.openConnection();
        } catch (MalformedURLException e) {
            throw new RuntimeException("API URL이 잘못되었습니다. : " + apiUrl, e);
        } catch (IOException e) {
            throw new RuntimeException("연결이 실패했습니다. : " + apiUrl, e);
        }
    }


    private static String readBody(InputStream body){
        InputStreamReader streamReader = new InputStreamReader(body);


        try (BufferedReader lineReader = new BufferedReader(streamReader)) {
            StringBuilder responseBody = new StringBuilder();


            String line;
            while ((line = lineReader.readLine()) != null) {
                responseBody.append(line);
            }


            return responseBody.toString();
        } catch (IOException e) {
            throw new RuntimeException("API 응답을 읽는 데 실패했습니다.", e);
        }
    }
}
    
