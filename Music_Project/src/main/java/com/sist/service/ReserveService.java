package com.sist.service;

import java.util.*;
import com.sist.vo.ReserveVO;
import com.sist.vo.ShowVO;

public interface ReserveService {

	public ShowVO reserveDetailData(int sno);
	public void showReserveInsert(ReserveVO vo);
	public List<ReserveVO> reserveMypageData(String userId);
	public void reserveCancel(int srno);
    public List<ReserveVO> reserveAdminpageData();
    public void reserveOk(int srno);
    public ReserveVO reserveInfoData(int srno);
}
