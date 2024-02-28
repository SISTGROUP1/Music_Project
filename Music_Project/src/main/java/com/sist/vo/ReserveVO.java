package com.sist.vo;

import java.util.*;
import lombok.Data;

@Data
public class ReserveVO {
   private int srno,sno,reserve_ok,rSeat;
   private String userId,rDate,rTime,rInwon,dbday;
   private Date regdate;
   private ShowVO svo=new ShowVO();
}