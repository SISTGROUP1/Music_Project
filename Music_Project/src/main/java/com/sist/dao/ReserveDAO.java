package com.sist.dao;

import java.util.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.sist.mapper.*;
import com.sist.vo.ReserveVO;
import com.sist.vo.ShowVO;

@Repository
public class ReserveDAO {

	@Autowired
	private ReserveMapper mapper;
	
	public ShowVO reserveDetailData(int sno)
	{
		return mapper.reserveDetailData(sno);
	}
	public void showReserveInsert(ReserveVO vo)
	{
		mapper.showReserveInsert(vo);
	}
	
	public List<ReserveVO> reserveMypageData(String userId)
	{
		return mapper.reserveMypageData(userId);
	}
	
	public void reserveCancel(int srno)
	{
		mapper.reserveCancel(srno);
	}
	
	   public List<ReserveVO> reserveAdminpageData()
	   {
		   return mapper.reserveAdminpageData();
	   }
	   
	   public void reserveOk(int srno)
	   {
		   mapper.reserveOk(srno);
	   }
	   
	   public ReserveVO reserveInfoData(int srno)
	   {
		   return mapper.reserveInfoData(srno);
	   }
}
