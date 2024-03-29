package com.sist.service;

import java.util.List;
import java.util.Map;

import com.sist.vo.CdlpVO;

public interface CdlpService {
	public List<CdlpVO> cdlpListData_Home();
	public List<CdlpVO> cdlpCateList();
	public List<CdlpVO> cdlpListData_Sort(Map map);
	public int cdlpListTotalPage(CdlpVO vo);
	public CdlpVO cdlpDetailData(int no);
	public List<CdlpVO> cdlpSalesTop6();
	public double cdlpScore(int fno);
	public void cdlpScoreUpdate(double score, int no);
	public List<CdlpVO> searchCdlpData(Map map);
	public int searchCdlpDataCnt(String search);
}
