package com.sist.mapper;
import java.util.*;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.sist.vo.MusicNewsVO;
public interface MusicNewsMapper {
	// 카테고리 별 리스트 출력
	@Select("SELECT no, cateno, title, regdate, poster, poster2, content, num "
			+"FROM (SELECT no, cateno, title, regdate, poster, poster2, content, rownum as num "
			+"FROM (SELECT no, cateno, title, regdate, poster, poster2, content "
			+"FROM musicNews WHERE cateno=#{cateno} ORDER BY no ASC)) "
			+"WHERE num BETWEEN #{start} AND #{end}")
	public List<MusicNewsVO> musicNewsData(@Param("start") int start, @Param("end") int end, @Param("cateno") int cateno);
	
	// 총페이지
	@Select("SELECT CEIL(COUNT(*)/12.0) FROM musicNews WHERE cateno=#{cateno}")
	public int musicNewsTotalPage(int cateno);
	
	// 디테일
	@Select("SELECT no, cateno, title, regdate, poster, poster2, content "
			+"FROM musicNews "
			+"WHERE no=#{no}")
	public MusicNewsVO musicNewsDetailData(int no);
	
	// home 출력용
	@Select("SELECT no, title, regdate, poster "
			+"FROM (SELECT no, title, regdate, poster "
			+"FROM musicNews ORDER BY no ASC) "
			+"WHERE no<=3")
	public List<MusicNewsVO> musicNews3();
}
