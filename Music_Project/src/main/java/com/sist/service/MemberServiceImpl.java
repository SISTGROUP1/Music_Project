package com.sist.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.dao.*;
import com.sist.vo.MemberVO;

import java.util.*;

@Service
public class MemberServiceImpl implements MemberService{
	@Autowired
	private MemberDAO mDao;

	@Override
	public int memberIdCount(String userId) {
		// TODO Auto-generated method stub
		return mDao.memberIdCount(userId);
	}

	@Override
	public void memberInsert(MemberVO vo) {
		// TODO Auto-generated method stub
		mDao.memberInsert(vo);
	}

	@Override
	public void memberAuthorityInsert(String userId) {
		// TODO Auto-generated method stub
		mDao.memberAuthorityInsert(userId);
	}

	@Override
	public MemberVO memberLogin(String userId, String userPwd) {
		// TODO Auto-generated method stub
		return mDao.memberLogin(userId, userPwd);
	}

	@Override
	public String idFindOpen(String userName, String email) {
		// TODO Auto-generated method stub
		return mDao.idFindOpen(userName, email);
	}

	@Override
	public MemberVO pwdChange(String userId, String email, String userPwd) {
		// TODO Auto-generated method stub
		return mDao.pwdChange(userId, email, userPwd);
	}

	@Override
	public void lastLoginUpdate(String userId) {
		// TODO Auto-generated method stub
		mDao.lastLoginUpdate(userId);
	}

	@Override
	public MemberVO memberSessionData(String userId) {
		// TODO Auto-generated method stub
		return mDao.memberSessionData(userId);
	}

	

	
}
