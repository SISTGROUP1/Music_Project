package com.sist.web;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sist.vo.CdlpVO;

@Controller
@RequestMapping("cdlp/")
public class CdlpController {
	@GetMapping("main.do")
	public String cdlp_main() {
		return "cdlp/cdlp_main";
	}
	@GetMapping("list.do")
	public String cdlp_list(CdlpVO vo,Model model) {
		model.addAttribute("genre", vo.getGenre());
		model.addAttribute("sub_genre", vo.getSub_genre());
		return "cdlp/cdlp_list";
	}
	@GetMapping("detail.do")
	public String cdlp_detail(int no,Model model) {
		model.addAttribute("no", no);
		return "cdlp/cdlp_detail";
	}
}
