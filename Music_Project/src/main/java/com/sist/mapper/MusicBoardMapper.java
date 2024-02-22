package com.sist.mapper;
import java.util.*;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.sist.vo.*;
/*
NO         NOT NULL NUMBER         
USERID              VARCHAR2(20)   
TYPENO     NOT NULL NUMBER         
TITLE      NOT NULL VARCHAR2(1000) 
NAME       NOT NULL VARCHAR2(51)   
CONTENT    NOT NULL CLOB           
REGDATE             DATE           
FILENAME            VARCHAR2(1000) 
FILESIZE            VARCHAR2(1000) 
FILECOUNT           NUMBER         
PWD        NOT NULL VARCHAR2(20)   
HIT                 NUMBER         
GROUP_ID            NUMBER         
GROUP_TAB           NUMBER         
GROUP_STEP          NUMBER         
ROOT                NUMBER         
DEPTH               NUMBER   
*/
//<c:set var="count" value=${count}/>
//<c:set var="count" value=${count-1}/>
public interface MusicBoardMapper {
	// 카테고리 별 리스트 출력
	@Select("SELECT no, typeno, title, name, TO_CHAR(regdate, 'YYYY-MM-DD') as dbday, hit, pwd, num "
			+"FROM (SELECT no, typeno, title, name, regdate, hit, pwd, rownum as num "
			+"FROM (SELECT no, typeno, title, name, regdate, hit, pwd "
			+"FROM musicBoard WHERE typeno=#{typeno} ORDER BY no DESC)) "
			+"WHERE num BETWEEN #{start} AND #{end}")
	public List<MusicBoardVO> boardListData(@Param("start") int start, @Param("end") int end, @Param("typeno") int typeno);
	
	// 리스트 총페이지
	@Select("SELECT CEIL(COUNT(*)/12.0) FROM musicBoard WHERE typeno=#{typeno}")
	public int boardTotalPage(int typeno);
	
	// notice 새 글 작성
	//@Insert("INSERT INTO musicBoard(no, userId, typeno, title, name, content, regdate, hit, pwd, filename, filesize, filecount) "
	//		+"VALUES(mb_no_seq.nextval, 'shin', 2, #{title}, #{name}, #{content}, SYSDATE, 0, #{pwd}, #{filename}, #{filesize}, #{filecount})")
    //public void noticeInsert(MusicBoardVO vo);
	@Insert("INSERT INTO musicBoard(no, typeno, title, name, content, regdate, hit, pwd) "
			+"VALUES(mb_no_seq.nextval, 2, #{title}, #{name}, #{content}, SYSDATE, 0, #{pwd})")
	public void noticeInsert(MusicBoardVO vo);
	
	// question 새 글 작성
	@Insert("INSERT INTO musicBoard(no, typeno, title, name, content, regdate, hit, pwd) "
			+"VALUES(mb_no_seq.nextval, 3, #{title}, #{name}, #{content}, SYSDATE, 0, #{pwd})")
    public void questionInsert(MusicBoardVO vo);
	
	// schand 새 글 작성
	@Insert("INSERT INTO musicBoard(no, typeno, title, name, content, regdate, hit, pwd) "
			+"VALUES(mb_no_seq.nextval, 4, #{title}, #{name}, #{content}, SYSDATE, 0, pwd)")
    public void schandInsert(MusicBoardVO vo);
   
    // 상세보기 (조회수 증가)
    @Update("UPDATE musicBoard SET "
		    +"hit=hit+1 "
		    +"WHERE no=#{no}")
    public void hitIncrement(int no);
   
    @Select("SELECT no, title, name, content, TO_CHAR(regdate,'YYYY-MM-DD') as dbday, hit, filename, filesize, filecount "
		    +"FROM musicBoard "
		    +"WHERE no=#{no}")
    public MusicBoardVO boardDetailData(int no);
    
    // 삭제 (파일)
    @Select("SELECT filename,filecount "
 		  +"FROM musicBoard "
 		  +"WHERE no=#{no}")
    public MusicBoardVO databoardFileInfoData(int no);
    
    // 삭제
    @Select("SELECT pwd FROM musicBoard "
 		  +"WHERE no=#{no}")
    public String databoardGetPassword(int no);
    
    @Delete("DELETE FROM musicBoard "
 		  +"WHERE no=#{no}")
    public void databoardDelete(int no);
    
    // 수정 
    @Update("UPDATE musicBoard SET "
 		  +"name=#{name}, title=#{title}, content=#{content} "
 		  +"WHERE no=#{no}")
    public void databoardUpdate(MusicBoardVO vo);
  
}























