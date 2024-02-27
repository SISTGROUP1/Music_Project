package com.sist.vo;

import lombok.Data;

@Data
public class CartVO {
	private int no,clno,amount;
	private String userId;
	private CdlpVO cvo;
}
