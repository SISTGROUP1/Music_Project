package com.sist.vo;

import java.util.Date;

import lombok.Data;

@Data
public class CdlpVO {
	private int no,price,saleprice,discount,inventory,listType;
	private double score;
	private String poster,subject,content,image,artist,publisher,dbday,genre,sub_genre;
	private Date regdate;
}
