package com.sist.aop;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.sist.manager.MusicSearchManager;
import com.sist.manager.WeatherManager;
import com.sist.vo.MusicSearchImageVO;
import com.sist.vo.WeatherVO;

@Aspect
@Component
public class MusicFindAOP {
	
	@Autowired
	WeatherManager wMgr;
	
	@Autowired
	MusicSearchManager mMgr;
	
	@After("execution(* com.sist.web.MusicFind*Controller.*(..))")
	public void musicSearch() {
		WeatherVO wVo = wMgr.WeatherFind();
		List<MusicSearchImageVO> mVo = mMgr.newsFind(wVo.getDesc()+" 날 음악 추천");
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		
		request.setAttribute("wVo", wVo);
		request.setAttribute("mVo", mVo);
	}
}
