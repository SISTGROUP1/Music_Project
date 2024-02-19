package com.sist.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Repository;

import com.sist.mapper.MemberMapper;
import com.sist.vo.MemberVO;

@Repository
public class MemberDAO {
	
	@Autowired
	private BCryptPasswordEncoder encoder;
	
	@Autowired
	private MemberMapper mapper;
	
	public int memberIdCount(String userId)
	{
		return mapper.memberIdCount(userId);
	}
	public void memberInsert(MemberVO vo)
	{
		mapper.memberInsert(vo);
	}
	public void memberAuthorityInsert(String userId)
	{
		mapper.memberAuthorityInsert(userId);
	}
	public MemberVO memberLogin(String userId, String userPwd)
	{
		MemberVO dbVO=new MemberVO();
		   int count=mapper.memberIdCount(userId);
		   if(count==0)
		   {
			   dbVO.setMsg("NOID");
		   }
		   else
		   {
			   dbVO=mapper.memberLogin(userId);
			   if(encoder.matches(userPwd, dbVO.getUserPwd()))
			   {
				   dbVO.setMsg("OK");
			   }
			   else
			   {
				   dbVO.setMsg("NOPWD");
			   }
		   }
		   return dbVO;
	}
}
