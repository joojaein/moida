package com.moida.web.controller.member;


import java.io.FileNotFoundException;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import com.moida.web.entity.Board;
import com.moida.web.entity.Category;
import com.moida.web.entity.Cmt;
import com.moida.web.entity.CmtListView;
import com.moida.web.entity.Cmtcnt;
import com.moida.web.entity.Crowd;
import com.moida.web.entity.CrowdSimpleDataView;
import com.moida.web.entity.MemberInfoListView;
import com.moida.web.entity.Schedule;
import com.moida.web.entity.Posts;
import com.moida.web.entity.PostsContent;
import com.moida.web.entity.PostsInfoView;
import com.moida.web.entity.RprtCrowd;
import com.moida.web.entity.Tag;
import com.moida.web.entity.PostsListView;
import com.moida.web.service.MoidaBoardService;
import com.moida.web.service.MoidaCategoryService;
import com.moida.web.service.MoidaCmtService;
import com.moida.web.service.MoidaCrowdService;
import com.moida.web.service.MoidaMemberService;
import com.moida.web.service.MoidaPostsService;
import com.moida.web.service.MoidaTagService;

@Controller("memberCrowd")
@RequestMapping("/crowd/")
public class CrowdController {
	
	@Autowired
	public MoidaMemberService memberservice;
	@Autowired
	public MoidaCrowdService crowdService;

	@Autowired
	public MoidaBoardService boardService;

	@Autowired
	public MoidaPostsService postsService;
	
	@Autowired
	public MoidaCmtService cmtService; 


	
	@GetMapping("notice")
	public String notice(
			@RequestParam(name="crowd") Integer crowdId,
			Integer boardId,
			Model model) {
		CrowdSimpleDataView crowd = crowdService.getCrowdSimpleDataView(crowdId);
		List<PostsListView> postsView = postsService.getNoticePostsView(crowdId);
		List<Board> boardList = boardService.getBoardListType0(crowdId);
		List<MemberInfoListView> milv = crowdService.getMemberInfoListView(crowdId);
		model.addAttribute("milv", milv);		
		model.addAttribute("plist", postsView);		
		model.addAttribute("crowd", crowd);
		model.addAttribute("bList", boardList);

		return "crowd.notice";
	}
	

	@GetMapping("notice/ndetail")
	public String noticedetail(
			@RequestParam(name="crowd") Integer crowdId,
			@RequestParam(name="id") Integer postsId,
			Integer id,
			Principal principal,
			Model model
			) {
		CrowdSimpleDataView crowd = crowdService.getCrowdSimpleDataView(crowdId);
		List<PostsContent> postscontent = postsService.getPostsContent(postsId);
		PostsInfoView posts = postsService.getPostsinfoView(id);
		List<CmtListView> cmt = cmtService.getCmtList(postsId);
		Cmtcnt cmtcnt = cmtService.getCmthit(postsId);
		List<MemberInfoListView> milv = crowdService.getMemberInfoListView(crowdId);
		model.addAttribute("milv", milv);		
		model.addAttribute("cmtcnt", cmtcnt);
		model.addAttribute("crowd", crowd);
		model.addAttribute("cmt",cmt);
		model.addAttribute("pc", postscontent);
		model.addAttribute("posts", posts);
		model.addAttribute("uid",principal.getName());
		int affected = postsService.updatehit(id);
		return "crowd.notice.ndetail";
	}

	@GetMapping("board")
	public String board(
			@RequestParam(name="crowd") Integer crowdId,
			Integer boardId,
			Model model) {
		CrowdSimpleDataView crowd = crowdService.getCrowdSimpleDataView(crowdId);
		List<PostsListView> postsView = postsService.getPostsListView1(crowdId);
		List<Board> boardList = boardService.getBoardListType1(crowdId);
		List<MemberInfoListView> milv = crowdService.getMemberInfoListView(crowdId);
		model.addAttribute("milv", milv);		
		model.addAttribute("plist", postsView);		
		model.addAttribute("crowd", crowd);
		model.addAttribute("bList", boardList);

		return "crowd.board";
	}

	@PostMapping("board")
	@ResponseBody
	public String boardpost(@RequestParam(name="crowd")Integer crowdId, 
			Integer boardId,
			Model model){
		List<PostsListView> postsList =null;
		if(boardId != null ) {
			postsList = postsService.getPostsListView2(crowdId, boardId);
		}else {
			postsList = postsService.getPostsListView1(crowdId);
		}

		Gson gson = new Gson(); 
		String json = gson.toJson(postsList);
		return json;
	}
	
	@GetMapping("board/bdetail")
	@PreAuthorize("isAuthenticated()")
	public String boarddetail(
			@RequestParam(name="crowd") Integer crowdId,
			@RequestParam(name="id") Integer postsId,
			Integer id,
			Principal principal,
			Model model
			) {
		CrowdSimpleDataView crowd = crowdService.getCrowdSimpleDataView(crowdId);
		List<PostsContent> postscontent = postsService.getPostsContent(postsId);
		PostsInfoView posts = postsService.getPostsinfoView(id);
		List<CmtListView> cmt = cmtService.getCmtList(postsId);
		List<MemberInfoListView> milv = crowdService.getMemberInfoListView(crowdId);
		String userId = principal.getName();
		int groupRole = crowdService.getCrowdGroupRole(crowdId, userId);
		int affected = postsService.updatehit(id);
		model.addAttribute("milv", milv);		
		model.addAttribute("crowd", crowd);
		model.addAttribute("cmt",cmt);
		model.addAttribute("pc", postscontent);
		model.addAttribute("posts", posts);
		model.addAttribute("uid",userId);
		model.addAttribute("groupRole", groupRole);
		return "crowd.board.bdetail";
	}

	@PostMapping("board/detail-comment")
	@ResponseBody
	public String boarddetailcomment(
			Integer postsId,
			String content,
			Principal principal
			) {	
			Cmt cmt = new Cmt(postsId, content, principal.getName());
			Gson gson = new Gson(); 
			
			String json = gson.toJson(cmtService.insertCmt(cmt));
			System.out.println("cmt"+cmt);
			System.out.println("json"+json);
		return json;
	}
	
	@PostMapping("boarddelete")
	public String deletePosts( Integer id, Integer crowdId, Integer type, String board) {
		System.out.println("id"+id+"crowdId"+crowdId+"type"+type+"board"+board);
		int affected = postsService.deletePosts(id);
		
		/*
		 * if(board == null) { return "redirect:"+board+"?t="+type+"&crowd="+crowdId; }
		 */
		return "redirect:"+board+"?t="+type+"&crowd="+crowdId;
	}

	@GetMapping("boardreg")
	public String reg(
			@RequestParam(name="crowd") Integer crowdId,
			Model model, Principal principal) {
		List<Board> boardlist = boardService.getBoardListType1(crowdId);
		CrowdSimpleDataView crowd = crowdService.getCrowdSimpleDataView(crowdId);
		List<MemberInfoListView> milv = crowdService.getMemberInfoListView(crowdId);

		Board boardType0 = boardService.getBoardType0(crowdId);
		Board boardType2 = boardService.getBoardType2(crowdId);

		String userId = principal.getName();
		int groupRole = crowdService.getCrowdGroupRole(crowdId, userId);
		model.addAttribute("milv", milv);		
		model.addAttribute("blist", boardlist);
		model.addAttribute("crowd", crowd);
		model.addAttribute("boardType0", boardType0);
		model.addAttribute("boardType2", boardType2);
		model.addAttribute("groupRole", groupRole);

		return "crowd.boardreg";
	}

	@PostMapping("boardreg")
	@ResponseBody
	public String boardreg (
			int boardId,
			String title,
			String content,
			String jsonContent,
			String mainImg,
			Model model, Principal principal) {

		Posts posts = new Posts(boardId, title, content, mainImg, principal.getName());

		Gson gson = new Gson();      
		JsonParser parser = new JsonParser();
		JsonElement elem = parser.parse(jsonContent);
		JsonArray elemArr = elem.getAsJsonArray();
		List<PostsContent> postsContentList = new ArrayList<PostsContent>();

		for (int i = 0; i < elemArr.size(); i++) {
			PostsContent postcontent = gson.fromJson(elemArr.get(i), PostsContent.class);
			postsContentList.add(postcontent);
		}

		return postsService.regPosts(posts, postsContentList)+"";
	}
	
	@PostMapping("boardedit")
	@ResponseBody
	public String boardedit (
			int boardId,
			String title,
			String content,
			String jsonContent,
			String mainImg,
			Model model, Principal principal) {

		Posts posts = new Posts(boardId, title, content, mainImg, principal.getName());

		Gson gson = new Gson();      
		JsonParser parser = new JsonParser();
		JsonElement elem = parser.parse(jsonContent);
		JsonArray elemArr = elem.getAsJsonArray();
		List<PostsContent> postsContentList = new ArrayList<PostsContent>();

		for (int i = 0; i < elemArr.size(); i++) {
			PostsContent postcontent = gson.fromJson(elemArr.get(i), PostsContent.class);
			postsContentList.add(postcontent);
		}

		return postsService.updatePosts(posts, postsContentList)+"";
	}


	@GetMapping("calendar")
	public String calendar(
			@RequestParam(name="crowd") Integer crowdId,
			Model model) {
		List<Schedule> schedule = crowdService.getScheduleList(crowdId);
		CrowdSimpleDataView crowd = crowdService.getCrowdSimpleDataView(crowdId);
		List<MemberInfoListView> milv = crowdService.getMemberInfoListView(crowdId);
		model.addAttribute("milv", milv);		
		model.addAttribute("schedule", schedule);
		model.addAttribute("crowd", crowd);
		Gson gson = new Gson(); 
		String json = gson.toJson(schedule);
		return "crowd.calendar"; 
	}
	

	@PostMapping("calendar")
	@ResponseBody
	public String calendarinsert(
			Integer crowdId,
			String startDate,
			String endDate,
			String title,
			String content
			) throws Exception {
	
		Date start = new SimpleDateFormat("yyyy-MM-dd").parse(startDate);
		Date end = new SimpleDateFormat("yyyy-MM-dd").parse(endDate);
		end.setDate(end.getDate()+1);

		Schedule schedule = new Schedule(crowdId, start, end, title, content);

		Gson gson = new Gson(); 
		String json = gson.toJson(schedule);
		int affected = crowdService.insertSchedule(schedule);
		return json;
	}


	@PostMapping("calendarlist-update")
	public String updateCalendarList(Integer crowdId, String startDate, String endDate, String title, String content, int id) throws ParseException {
		Date start = new SimpleDateFormat("yyyy-MM-dd").parse(startDate);
		Date end = new SimpleDateFormat("yyyy-MM-dd").parse(endDate);
		end.setDate(end.getDate()+1);
		Schedule schedule = new Schedule(crowdId, start, end, title, content, id);


		return crowdService.updateCalendarList(schedule)+"";
	}

	@PostMapping("calendarlist-delete")
	public String deleteCalendar(int id) {
		int affected = crowdService.deleteCalendarList(id);
		return affected+"";

	}


	@RequestMapping("album")
	public String album(
			@RequestParam(name="crowd") Integer crowdId,
			Model model) {		
		CrowdSimpleDataView crowd = crowdService.getCrowdSimpleDataView(crowdId);
		List<PostsListView> albumlist = postsService.getAlbumPostsView(crowdId);
		List<MemberInfoListView> milv = crowdService.getMemberInfoListView(crowdId);
		model.addAttribute("milv", milv);		
		model.addAttribute("crowd", crowd);
		model.addAttribute("alist", albumlist);
		return "crowd.album";
	}

	@GetMapping("adetail")
	public String albumdetail(
			@RequestParam(name="crowd") Integer crowdId,
			@RequestParam(name="id") Integer postsId,
			Integer id,
			Principal principal,
			Model model
			) {
		CrowdSimpleDataView crowd = crowdService.getCrowdSimpleDataView(crowdId);
		List<PostsContent> postscontent = postsService.getPostsContent(postsId);
		PostsInfoView posts = postsService.getPostsinfoView(id);
		List<CmtListView> cmt = cmtService.getCmtList(postsId);
		Cmtcnt cmtcnt = cmtService.getCmthit(postsId);
		List<MemberInfoListView> milv = crowdService.getMemberInfoListView(crowdId);
		model.addAttribute("milv", milv);		
		int affected = postsService.updatehit(id);
		model.addAttribute("cmtcnt", cmtcnt);
		model.addAttribute("crowd", crowd);
		model.addAttribute("cmt",cmt);
		model.addAttribute("pc", postscontent);
		model.addAttribute("posts", posts);
		model.addAttribute("uid",principal.getName());
		return "crowd.adetail";
	}


	@RequestMapping("createCategory")
	public String createCategory(Model model) {		
		model.addAttribute("href","/index");  
		//모임검색페이지에 모임개설 버튼이 있기 때문에 추후에 /index 대신 검색페이지의 주소를 기록해야함
		model.addAttribute("title","카테고리 선택");
		return "crowd.createCategory";
	}

	@Autowired
	public MoidaCategoryService moidaCategoryService;

	@Autowired
	public MoidaTagService moidaTagService;


	@RequestMapping("create")
	public String create(
			@RequestParam(name="t") Integer categoryId,
			Model model) throws FileNotFoundException {		

		Category categoryName = moidaCategoryService.getCategoryName(categoryId); 
		List<Tag> categoryTagName = moidaTagService.getCategoryTagNameList(categoryId); 

		model.addAttribute("href","createCategory");
		model.addAttribute("title",categoryName.getName());
		model.addAttribute("categoryId",categoryName.getId());
		model.addAttribute("tagName", categoryTagName);

		return "crowd.create";
	}

	@PostMapping("Reg")
	@ResponseBody
	public String Reg(String json, String tagId, Principal principal) {
		Gson gson = new Gson(); 
		Crowd crowd = gson.fromJson(json, Crowd.class);
		crowd.setLeaderId(principal.getName());
		
		return crowdService.createCrowd(crowd, tagId)+"";
	}

	@RequestMapping("checkId")
	@ResponseBody
	public String checkId(Principal principal,String url,HttpServletRequest request, HttpSession session) {
		String answer = "";
		if(principal == null) {
			request.getSession(true).setAttribute("preurl", url);
			answer = "no";
		}else {
			request.getSession(true).setAttribute("preurl", url);
			String preurl = (String)session.getAttribute("preurl");
			answer = preurl;
		}
		return answer;
	}

	@RequestMapping("request-join")
	@ResponseBody
	public String requestJoin(@RequestParam(name="crowd") String crowdIdStr,
			HttpServletResponse response){
		int crowdId = Integer.parseInt(crowdIdStr);

		SecurityContext context = SecurityContextHolder.getContext(); 
		Authentication authentication = context.getAuthentication(); 
		if(authentication.getPrincipal().equals("anonymousUser")) {
			return "anonymousUser";
		}

		User user = (User) authentication.getPrincipal();
		String userId = user.getUsername();

		return crowdService.requestCrowdJoin(crowdId, userId)+"";
	}

	
	@GetMapping("groupchat")
	public String groupChatting(@RequestParam(name="crowd") Integer crowdId) 
	{
		return "crowd.groupchat";
	}
	
	@PostMapping("get-groupMyId") 
	@ResponseBody
	public String getGroupMyId(Principal principal)  
	{
		String getGroupMyId = principal.getName();
		
		Gson gson = new Gson();
		String json = gson.toJson(getGroupMyId);
		
		return json;
	}



	@RequestMapping("set-rprt-crowd")
	@ResponseBody
	public String setRprtCrowd(String crowdIdStr, String title, String content, Principal principal) {
		int crowdId = Integer.parseInt(crowdIdStr);
		String userId = principal.getName();
		RprtCrowd rprtCrowd = new RprtCrowd(crowdId, userId, title, content);
		return crowdService.insertRprtCrowd(rprtCrowd)+"";
	}

	@RequestMapping("get-rprt-crowd")
	@ResponseBody
	public String getRprtCrowd(String crowdIdStr, Principal principal) {
		int crowdId = Integer.parseInt(crowdIdStr);
		String userId = principal.getName();
		RprtCrowd rprtCrowd = new RprtCrowd(crowdId, userId);
		return crowdService.getRprtCrowdCnt(rprtCrowd)+"";
	}

	@RequestMapping("del-rprt-crowd")
	@ResponseBody
	public String deleteRprtCrowd(String crowdIdStr, Principal principal) {
		int crowdId = Integer.parseInt(crowdIdStr);
		String userId = principal.getName();
		RprtCrowd rprtCrowd = new RprtCrowd(crowdId, userId);
		return crowdService.deleteRprtCrowd(rprtCrowd)+"";
	}

}

