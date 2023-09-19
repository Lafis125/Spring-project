package com.ikeo.community.ajax.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.ikeo.community.service.CommunityService;
import com.ikeo.community.vo.CommunityRecommendVO;
import com.ikeo.community.vo.CommunityTagItemVO;
import com.ikeo.communityRecommend.service.CommunityRecommendService;
import com.ikeo.communityReply.service.CommunityReplyService;
import com.ikeo.communityReply.vo.CommunityReplyVO;
import com.ikeo.member.vo.LoginVO;
import com.webjjang.util.page.ReplyPageObject;

import lombok.Data;

@RestController
@RequestMapping("/communityAjax")
@Data
public class CommunityAjaxController {

	@Autowired
	@Qualifier("communityReplyServiceImpl")
	private CommunityReplyService communityReplyService;
	
	@Autowired
	@Qualifier("communityRecommendServiceImpl")
	private CommunityRecommendService communityRecommendService;
	
	@Autowired
	@Qualifier("communityServiceImpl")
	private CommunityService CommunityService;
	
	@GetMapping(value="/list.do", produces = "application/text; charset=utf-8")
	public List<CommunityReplyVO> replyList(HttpServletRequest request, Model model,String query) throws Exception{
		ReplyPageObject replyPageObject = new ReplyPageObject(request);
		System.out.println("EventAjaxController - replyPageObject" + replyPageObject + " / query : " + query);
		List<CommunityReplyVO> list = communityReplyService.replyList(replyPageObject);
		model.addAttribute("replyPageObject", replyPageObject);
		return list;
	}
	
	@GetMapping(value="/write.do", produces = "application/text; charset=utf-8")
	public ResponseEntity<String> replyWrite(CommunityReplyVO vo, HttpSession session) {
		vo.setReply_id(((LoginVO)session.getAttribute("login")).getId());
		
		System.out.println("EventAjaxController.vo - "+ vo);
		Integer result = communityReplyService.write(vo);

		if (result == 1)
			return new ResponseEntity<String>("1", HttpStatus.OK);
		else
			return new ResponseEntity<String>("0", HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@RequestMapping(value = "/update.do", method=RequestMethod.GET)
	public String replyUpdate(CommunityReplyVO vo, HttpSession session) {
		vo.setReply_id(((LoginVO)session.getAttribute("login")).getId());
		System.out.println("replyUpdate.vo : " + vo);
		Integer result = communityReplyService.update(vo);
		
		if(result == 1) return "1";
			else return "0";
	}
	
	@RequestMapping(value = "/delete.do", method=RequestMethod.GET)
	public String replyDelete(CommunityReplyVO vo, HttpSession session) {
		//vo.setReply_id(((LoginVO)session.getAttribute("login")).getId());
		Integer result = communityReplyService.delete(vo);
		
		if(result == 1) return "1";
		else return "0";
	}
	
	@GetMapping(value="/answerWrite.do", produces = "application/text; charset=utf-8")
	public ResponseEntity<String> replyAnswer(CommunityReplyVO vo, HttpSession session, HttpServletRequest request) {
		vo.setOrd_no(Long.parseLong(request.getParameter("ord_no"))+1);
		vo.setPar_no(vo.getRno());
		vo.setReply_id(((LoginVO)session.getAttribute("login")).getId());
		
		System.out.println("EventAjaxController.replyAnswer().vo - "+ vo);
		Integer result = communityReplyService.answer(vo);

		if (result == 1)
			return new ResponseEntity<String>("1", HttpStatus.OK);
		else
			return new ResponseEntity<String>("0", HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@RequestMapping(value = "/like.do", method=RequestMethod.GET)
	public String recommend(CommunityRecommendVO vo, HttpSession session) {
		vo.setId(((LoginVO)session.getAttribute("login")).getId());
		System.out.println("좋아요 누르기 vo: " + vo);
		Integer result = communityRecommendService.recommend(vo);
		System.out.println("결과: " + result);
		if(result == 1) return "1";
		else return "0";
	}
	
	@RequestMapping(value = "/disLike.do", method=RequestMethod.GET)
	public String disRecommend(CommunityRecommendVO vo, HttpSession session) {
		vo.setId(((LoginVO)session.getAttribute("login")).getId());
		Integer result = communityRecommendService.disRecommend(vo);
		System.out.println("좋아요 취소 결과: " + result);
		if(result == 1) return "1";
		else return "0";
	}
	
	
	@RequestMapping(value = "/recommendCnt.do", method = RequestMethod.GET)
	public Integer recommendCnt(Long no) {
		Integer result = communityRecommendService.cntRecommend(no);

		return result;
	}
	
	@RequestMapping(value = "/itemSearch.do", method = RequestMethod.GET)
	public List<CommunityTagItemVO> list(String word) {
		System.out.println("검색어: " + word);
		List<CommunityTagItemVO> list = CommunityService.searchItem(word);
		return list;
	}
}