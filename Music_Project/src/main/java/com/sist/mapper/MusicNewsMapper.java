package com.sist.mapper;
import java.util.*;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.sist.vo.MusicNewsVO;
public interface MusicNewsMapper {
	@Select("SELECT no, cateno, title, regdate, poster, poster2, content, num "
			+"FROM (SELECT no, cateno, title, regdate, poster, poster2, content, rownum as num "
			+"FROM (SELECT no, cateno, title, regdate, poster, poster2, content "
			+"FROM musicNews ORDER BY no ASC)) "
			+"WHERE num BETWEEN #{start} AND #{end}")
	public List<MusicNewsVO> musicNewsData(@Param("start") int start, @Param("end") int end);
	
	@Select("SELECT CEIL(COUNT(*)/12.0) FROM musicNews")
	public int musicNewsTotalPage();
}
