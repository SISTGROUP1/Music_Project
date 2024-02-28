package com.sist.dao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.mapper.CdlpMapper;
import com.sist.vo.CdlpVO;

@Repository
public class CdlpDAO {
	@Autowired
	private CdlpMapper mapper;
	
	public List<CdlpVO> cdlpListData_Home() {
		return mapper.cdlpListData_Home();
	}
	public List<CdlpVO> cdlpCateList() {
		return mapper.cdlpCateList();
	}
	public List<CdlpVO> cdlpListData_Sort(Map map) {
		return mapper.cdlpListData_Sort(map);
	}
	public int cdlpListTotalPage(CdlpVO vo) {
		return mapper.cdlpListTotalPage(vo);
	}
	public CdlpVO cdlpDetailData(int no) {
		return mapper.cdlpDetailData(no);
	}
	public List<CdlpVO> cdlpSalesTop6() {
		return mapper.cdlpSalesTop6();
	}
	public double cdlpScore(int fno) {
		return mapper.cdlpScore(fno);
	}
	public void cdlpScoreUpdate(double score, int no) {
		mapper.cdlpScoreUpdate(score, no);
	}
}
