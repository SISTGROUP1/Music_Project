package com.sist.service;

import org.apache.ibatis.annotations.Param;

import com.sist.vo.MemberVO;

public interface MemberService {
	public int memberIdCount(String userId);
	public void memberInsert(MemberVO vo);
	public void memberAuthorityInsert(String userId);
	public MemberVO memberLogin(String userId, String userPwd);
	
	public void lastLoginUpdate(String userId);
	public MemberVO memberSessionData(String userId);
	
	public String idFindOpen(String userName, String email);
	public MemberVO pwdChange(String userId, String email, String userPwd);
}
