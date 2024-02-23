package com.sist.manager;

import org.springframework.stereotype.Component;

import java.io.FileReader;
import java.util.*;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.sist.vo.*;
import com.sist.service.*;
import com.sist.vo.MemberVO;

@Component
public class MailManager {
	
	private String style="<style>" + 
    		"body {" + 
    		"	  padding:1.5em;" + 
    		"	  background: #f5f5f5" + 
    		"	}" + 
    		"	table {" + 
    		"	  border: 1px #a39485 solid;" + 
    		"	  font-size: .9em;" + 
    		"	  box-shadow: 0 2px 5px rgba(0,0,0,.25);" + 
    		"	  width: 100%;" + 
    		"	  border-collapse: collapse;" + 
    		"	  border-radius: 5px;" + 
    		"	  overflow: hidden;" + 
    		"	}" + 
    		"	th {" + 
    		"	  text-align: left;" + 
    		"	}" + 
    		"	thead {" + 
    		"	  font-weight: bold;" + 
    		"	  color: #fff;" + 
    		"	  background: #73685d;" + 
    		"	}" + 
    		"	 td, th {" + 
    		"	  padding: 1em .5em;" + 
    		"	  vertical-align: middle;" + 
    		"	}" + 
    		"	 td {" + 
    		"	  border-bottom: 1px solid rgba(0,0,0,.1);" + 
    		"	  background: #fff;" + 
    		"	}" + 
    		"	a {" + 
    		"	  color: #73685d;" + 
    		"	}" + 
    		"	 @media all and (max-width: 768px) {" + 
    		"	  table, thead, tbody, th, td, tr {" + 
    		"	    display: block;" + 
    		"	  }" + 
    		"	  th {" + 
    		"	    text-align: right;" + 
    		"	  }" + 
    		"	  table {" + 
    		"	    position: relative; " + 
    		"	    padding-bottom: 0;" + 
    		"	    border: none;" + 
    		"	    box-shadow: 0 0 10px rgba(0,0,0,.2);" + 
    		"	  }" + 
    		"	  thead {" + 
    		"	    float: left;" + 
    		"	    white-space: nowrap;" + 
    		"	  }" + 
    		"	  tbody {" + 
    		"	    overflow-x: auto;" + 
    		"	    overflow-y: hidden;" + 
    		"	    position: relative;" + 
    		"	    white-space: nowrap;" + 
    		"	  }" + 
    		"	  tr {" + 
    		"	    display: inline-block;" + 
    		"	    vertical-align: top;" + 
    		"	  }" + 
    		"	  th {" + 
    		"	    border-bottom: 1px solid #a39485;" + 
    		"	  }" + 
    		"	  td {" + 
    		"	    border-bottom: 1px solid #e5e5e5;" + 
    		"	  }" + 
    		"	  }" + 
    		"</style>";
	
	public void mailMemberSender(MemberVO vo)
	{
		 
     String temp="";
		try
		{
         FileReader fr=new FileReader("c:\\springDev\\mail.txt");
         int i=0;
         while((i=fr.read())!=-1)
         {
         	temp+=String.valueOf((char)i);
         }
		}catch(Exception ex) {}
		
     String host="smtp.naver.com";
     String user="shinara0318@naver.com";
     String password="shinara0318!";
     Properties props=new Properties();
     props.put("mail.smtp.host", host);
     props.put("mail.smtp.port", 587);
     props.put("mail.smtp.auth", "true");
     
     Session session=Session.getDefaultInstance(props,new javax.mail.Authenticator() {
     	  protected PasswordAuthentication getPasswordAuthentication() {
     		  return new PasswordAuthentication(user, password);
     	  }
     });
     
     try
     {
     	String html="<html>"
     				+"<head>"+style+"</head>"
     				+"<body>"
     				+"<table width=450>"
     				+"<tr>"
     				+"<td colspan=2>"
     				+"<img src=\"https://i.ibb.co/SPVPQc1/001.png\" style \"width:600px;height:500px\">"
     				+"</td>"
     				+"</tr>"
     				+"</table>"
     				+"</body>"
     				+"</html>";
     	
     	MimeMessage message=new MimeMessage(session);
     	message.setFrom(new InternetAddress(user));
     	
     	message.setContent(html,"text/html;charset=UTF-8"); // 내용
     	message.addRecipient(Message.RecipientType.TO, new InternetAddress("sar1999@naver.com")); // 받는사람
     	//message.addRecipient(Message.RecipientType.TO, new InternetAddress(vo.getEmail()));
     	message.setSubject(vo.getUserName()+"님, 회원가입을 축하합니다."); // 제목
     	Transport.send(message);
     	System.out.println("메일 전송 완료!!");
     }catch(Exception ex) {}
	
	}
	public void mailReserveSender()
	{
		
	}
}
