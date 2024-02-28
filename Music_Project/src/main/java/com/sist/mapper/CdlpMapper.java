package com.sist.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.sist.vo.CdlpVO;

public interface CdlpMapper {
	// 메인화면 상품 목록
	@Select("SELECT no,poster,subject,rownum "
			+ "FROM (SELECT no,poster,subject "
			+ "FROM cdlp "
			+ "ORDER BY regdate DESC) "
			+ "WHERE rownum<=8")
	public List<CdlpVO> cdlpListData_Home();
	// 카테고리
	@Select("SELECT genre,sub_genre "
			+ "FROM cdlp "
			+ "GROUP BY genre,sub_genre "
			+ "ORDER BY genre,sub_genre")
	public List<CdlpVO> cdlpCateList();
	// CD/LP 카테고리별 상품 목록(정렬순)
	public List<CdlpVO> cdlpListData_Sort(Map map);
	// CD/LP 카테고리별 상품 목록(판매량순)
	@Select("SELECT no,poster,subject,artist,publisher,TO_CHAR(regdate,'YYYY-MM-DD') as dbday,saleprice,discount,score,inventory,num "
			+ "FROM (SELECT no,poster,subject,artist,publisher,regdate,saleprice,discount,score,inventory,rownum as num "
			+ "FROM (SELECT no,poster,subject,artist,publisher,regdate,saleprice,discount,score,inventory "
			+ "FROM cdlp JOIN Order "
			+ "ON cdlp.no=Order.clno "
			+ "WHERE genre=#{genre} AND sub_genre=#{sub_genre} "
			+ "ORDER BY no DESC)) "
			+ "WHERE num BETWEEN #{start} AND #{end}")
	public List<CdlpVO> cdlpListData_Sales(Map map);
	// CD/LP 카테고리별 상품 목록(신상품순)
	@Select("SELECT no,poster,subject,artist,publisher,TO_CHAR(regdate,'YYYY-MM-DD') as dbday,saleprice,discount,score,inventory,num "
			+ "FROM (SELECT no,poster,subject,artist,publisher,regdate,saleprice,discount,score,inventory,rownum as num "
			+ "FROM (SELECT no,poster,subject,artist,publisher,regdate,saleprice,discount,score,inventory "
			+ "FROM cdlp "
			+ "WHERE genre=#{genre} AND sub_genre=#{sub_genre} "
			+ "ORDER BY regdate DESC)) "
			+ "WHERE num BETWEEN #{start} AND #{end}")
	public List<CdlpVO> cdlpListData_Recent(Map map);
	// CD/LP 카테고리별 상품 목록(최저가순)
	@Select("SELECT no,poster,subject,artist,publisher,TO_CHAR(regdate,'YYYY-MM-DD') as dbday,saleprice,discount,score,inventory,num "
			+ "FROM (SELECT no,poster,subject,artist,publisher,regdate,saleprice,discount,score,inventory,rownum as num "
			+ "FROM (SELECT no,poster,subject,artist,publisher,regdate,saleprice,discount,score,inventory "
			+ "FROM cdlp "
			+ "WHERE genre=#{genre} AND sub_genre=#{sub_genre} "
			+ "ORDER BY saleprice)) "
			+ "WHERE num BETWEEN #{start} AND #{end}")
	public List<CdlpVO> cdlpListData_LowPrice(Map map);
	// CD/LP 카테고리별 상품 목록(최고가순)
	@Select("SELECT no,poster,subject,artist,publisher,TO_CHAR(regdate,'YYYY-MM-DD') as dbday,saleprice,discount,score,inventory,num "
			+ "FROM (SELECT no,poster,subject,artist,publisher,regdate,saleprice,score,discount,inventory,rownum as num "
			+ "FROM (SELECT no,poster,subject,artist,publisher,regdate,saleprice,score,discount,inventory "
			+ "FROM cdlp "
			+ "WHERE genre=#{genre} AND sub_genre=#{sub_genre} "
			+ "ORDER BY saleprice DESC)) "
			+ "WHERE num BETWEEN #{start} AND #{end}")
	public List<CdlpVO> cdlpListData_HighPrice(Map map);
	// CD/LP 카테고리별 상품 목록 총페이지
	public int cdlpListTotalPage(CdlpVO vo);
	// CD/LP 상세보기
	@Select("SELECT no,poster,subject,artist,publisher,TO_CHAR(regdate,'YYYY-MM-DD') as dbday,price,saleprice,discount,genre,sub_genre,content,image,inventory,score "
			+ "FROM cdlp "
			+ "WHERE no=#{no}")
	public CdlpVO cdlpDetailData(int no);
	// 판매량순
	@Select("SELECT clno,poster,rownum "
			+ "FROM (SELECT clno,COUNT(*) as inventory,poster "
			+ "FROM music_order JOIN cdlp "
			+ "ON music_order.clno=cdlp.no "
			+ "GROUP BY clno,poster "
			+ "ORDER BY inventory DESC) "
			+ "WHERE rownum<=6")
	public List<CdlpVO> cdlpSalesTop6();
	// Score 조회
	@Select("SELECT ((SELECT SUM(score) FROM All_reply "
			+ "WHERE typeno=1 AND fno=#{fno})/(SELECT COUNT(*) FROM All_reply "
			+ "WHERE typeno=1 AND fno=#{fno})) as score FROM dual")
	public double cdlpScore(int fno);
	// Score 변경
	@Update("UPDATE cdlp SET "
			+ "score=${score} "
			+ "WHERE no=#{no}")
	public void cdlpScoreUpdate(@Param("score") double score,@Param("no") int no);
}
