package com.sist.mapper;
import java.util.*;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.sist.vo.LikeVO;
import com.sist.vo.MusicFindVO;
import com.sist.vo.MusicVideoVO;
import com.sist.vo.MyMusicVO;
import com.sist.vo.ReplyVO;
import com.sist.vo.SubreplyVO;

public interface MusicFindMapper {
	@Select("SELECT grank,artist,song,image,rank_change,rank_value,num "
			+ "FROM (SELECT grank,artist,song,image,rank_change,rank_value,rownum as num "
			+ "FROM (SELECT grank,artist,song,image,rank_change,rank_value "
			+ "FROM gmusicfind WHERE gtype=#{gtype} ORDER BY grank)) "
			+ "WHERE num <=10")
	public List<MusicFindVO> gmusicTop10(int gtype);
	
	@Select("SELECT gnum,gtitle,grank,artist,song,image,rank_change,rank_value,mv,num "
			+ "FROM (SELECT gnum,gtitle,grank,artist,song,image,rank_change,rank_value,mv,rownum as num "
			+ "FROM (SELECT gnum,gtitle,grank,artist,song,image,rank_change,rank_value,mv "
			+ "FROM gmusicfind WHERE gtype=#{gtype} ORDER BY grank)) "
			+ "WHERE num BETWEEN #{start} ANd #{end}")
	public List<MusicFindVO> gmusicList1(Map map);
	
	@Select("SELECT gnum,gtitle,grank,artist,song,image,rank_change,rank_value,mv,num "
			+ "FROM (SELECT gnum,gtitle,grank,artist,song,image,rank_change,rank_value,mv,rownum as num "
			+ "FROM (SELECT gnum,gtitle,grank,artist,song,image,rank_change,rank_value,mv "
			+ "FROM gmusicfind WHERE gtype=#{gtype} AND genre=#{genre} ORDER BY grank)) "
			+ "WHERE num BETWEEN #{start} ANd #{end}")
	public List<MusicFindVO> gmusicListOther(Map map);
	
	@Select("SELECT CEIL(COUNT(*)/30) FROM gmusicfind "
			+ "WHERE gtype=#{gtype} AND genre=#{genre}")
	public int gmusicTotalPage(Map map);
	
	@Select("SELECT mnum,link,lyric,regdate,tag "
			+ "FROM gmusicdetail "
			+ "WHERE gnum=#{gnum}")
	public MusicVideoVO gmusicVideoDetail(int gnum);
	
	@Select("SELECT gtitle,artist,song "
			+ "FROM gmusicfind "
			+ "WHERE gnum=#{gnum}")
	public MusicFindVO gmusicArtistDetail(int gnum);
	
	@Select("SELECT DISTINCT GENRE FROM GMUSICFIND WHERE gtype=#{gtype}")
	public List<MusicFindVO> gmusicTypeFind(int gtype);
	
	@Select("SELECT gnum,gtitle,artist,song,image,num "
			+ "FROM (SELECT gnum,gtitle,artist,song,image,rownum as num "
			+ "FROM (SELECT gnum,gtitle,artist,song,image "
			+ "FROM gmusicfind WHERE gnum in(SELECT gnum FROM gmusicdetail "
			+ "WHERE REGEXP_LIKE(tag,#{tag})) ORDER BY gnum"
			+ ")) WHERE num BETWEEN #{start} AND #{end}")
	public List<MusicFindVO> gmusictagFind(Map map);
	
	@Select("SELECT CEIL(COUNT(*)/8) FROM gmusicdetail "
			+ "WHERE REGEXP_LIKE(tag,#{tag})")
	public int gmusictagTotalPage(String tag);
	
	@Select("SELECT COUNT(*) FROM ALL_LIKE "
			+ "WHERE typeno=#{typeno} AND fno=#{fno} AND pno=#{pno}")
	public int gmusicAllLikeCount(LikeVO vo);
	
	@Select("SELECT COUNT(*) FROM ALL_LIKE "
			+ "WHERE typeno=#{typeno} AND fno=#{fno} AND pno=#{pno} AND userid=#{userId}")
	public int gmusicLikeCount(LikeVO vo);
	
	@Insert("INSERT INTO ALL_LIKE(no,userid,typeno,fno,pno) VALUES(al_no_seq.nextval,#{userId},#{typeno},#{fno},#{pno})")
	public void gmusicLikeInsert(LikeVO vo);
	
	@Delete("DELETE FROM ALL_LIKE WHERE typeno=#{typeno} AND fno=#{fno} AND pno=#{pno} AND userid=#{userId}")
	public void gmusicLikeDelete(LikeVO vo);
	// 목록 불러오기
	@Select("SELECT no,userid,msg,TO_CHAR(regdate,'YYYY-MM-DD') as dbday,num "
			+ "FROM (SELECT no,userid,msg,regdate,rownum as num "
			+ "FROM (SELECT no,userid,msg,regdate "
			+ "FROM all_reply WHERE typeno=#{typeno} AND fno=#{fno} ORDER BY no DESC)) "
			+ "WHERE num BETWEEN #{start} AND #{end}")
	public List<ReplyVO> gmusicDetailReply(Map map);
	
	@Select("SELECT CEIL(COUNT(*)/10) FROM ALL_REPLY "
			+ "WHERE typeno=#{typeno} AND fno=#{fno}")
	public int gmusicDetailReplyAllCount(Map map);
	
	@Select("SELECT msg FROM ALL_REPLY "
			+ "WHERE no=#{no}")
	public String gmusicReplyMsg(int no);
	
	// 댓글 쓰기
	@Insert("INSERT INTO ALL_REPLY(no,userid,username,typeno,fno,msg,regdate) "
			+ "VALUES(ar_no_seq.nextval,#{userId},(SELECT username FROM musicUserInfo WHERE userId=#{userId}),#{typeno},#{fno},#{msg},SYSDATE)")
	public void gmusicDetailReplyInsert(Map map);
	// 댓글 수정
	@Update("UPDATE ALL_REPLY SET msg=#{msg} "
			+ "WHERE no=#{no}")
	public void gmusicDetailReplyUpdate(Map map);
	// 댓글 삭제
	@Delete("DELETE FROM ALL_REPLY WHERE no=#{no}")
	public void gmusicDetailReplyDelete(int no);
	//댓글 삭제 전 대댓 삭제
	@Delete("DELETE FROM ALL_SUBREPLY WHERE no=#{no}")
	public void gmusicDetailReplysubDelete(int no);
	
	//대댓글 넣기
	@Insert("INSERT INTO All_SUBREPLY(sno,no,userId,typeno,fno,msg,regdate) "
			+ "VALUES(asr_sno_seq.nextval,#{no},#{userId},#{typeno},#{fno},#{msg},SYSDATE)")
	public void gmusicDetailsubReplyInsert(SubreplyVO vo);
	
	//대댓글 확인
	@Select("SELECT sno,no,userId,msg,TO_CHAR(regdate,'YYYY-MM-DD') as dbday FROM "
			+ "ALL_SUBREPLY WHERE no=#{no} AND typeno=#{typeno} AND fno=#{fno} "
			+ "ORDER BY regdate")
	public List<SubreplyVO> gmusicDetailsubReplySelect(SubreplyVO vo);
	
	@Delete("DELETE FROM ALL_SUBREPLY WHERE sno=#{sno}")
	public void gmusicSubreplyDelete(int sno);
	
	@Insert("INSERT INTO GMyMusic(num,userId,gnum) VALUES(gmm_gnum_seq.nextval,#{userId},#{gnum})")
	public void MyMusicInsert(MyMusicVO vo);
	
	@Results({@Result(property = "vo.num",column = "num")})
	@Select("SELECT gm.GNUM,ARTIST,SONG,IMAGE,num FROM GMUSICFIND gm JOIN GMYMUSIC g ON gm.GNUM = g.GNUM WHERE userId=#{userId} ORDER BY num")
	public List<MusicFindVO> MyMusicList(String userId);
	
	@Delete("DELETE FROM GMYMUSIC WHERE num=#{num}")
	public void MyMusicDelete(int num);
	
	@Select("SELECT gnum,image,num FROM (SELECT gnum,image,rownum AS num FROM GMUSICFIND WHERE mv='뮤비' ORDER BY gnum) WHERE num BETWEEN 1 AND 6")
	public List<MusicFindVO> footerMV();
	
	@Select("SELECT gnum,artist,song,image,num "
			+ "FROM (SELECT gnum,artist,song,image,rownum as num "
			+ "FROM (SELECT gnum,artist,song,image "
			+ "FROM gmusicfind WHERE REGEXP_LIKE(artist,#{search}) ORDER BY gnum)) "
			+ "WHERE num BETWEEN #{start} AND #{end}")
	public List<MusicFindVO> searchArtist(Map map);
	
	@Select("SELECT CEIL(COUNT(*)/8) FROM gmusicfind WHERE REGEXP_LIKE(artist,#{search})")
	public int searchTotalPage(String search);
}
