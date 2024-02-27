package com.sist.aop;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.sist.manager.FooterManager;
import com.sist.service.CdlpService;
import com.sist.vo.CdlpVO;
import com.sist.vo.FindVO;

@Aspect
@Component
public class FooterAOP {
	@Autowired
	private FooterManager fManager;
	@Autowired
	private CdlpService cService;
	
	@After("execution(* com.sist.web.*Controller.*(..))")
	public void footer_data() {
		List<FindVO> findList=fManager.footerData("신곡");
		List<CdlpVO> cdlpSalesTopList=cService.cdlpSalesTop6();
		HttpServletRequest request=((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		request.setAttribute("findList", findList);
		request.setAttribute("cdlpSalesTopList", cdlpSalesTopList);
	}
}
