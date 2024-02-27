package com.sist.vo;
import java.util.*;

import lombok.Data;

@Data
public class SubreplyVO {
	private int sno,no,typeno,fno;
	private String userId,msg,dbday;
	private Date regdate;
}
