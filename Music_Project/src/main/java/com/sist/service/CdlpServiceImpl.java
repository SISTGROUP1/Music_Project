package com.sist.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.dao.CdlpDAO;
import com.sist.vo.CdlpVO;

@Service
public class CdlpServiceImpl implements CdlpService {
	@Autowired
	private CdlpDAO cDao;

	@Override
	public List<CdlpVO> cdlpListData_Home() {
		return cDao.cdlpListData_Home();
	}

	@Override
	public List<CdlpVO> cdlpCateList() {
		return cDao.cdlpCateList();
	}

	@Override
	public List<CdlpVO> cdlpListData_Sort(Map map) {
		return cDao.cdlpListData_Sort(map);
	}

	@Override
	public int cdlpListTotalPage(CdlpVO vo) {
		return cDao.cdlpListTotalPage(vo);
	}

	@Override
	public CdlpVO cdlpDetailData(int no) {
		return cDao.cdlpDetailData(no);
	}

	@Override
	public List<CdlpVO> cdlpSalesTop6() {
		return cDao.cdlpSalesTop6();
	}

}
