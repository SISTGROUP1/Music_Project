package com.sist.service;

import java.util.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.sist.dao.ReserveDAO;
import com.sist.vo.ReserveVO;
import com.sist.vo.ShowVO;

@Service
public class ReserveServiceImpl implements ReserveService {

	@Autowired
	private ReserveDAO rDao;
	
	@Override
	public ShowVO reserveDetailData(int sno) {
		// TODO Auto-generated method stub
		return rDao.reserveDetailData(sno);
	}
	
	@Override
	public void showReserveInsert(ReserveVO vo) {
		// TODO Auto-generated method stub
		rDao.showReserveInsert(vo);
	}

	@Override
	public List<ReserveVO> reserveMypageData(String userId) {
		// TODO Auto-generated method stub
		return rDao.reserveMypageData(userId);
	}

	@Override
	public void reserveCancel(int srno) {
		// TODO Auto-generated method stub
		rDao.reserveCancel(srno);
	}

	@Override
	public List<ReserveVO> reserveAdminpageData() {
		// TODO Auto-generated method stub
		return rDao.reserveAdminpageData();
	}

	@Override
	public void reserveOk(int srno) {
		// TODO Auto-generated method stub
		rDao.reserveOk(srno);
	}

	@Override
	public ReserveVO reserveInfoData(int srno) {
		// TODO Auto-generated method stub
		return rDao.reserveInfoData(srno);
	}	
}
