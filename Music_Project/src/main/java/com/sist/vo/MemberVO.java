package com.sist.vo;

import java.util.Date;

import lombok.Data;

@Data
public class MemberVO {
	private int enabled;
	private String userId, userName, userPwd, gender, birth, email, post, addr1, addr2, phone, content, reg_dbday, phone1, phone2, phone3;
	private Date regdate;
	private String authority, msg;
}
