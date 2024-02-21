package com.sist.vo;

import lombok.Data;

@Data
public class SessionInfo {
	// 사이트에서 필요한 정보를 다 가져다 놓는다.
	private String userId;
	private String userName;
	private String email;
	private String phone;
	private String address;
	private String gender;
	private String birth;
}
