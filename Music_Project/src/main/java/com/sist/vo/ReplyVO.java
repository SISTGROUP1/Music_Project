package com.sist.vo;

import java.util.Date;

import lombok.Data;

@Data
public class ReplyVO {
	private int no,typeno,fno,page;
	private double score;
	private String userId,userName,msg,dbday;
	private Date regdate;
}
