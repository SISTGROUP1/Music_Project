package com.sist.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import com.sist.service.ReserveService;

@Controller
public class ReserveController {

	@Autowired
	private ReserveService rService;
	
	@GetMapping("show/reserve.do")
	public String show_reserve(int sno,Model model)
	{
		model.addAttribute("sno", sno);
		return "show/reserve";
	}
	
	@GetMapping("mypage/showreserve.do")
   public String mypage_main()
   {
	   return "mypage/showreserve";
   }
	
   @GetMapping("adminpage/adminpage.do")
   public String adminpage_main()
   {
	   return "adminpage/adminpage";
   }
}
