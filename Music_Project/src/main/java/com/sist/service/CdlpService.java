package com.sist.service;

import java.util.List;
import java.util.Map;

import com.sist.vo.CdlpVO;

public interface CdlpService {
	public List<CdlpVO> cdlpListData_Home();
	public List<CdlpVO> cdlpCateList();
//	public List<CdlpVO> cdlpListData_RecentM(int start, int end);
	public List<CdlpVO> cdlpListData_Sort(Map map);
	public int cdlpListTotalPage(CdlpVO vo);
	public CdlpVO cdlpDetailData(int no);
}
