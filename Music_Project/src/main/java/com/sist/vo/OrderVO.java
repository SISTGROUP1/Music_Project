package com.sist.vo;

import java.util.Date;

import lombok.Data;

@Data
public class OrderVO {
	private int no,clno,amount,price;
	private String userId,dbday;
	private Date regdate;
	private CdlpVO cvo;
}
