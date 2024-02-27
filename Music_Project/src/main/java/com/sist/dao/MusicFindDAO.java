package com.sist.dao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.mapper.MusicFindMapper;
import com.sist.vo.LikeVO;
import com.sist.vo.MusicFindVO;
import com.sist.vo.MusicVideoVO;
import com.sist.vo.MyMusicVO;
import com.sist.vo.ReplyVO;
import com.sist.vo.SubreplyVO;

@Repository
public class MusicFindDAO {
	@Autowired
	private MusicFindMapper mapper;
	public List<MusicFindVO> gmusicTop10(int gtype){
		return mapper.gmusicTop10(gtype);
	}
	public List<MusicFindVO> gmusicList1(Map map){
		return mapper.gmusicList1(map);
	}
	public int gmusicTotalPage(Map map) {
		return mapper.gmusicTotalPage(map);
	}
	
	public List<MusicFindVO> gmusicListOther(Map map){
		return mapper.gmusicListOther(map);
	}
	public MusicVideoVO gmusicVideoDetail(int gnum) {
		return mapper.gmusicVideoDetail(gnum);
	}
	public MusicFindVO gmusicArtistDetail(int gnum) {
		return mapper.gmusicArtistDetail(gnum);
	}
	public List<MusicFindVO> gmusicTypeFind(int gtype) {
		return mapper.gmusicTypeFind(gtype);
	}
	public List<MusicFindVO> gmusictagFind(Map map){
		return mapper.gmusictagFind(map);
	}
	public int gmusictagTotalPage(String tag) {
		return mapper.gmusictagTotalPage(tag);
	}
	public int gmusicLikeCount(LikeVO vo) {
		return mapper.gmusicLikeCount(vo);
	}
	public int gmusicAllLikeCount(LikeVO vo) {
		return mapper.gmusicAllLikeCount(vo);
	}
	public void gmusicLikeInsert(LikeVO vo) {
		mapper.gmusicLikeInsert(vo);
	}
	public void gmusicLikeDelete(LikeVO vo) {
		mapper.gmusicLikeDelete(vo);
	}
	public List<ReplyVO> gmusicDetailReply(Map map){
		return mapper.gmusicDetailReply(map);
	}
	public int gmusicDetailReplyAllCount(Map map) {
		return mapper.gmusicDetailReplyAllCount(map);
	}
	public void gmusicDetailReplyInsert(Map map) {
		mapper.gmusicDetailReplyInsert(map);
	}
	public void gmusicDetailReplyUpdate(Map map) {
		mapper.gmusicDetailReplyUpdate(map);
	}
	public void gmusicDetailReplyDelete(int no) {
		mapper.gmusicDetailReplysubDelete(no);
		mapper.gmusicDetailReplyDelete(no);
	}
	public String gmusicReplyMsg(int no) {
		return mapper.gmusicReplyMsg(no);
	}
	public void gmusicDetailsubReplyInsert(SubreplyVO vo) {
		mapper.gmusicDetailsubReplyInsert(vo);
	}
	public List<SubreplyVO> gmusicDetailsubReplySelect(SubreplyVO vo){
		return mapper.gmusicDetailsubReplySelect(vo);
	}
	public void gmusicSubreplyDelete(int sno) {
		mapper.gmusicSubreplyDelete(sno);
	}
	public void MyMusicInsert(MyMusicVO vo) {
		mapper.MyMusicInsert(vo);
	}
	public List<MusicFindVO> MyMusicList(String userId){
		return mapper.MyMusicList(userId);
	}
	public void MyMusicDelete(int num) {
		mapper.MyMusicDelete(num);
	}
}
