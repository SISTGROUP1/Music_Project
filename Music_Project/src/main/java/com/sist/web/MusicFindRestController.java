package com.sist.web;
import java.security.Principal;
import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.manager.WeatherManager;
import com.sist.service.MemberService;
import com.sist.service.MusicFindService;
import com.sist.vo.LikeVO;
import com.sist.vo.MemberVO;
import com.sist.vo.MusicFindVO;
import com.sist.vo.MusicVideoVO;
import com.sist.vo.MyMusicVO;
import com.sist.vo.ReplyVO;
import com.sist.vo.SubreplyVO;
import com.sist.vo.WeatherVO;


@RestController
@RequestMapping("musicfind/")
public class MusicFindRestController {
	@Autowired
	private MusicFindService service;
	
	@Autowired
	private WeatherManager mgr;
	
	@GetMapping(value = "musicfind_cate1_vue.do",produces = "text/plain;charset=UTF-8")
	public String music_Top200_all(int start,int end,int cate) throws Exception{
		Map map = new HashMap();
		map.put("gtype", cate);
		map.put("start", start);
		map.put("end", end);
		
		List<MusicFindVO> list = service.gmusicList1(map);
		map = new HashMap();
		map.put("list", list);
		
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(map);
		
		return json;
	}
	
	@GetMapping(value = "musicfind_cateAll_vue.do",produces = "text/plain;charset=UTF-8")
	public String music_cateAll(int cate,int page,String genre) throws Exception{
		Map map = new HashMap();
		int rowSize = 30;
		int start = (rowSize*page)-(rowSize-1);
		int end = (rowSize*page);
		map.put("start", start);
		map.put("end", end);
		map.put("gtype", cate);
		map.put("genre", genre);
		
		List<MusicFindVO> list = service.gmusicListOther(map);
		map = new HashMap();
		map.put("gtype", cate);
		map.put("genre", genre);
		int totalpage = service.gmusicTotalPage(map);
		
		final int BLOCK = 10;
		int startPage = ((page-1)/BLOCK*BLOCK)+1;
		int endPage = ((page-1)/BLOCK*BLOCK)+BLOCK;
		if(endPage>totalpage) endPage=totalpage;
		
		map = new HashMap();
		map.put("gmList", list);
		map.put("curpage",page);
		map.put("startPage", startPage);
		map.put("endPage", endPage);
		map.put("totalpage", totalpage);
		map.put("gtype", cate);
		map.put("genre", genre);
		
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(map);
		
		return json;
	}
	
	@GetMapping(value = "mvdetailfind.do" , produces = "text/plain;charset=UTF-8")
	public String musicvideoFind(int gnum,int page,Principal p) throws Exception{
		MusicVideoVO vo = service.gmusicVideoDetail(gnum);
		//댓글 정보 입력
		final int ROWSIZE = 10;
		int start = (ROWSIZE*page)-(ROWSIZE-1);
		int end = (ROWSIZE*page);
		
		Map map = new HashMap();
		map.put("typeno", 0);
		map.put("fno", gnum);
		int totalpage = service.gmusicDetailReplyAllCount(map);
		map.put("start", start);
		map.put("end", end);
		
		List<ReplyVO> Rvo = service.gmusicDetailReply(map);
		
		final int BLOCK = 10;
		int startPage = ((page-1)/BLOCK*BLOCK)+1;
		int endPage = ((page-1)/BLOCK*BLOCK)+BLOCK;
		if(endPage>totalpage) endPage=totalpage;
		
		LikeVO Lvo = new LikeVO();
		Lvo.setTypeno(0);
		Lvo.setFno(0);
		Lvo.setPno(gnum);
		String user = "";
		int nowLike = 0;
		try {
			user = p.getName();
			Lvo.setUserId(user);
			nowLike = service.gmusicLikeCount(Lvo);
		} catch (Exception e) {
			// TODO: handle exception
			user = null;
			nowLike = 0;
		}
		int AllLike = service.gmusicAllLikeCount(Lvo);
		
		String link = vo.getLink();
		vo.setLink(link.substring(link.indexOf("?v=")+3,link.lastIndexOf("&pp")));
		
		map = new HashMap();
		map.put("vo", vo);
		map.put("allLike", AllLike);
		map.put("nowLike", nowLike);
		map.put("Rvo", Rvo);
		map.put("curpage", page);
		map.put("totalpage", totalpage);
		map.put("startPage", startPage);
		map.put("endPage", endPage);
		
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(map);
		
		return json;
	}
	
	@GetMapping(value = "mvArtistDetail_vue.do", produces = "text/plain;charset=UTF-8")
	public String musicArtistDetail(int gnum) throws Exception{
		MusicFindVO vo = service.gmusicArtistDetail(gnum);
		
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(vo);
		
		return json;
	}
	@GetMapping(value="musicfind_gtype_vue.do",produces = "text/plain;charset=UTF-8")
	public String musicFindGtypeData(int cate) throws Exception{
		
		List<MusicFindVO> list = service.gmusicTypeFind(cate);
		
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(list);
		
		return json;
	}
	
	@GetMapping(value = "tagFindData_vue.do",produces = "text/plain;charset=UTF-8")
	public String musicTagFindData(String tag,int page) throws Exception{
		int rowSize = 8;
		int start = (rowSize*page)-(rowSize-1);
		int end = (rowSize*page);
		Map map = new HashMap();
		tag = tag.replace("(", "[(]");
		tag = tag.replace(")", "[)]");
		map.put("tag", tag);
		map.put("start", start);
		map.put("end", end);
		
		List<MusicFindVO> list = service.gmusictagFind(map);
		map = new HashMap();
		map.put("tag", tag);
		int totalpage = service.gmusictagTotalPage(tag);
		
		final int BLOCK = 10;
		int startPage = ((page-1)/BLOCK*BLOCK)+1;
		int endPage = ((page-1)/BLOCK*BLOCK)+BLOCK;
		if(endPage>totalpage) endPage=totalpage;
		
		map = new HashMap();
		map.put("list", list);
		map.put("curpage", page);
		map.put("totalpage", totalpage);
		map.put("startPage", startPage);
		map.put("endPage", endPage);
		
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(map);
		
		return json;
	}
	
	@GetMapping(value = "likeChange_vue.do",produces = "text/plain;charset=UTF-8")
	public String UserLikeChange(String id,int gnum,int nowLike) throws Exception{
		LikeVO Lvo = new LikeVO();
		Lvo.setTypeno(0);
		Lvo.setFno(0);
		Lvo.setPno(gnum);
		Lvo.setUserId(id);
		Map map = new HashMap();
		if(nowLike==0) {
			service.gmusicLikeInsert(Lvo);
			map.put("nowLike", 1);
		}
		else {
			service.gmusicLikeDelete(Lvo);
			map.put("nowLike", 0);
		}
		int AllLike = service.gmusicAllLikeCount(Lvo);
		map.put("AllLike", AllLike);
		
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(map);
		
		return json;
	}
	
	@GetMapping(value = "mvdetailInsert_vue.do",produces = "text/plain;charset=UTF-8")
	public void CommentInsert(String id,String comment,int fno) {
		Map map = new HashMap();
		map.put("userId", id);
		map.put("msg", comment);
		map.put("fno", fno);
		map.put("typeno", 0);
		service.gmusicDetailReplyInsert(map);
	}
	
	@GetMapping(value = "CommentDelete_vue.do",produces = "text/plain;charset=UTF-8")
	public void CommentDelete(int no) {
		service.gmusicDetailReplyDelete(no);
	}
	
	@GetMapping(value = "CommentChange_vue.do",produces = "text/plain;charset=UTF-8")
	public void CommentUpdate(int no,String comment) {
		Map map = new HashMap();
		map.put("no", no);
		map.put("msg", comment);
		service.gmusicDetailReplyUpdate(map);
	}
	
	@GetMapping(value = "BringMsg_vue.do",produces = "text/plain;charset=UTF-8")
	public String BringMsg(int no) {
		
		return service.gmusicReplyMsg(no);
	}
	@GetMapping(value = "CommentsubReplyInsert_vue.do",produces = "text/plain;charset=UTF-8")
	public void subReplyInsert(SubreplyVO vo) {
		service.gmusicDetailsubReplyInsert(vo);
	}
	
	@GetMapping(value = "subreplyAllSelect_vue.do",produces = "text/plain;charset=UTF-8")
	public String subreplyAllSelect(SubreplyVO vo) throws Exception{
		List<SubreplyVO> list = service.gmusicDetailsubReplySelect(vo);
		
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(list);
		
		return json;
	}
	
	@GetMapping(value = "subreplyDelete_vue.do")
	public void subreplyDelete(int sno) {
		service.gmusicSubreplyDelete(sno);
	}
	
	@GetMapping(value = "mymusicInsert_vue.do")
	public void myMusicInsert(MyMusicVO vo) {
		service.MyMusicInsert(vo);
	}
	
	@GetMapping(value = "MyMusicList_vue.do",produces = "text/plain;charset=UTF-8")
	public String MyMusicList(String userId) throws Exception{
		List<MusicFindVO> list = service.MyMusicList(userId);
		ObjectMapper mapper = new ObjectMapper();
		String json = mapper.writeValueAsString(list);
		
		return json;
	}
	
	@GetMapping(value = "MyMusicDelete_vue.do",produces = "text/plain;charset=UTF-8")
	public void MyMusicDelete(String checkedLst) {
		String[] list = checkedLst.split(",");
		for(int i =0;i<list.length;i++) {
			service.MyMusicDelete(Integer.parseInt(list[i]));
		}
		
	}
}
