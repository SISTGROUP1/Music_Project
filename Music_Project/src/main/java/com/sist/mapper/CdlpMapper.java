package com.sist.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

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
	// CD/LP메인 최신 상품 목록
//	@Select("SELECT no,poster,subject,TO_CHAR(regdate,'YYYY-MM-DD') as dbday,saleprice,num "
//			+ "FROM (SELECT no,poster,subject,regdate,saleprice,rownum as num "
//			+ "FROM (SELECT no,poster,subject,regdate,saleprice "
//			+ "FROM cdlp "
//			+ "ORDER BY regdate DESC)) "
//			+ "WHERE num BETWEEN #{start} AND #{end}")
//	public List<CdlpVO> cdlpListData_RecentM(@Param("start") int start,@Param("end") int end);
	// 요즘 뜨는 상품 목록
	// 대분류별로 주문내역날짜(일주일간) 판매량(clno)건수가 높은순으로 출력
//	@Select("SELECT no,poster,subject,saleprice,num "
//			+ "FROM (SELECT no,poster,subject,saleprice,rownum as num "
//			+ "FROM (SELECT no,poster,subject,saleprice "
//			+ "FROM cdlp JOIN Order "
//			+ "ON cdlp.no=Order.clno "
//			+ "WHERE regdate BETWEEN SYSDATE-7 AND SYSDATE "
//			+ "ORDER BY no DESC)) "
//			+ "WHERE num BETWEEN 1 AND 18")
//	public List<CdlpVO> cdlpListData_Rising();
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
	@Select("SELECT no,poster,subject,artist,publisher,TO_CHAR(regdate,'YYYY-MM-DD') as dbday,price,saleprice,discount,genre,sub_genre,content,image,inventory "
			+ "FROM cdlp "
			+ "WHERE no=#{no}")
	public CdlpVO cdlpDetailData(int no);
}
