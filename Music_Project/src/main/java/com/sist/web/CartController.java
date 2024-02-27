package com.sist.web;

import java.util.StringTokenizer;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sist.service.CartService;
import com.sist.vo.CartVO;

@Controller
@RequestMapping("/cart")
@PropertySource("classpath:../properties/project.properties")
public class CartController {
	@Value("${imp}")
	private String imp;
	@GetMapping("cart.do")
	public String cart_cart(HttpSession session,Model model) {
		String userId=(String) session.getAttribute("userId");
		model.addAttribute("sessionId", userId);
		return "cart/cart";
	}
	@GetMapping("payment.do")
	public String cart_payment(String check,String[] checked,Model model) {
		if(checked!=null) {
			String checks="";
			for(String c:checked) {
				checks+=c+",";
			}
			checks=checks.substring(0, checks.lastIndexOf(","));
			model.addAttribute("checked", checks);
		}else {
			model.addAttribute("checked", check);
			model.addAttribute("type", "1");
		}
		model.addAttribute("imp", imp);
		return "cart/payment";
	}
}
