package com.ikeo.qna.reply.controller;




import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ikeo.member.vo.LoginVO;
import com.ikeo.qna.service.QnaReplyService;
import com.ikeo.qna.vo.QnaReplyVO;


import lombok.Data;
import lombok.extern.java.Log;

@Controller
@Data
@RequestMapping("/qnareply")
@Log
public class QnaReplyController {

	@Autowired
	@Qualifier("qnaReplyServiceImpl")
	private QnaReplyService service;

	@PostMapping("/write.do")
	public String write(QnaReplyVO vo, HttpSession session, RedirectAttributes rttr) throws Exception {

		vo.setId(((LoginVO) session.getAttribute("login")).getId());
		System.out.println("QnaReplyController.write().vo - " + vo);
		service.write(vo);

		// 처리 결과를 리스트로 보낸다. - session사용. 출력하면 지운다.(일회성)
		rttr.addFlashAttribute("msg", "답변 등록이 완료되었습니다!");

		// 이동 URL 정보 : 앞에 "redirect:"을 붙여야 합니다.

		return "redirect:/qna/view.do?no=" + vo.getNo();
	}
	
	
	@PostMapping("/update.do")
	public String update(QnaReplyVO vo,Long no,RedirectAttributes rttr,Model model, HttpSession session)
			throws Exception {

		System.out.println("QnaReplyController.update().vo - " + vo);
		vo.setId(((LoginVO) session.getAttribute("login")).getId());
		Integer result = service.update(vo);
		

		if (result == 1)
			rttr.addFlashAttribute("msg", "문의 게시판 글 수정이 완료되었습니다.");
		else
			rttr.addFlashAttribute("msg", "문의 게시판 글 수정 실패하였습니다. 관리자에게 문의해주세요.");
		return "redirect:/qna/view.do?no=" + vo.getNo();

	}
	@GetMapping("/delete.do")
	public String delete(QnaReplyVO vo, Long no, HttpSession session, RedirectAttributes rttr) throws Exception {
		
		System.out.println("QnaReplyController.delete().no - " + no);
		vo.setId(((LoginVO) session.getAttribute("login")).getId());
		service.delete(vo);

		rttr.addFlashAttribute("msg", "문의 게시판(글번호:" + vo.getNo() + ") 글삭제가 되었습니다.");

		return "redirect:/qna/view.do?no=" + vo.getNo();
		
	}
}
