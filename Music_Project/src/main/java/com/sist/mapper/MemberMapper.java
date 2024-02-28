package com.sist.mapper;
import com.sist.vo.*;
import java.util.*;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
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
	
	// 최근 로그인 시간
	@Update("UPDATE musicUserInfo SET "
			+"lastlogin=SYSDATE "
			+"WHERE userId=#{userId}")
	public void lastLoginUpdate(String userId);
	
	// session
	@Select("SELECT mu.userId, userName, gender, birth, email, phone, addr1, addr2, post,  enabled, authority "
			 +"FROM musicUserInfo mu, musicAuthority ma "
			 +"WHERE mu.userId=ma.userId "
			 +"AND mu.userId=#{userId}")
	public MemberVO memberSessionData(String userId);
	
	// 아이디 찾기 (존재유무 확인)
	@Select("SELECT COUNT(*) FROM musicUserInfo "
			+"WHERE userName=#{userName} AND email=#{email}")
	public int idFind(@Param("userName") String userName, @Param("email") String email);
	
	// 아이디 찾기
	@Select("SELECT RPAD(SUBSTR(userId,1,3),LENGTH(userId),'*') FROM musicUserInfo "
			+"WHERE userName=#{userName} AND email=#{email}")
	public String idFindOpen(@Param("userName") String userName, @Param("email") String email);
	
	// 비밀번호 변경
	@Select("UPDATE musicUserInfo SET userPwd=#{userPwd} "
			+"WHERE userId=#{userId} AND email=#{email}")
	public MemberVO pwdChange(@Param("userId") String userId, @Param("email") String email, @Param("userPwd") String userPwd);
	
	// 마이페이지 수정
	@Update("UPDATE musicUserInfo SET "
			+"userName=#{userName}, birth=#{birth}, email=#{email}, addr1=#{addr1}, addr2=#{addr2} "
			+"WHERE userId=#{userId}")
	public void userInfoUpdate(MemberVO vo);
	
	// 회원 탈퇴
	@Delete("DELETE FROM musicUserInfo "
			+"WHERE userId=#{userId}")
	public String userInfoDelete(String userId);
	
	// 관리자 회원리스트 출력
	@Select("SELECT mu.userId, userName, gender, email "
			+"FROM musicUserInfo mu, musicAuthority ma "
			+"WHERE mu.userId=ma.userId "
			+"AND ma.authority='ROLE_USER'")
	public List<MemberVO> userListData();
}







