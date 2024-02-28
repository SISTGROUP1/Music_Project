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
import com.sist.service.MusicFindService;
import com.sist.vo.CdlpVO;
import com.sist.vo.FindVO;
import com.sist.vo.MusicFindVO;

@Aspect
@Component
public class FooterAOP {
	@Autowired
	private FooterManager fManager;
	@Autowired
	private CdlpService cService;
	@Autowired
	private MusicFindService mfService;
	
	@After("execution(* com.sist.web.*Controller.*(..))")
	public void footer_data() {
		List<MusicFindVO> mvList = mfService.footerMV();
		List<FindVO> findNewSongList=fManager.footerData("신곡 발매");
		List<FindVO> findArtistList=fManager.footerData("가수");
		List<CdlpVO> cdlpSalesTopList=cService.cdlpSalesTop6();
		HttpServletRequest request=((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		request.setAttribute("findNewSongList", findNewSongList);
		request.setAttribute("findArtistList", findArtistList);
		request.setAttribute("cdlpSalesTopList", cdlpSalesTopList);
		request.setAttribute("mvList", mvList);
	}
}
