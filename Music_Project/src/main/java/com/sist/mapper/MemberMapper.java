package com.sist.mapper;
import com.sist.vo.*;
import java.util.*;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
public interface MemberMapper {
	// 유저수 카운트 (ID 존재여부 확인 시 사용)
	@Select("SELECT COUNT(*) FROM musicUserInfo "
			+"WHERE userId=#{userId}")
	public int memberIdCount(String userId);
	
	// 회원가입
	@Insert("INSERT INTO musicUserInfo(userId, userName, userPwd, gender, birth,"
			+"email, post, addr1, addr2, phone) VALUES(#{userId}, #{userName},"
			+"#{userPwd}, #{gender}, #{birth}, #{email}, #{post},"
			+"#{addr1}, #{addr2}, #{phone})")
	public void memberInsert(MemberVO vo);
	
	@Insert("INSERT INTO musicAuthority VALUES(#{userId}, 'ROLE_USER')")
	public void memberAuthorityInsert(String userId);
	
	// 로그인 - 비밀번호 검색
	@Select("SELECT mu.userId, userName, userPwd, enabled, authority "
			+"FROM musicUserInfo mu, musicAuthority ma "
			+"WHERE mu.userId=ma.userId "
			+"AND mu.userId=#{userId}")
	public MemberVO memberLogin(String userId);
}
