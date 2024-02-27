package com.sist.vo;

import lombok.Data;

/*
 *  GNUM                                      NOT NULL NUMBER
 GRANK                                              NUMBER
 GTITLE                                             VARCHAR2(300)
 GENRE                                              VARCHAR2(300)
 GTYPE                                              NUMBER
 ARTIST                                             VARCHAR2(300)
 SONG                                               VARCHAR2(300)
 RANK_CHANGE                                        VARCHAR2(30)
 RANK_VALUE                                         VARCHAR2(50)
 IMAGE                                              VARCHAR2(1000)
 MV                                                 VARCHAR2(6)
 * */
@Data
public class MusicFindVO {
	private int gnum,grank,gtype;
	private String gtitle,genre,artist,song,rank_change,rank_value,image,mv;
	private MyMusicVO vo = new MyMusicVO();
}
