package com.ikeo.qna.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ikeo.member.vo.LoginVO;
import com.ikeo.qna.service.QnaReplyService;
import com.ikeo.qna.service.QnaService;
import com.ikeo.qna.vo.QnaVO;
import com.ikeo.util.page.ReplyPageObject;
import com.webjjang.util.page.PageObject;

import lombok.Data;
import lombok.extern.java.Log;

@Controller
@Data
@RequestMapping("/qna")
@Log
public class QnaController {

	@Autowired
	@Qualifier("qnaServiceImpl")
	private QnaService service;

	@Autowired
	@Qualifier("qnaReplyServiceImpl")
	private QnaReplyService replyservice;

	@GetMapping("list.do")
	public String list(Model model, @ModelAttribute PageObject pageObject, HttpServletRequest request, String item_no)
			throws Exception {
		System.out.println("QnaController.list()");
		String perPageNumStr = request.getParameter("perPageNum");
		System.out.println("zzzzzzzzzzzzzfsdgearstmoreuzjglod;rsztgsed5 아이템 넘버는? " + item_no);
		model.addAttribute("list", service.list(pageObject,item_no));
		System.out.println("QnaController.model() - " + model);
		

		return "qna/list";
	}

	@GetMapping("/view.do")
	public String view(QnaVO vo, Long no, Model model, HttpServletRequest request) throws Exception {
		System.out.println("QnaController.view().no = " + no);
		model.addAttribute("vo", service.view(no));
		String strReplyPage = request.getParameter("replyPage");

		Long replyPage = (strReplyPage == null || strReplyPage.equals("")) ? 1 : Long.parseLong(strReplyPage);
		Long replyPerPageNum = 10L;

		ReplyPageObject replyPageObject = new ReplyPageObject();
		replyPageObject.setPage(replyPage);
		replyPageObject.setPerPageNum(replyPerPageNum);

		replyPageObject.setNo(no);
		
		model.addAttribute("replyPageObject", replyservice.list(no, replyPageObject));
		System.out.println(replyPageObject);
		return "qna/view";
	}

	@GetMapping("/write.do")
	public String writeForm(Long item_no) throws Exception {

		System.out.println("QnaController.writeForm()-아이템넘버는?" + item_no);

		return "qna/write";
	}

	@PostMapping("/write.do")
	public String write(QnaVO vo, HttpSession session, RedirectAttributes rttr, HttpServletRequest request) throws Exception {

		vo.setId(((LoginVO) session.getAttribute("login")).getId());
		System.out.println("QnaController.write().vo - " + vo);
		service.write(vo);
		rttr.addFlashAttribute("msg", "상품 문의 글등록이 되었습니다.");

		// 이동 URL 정보 : 앞에 "redirect:"을 붙여야 합니다.

		return "redirect:/product/view.do?no="+vo.getItem_No();
	}

	@GetMapping("/update.do")
	public String updateForm(Long no, Model model) throws Exception {
		System.out.println("QnaController.updateForm()");
		model.addAttribute("vo", service.view(no));
		// jsp 정보 - servlet-context.xml 설정
		// /WEB-INF/views/ + board/write + .jsp
		return "qna/update";
	}

	// 글수정 처리.
	@PostMapping("/update.do")
	public String update(QnaVO vo, PageObject pageObject, RedirectAttributes rttr, HttpSession session)
			throws Exception {

		System.out.println("QnaController.updateForm().vo - " + vo);
		vo.setId(((LoginVO) session.getAttribute("login")).getId());
		Integer result = service.update(vo);

		if (result == 1)
			rttr.addFlashAttribute("msg", "문의 게시판 글 수정이 완료되었습니다.");
		else
			rttr.addFlashAttribute("msg", "문의 게시판 글 수정 실패하였습니다. 관리자에게 문의해주세요.");
		return "redirect:view.do?no=" + vo.getNo() +"&item_no=" + vo.getItem_No();
		

	}

	// 글삭제 처리.
	@GetMapping("/delete.do")
	public String delete(QnaVO vo, String item_No, HttpSession session, RedirectAttributes rttr) throws Exception {
		System.out.println("QnaController.delete().no = " + item_No);

		vo.setId(((LoginVO) session.getAttribute("login")).getId());
		service.delete(vo);
		vo.setItem_No(item_No);
		
		rttr.addFlashAttribute("msg", "문의 게시판(글번호:" + vo.getNo() + ") 글삭제가 되었습니다.");

		// 이동 URL 정보 : 앞에 "redirect:"을 붙여야 합니다.
		return "redirect:/product/view.do?no=" + vo.getItem_No();
		
	}

}
