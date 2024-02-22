package com.sist.vo;
import java.util.*;
import lombok.Data;
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

@Data
public class MusicBoardVO {
	private int no, typeno, filecount, hit, group_id, group_tab, group_step, root, depth;
	private String userId, title, name, content, filename, filesize, pwd, dbday;
	private Date regdate;
}
