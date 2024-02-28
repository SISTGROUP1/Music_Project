package com.sist.vo;

/*
  shows[i].setScate(Integer.parseInt(st.nextToken()));
  shows[i].setSdetail(st.nextToken());
  shows[i].setSposter(st.nextToken());
  shows[i].setStitle(st.nextToken());
  shows[i].setSdate(st.nextToken());
  shows[i].setSloc(st.nextToken());
  shows[i].setSgrade(st.nextToken());
  shows[i].setShour(st.nextToken());
  shows[i].setSperformer(st.nextToken());
  shows[i].setSseat(st.nextToken());
  shows[i].setStime(st.nextToken());
  shows[i].setSdelivery(st.nextToken());
  shows[i].setSdeposter(st.nextToken());
  shows[i].setSdeloc(st.nextToken());
  shows[i].setSaddress(st.nextToken());
  shows[i].setSphone(st.nextToken());
 */
import java.util.*;

import lombok.Data;

@Data
public class ShowVO {
	private int hit;
	private int sno,scate;
	private String sdetail,sposter,stitle,sdate,sloc,sgrade,shour,sperformer,sseat,stime,sdelivery,sdeposter,sdeloc,saddress,sphone;
}
