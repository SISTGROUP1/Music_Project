package com.sist.web;

import java.util.*;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.service.*;
import com.sist.vo.*;

@RestController
public class ReserveRestController {

	@Autowired
	private ReserveService rService;
	
	@GetMapping(value="show/reserve_vue.do",produces = "text/plain;charset=UTF-8")
    public String reserve_vue(int sno) throws Exception
    {
	   ShowVO vo=rService.reserveDetailData(sno);
	   ObjectMapper mapper=new ObjectMapper();
	   String json=mapper.writeValueAsString(vo);
	   return json;
    }
	 @PostMapping(value="show/reserve_ok.do",produces = "text/plain;charset=UTF-8")
	   public String reserve_ok(ReserveVO vo,HttpSession session)
	   {
		   String result="no";
		   try 
		   {
			   vo.setUserId((String)session.getAttribute("userId"));
			   rService.showReserveInsert(vo);
		       result="yes";
		       
		   }catch(Exception ex)
		   {
			   result="no";
		   }
		   return result;
	   }
	   @GetMapping(value="reserve/mypage_list_vue.do",produces = "text/plain;charset=UTF-8")
	   public String mypage_list(HttpSession session) throws Exception
	   {
		   String userId=(String)session.getAttribute("userId");
		   List<ReserveVO> list=rService.reserveMypageData(userId);
		   ObjectMapper mapper=new ObjectMapper();
		   String json=mapper.writeValueAsString(list);
		   return json;
	   }
	   @GetMapping(value="reserve/reserve_cancel_vue.do",produces = "text/plain;charset=UTF-8")
	   public String reserve_cancel(int srno)
	   {
		   String result="";
		   try
		   {
			   result="yes";
			   rService.reserveCancel(srno);
		   }catch(Exception ex) 
		   {
			   result="no";   
		   }
		   return result;
	   }
	   @GetMapping(value="reserve/reserve_admin_vue.do",produces = "text/plain;charset=UTF-8")
	   public String reserve_admin() throws Exception
	   {
		   List<ReserveVO> list=rService.reserveAdminpageData();
		   ObjectMapper mapper=new ObjectMapper();
		   String json=mapper.writeValueAsString(list);
		   return json;
	   }
	   @GetMapping(value="reserve/reserve_ok_vue.do",produces = "text/plain;charset=UTF-8")
	   public String reserve_ok(int srno)
	   {
		   String result="";
		   try
		   {
			   result="yes";
			   rService.reserveOk(srno);
			   ReserveVO vo=rService.reserveInfoData(srno);
		   }catch(Exception ex)
		   {
			   ex.printStackTrace();
			   result=ex.getMessage();
		   }
		   return result;
	   }
}
