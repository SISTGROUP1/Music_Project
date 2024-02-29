package com.sist.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import com.sist.vo.ReplyVO;

public interface ReplyMapper {
	// 댓글 목록
	@Select("SELECT no,userId,userName,typeno,fno,score,msg,TO_CHAR(regdate,'YYYY-MM-DD') as dbday,num "
			+ "FROM (SELECT no,userId,userName,typeno,fno,score,msg,regdate,rownum as num "
			+ "FROM (SELECT /*+ INDEX_DESC(all_reply ar_no_pk)*/no,userId,userName,typeno,fno,score,msg,regdate "
			+ "FROM All_reply "
			+ "WHERE typeno=#{typeno} AND fno=#{fno})) "
			+ "WHERE num BETWEEN #{start} AND #{end}")
	public List<ReplyVO> replyListData(Map map);
	// 댓글 총 갯수
	@Select("SELECT COUNT(*) "
			+ "FROM All_reply "
			+ "WHERE typeno=#{typeno} AND fno=#{fno}")
	public int replyTotalCnt(@Param("typeno") int typeno,@Param("fno") int fno);
	
	// 댓글 추가
	@Insert("INSERT INTO All_reply "
			+ "VALUES(ar_no_seq.nextval,#{userId},#{userName},#{typeno},#{fno},#{score},#{msg},SYSDATE)")
	public void replyInsert(ReplyVO vo);
	// 댓글 수정
	@Update("UPDATE All_reply SET "
			+ "msg=#{msg} "
			+ "WHERE typeno=#{typeno} AND no=#{no}")
	public void replyUpdate(ReplyVO vo);
	// 댓글 삭제
	@Delete("DELETE FROM All_reply "
			+ "WHERE typeno=#{typeno} AND no=#{no}")
	public void replyDelete(ReplyVO vo);
	
	// 공연 댓글
		// 목록 
		  @Select("SELECT no,typeno,fno,userId,userName,msg,TO_CHAR(regdate,'YYYY-MM-DD HH24:MI:SS') as dbday "
				 +"FROM all_reply "
				 +"WHERE fno=#{fno} AND typeno=5"
				 +"ORDER BY no DESC")
		  public List<ReplyVO> showreplyListData(int sno);
		  
		  @Select("SELECT COUNT(*) FROM all_reply "
				  +"WHERE typeno=5 AND fno=#{fno}")
		  public int countshowreview(int sno);
		  
		  // 추가 
		  @Insert("INSERT INTO all_reply(no,typeno,fno,userId,userName,msg) "
				 +"VALUES(ar_no_seq.nextval,#{typeno},#{fno},#{userId},#{userName},#{msg})")
		  public void showreplyInsert(ReplyVO vo);
}
