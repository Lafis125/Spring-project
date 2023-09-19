package com.ikeo.member.seller.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ikeo.member.seller.service.SellerService;
import com.ikeo.member.seller.vo.SellerVO;
import com.ikeo.member.vo.LoginVO;

import lombok.Data;

@Controller
@RequestMapping("/member/seller")
@Data
public class SellerController {
	
	@Autowired
	@Qualifier("sellerServiceImpl")
	private SellerService service;
	
	// 판매자 신청 페이지
	@GetMapping("/apply.do")
	public String applyForm(HttpSession session) {
		return "member/seller/apply";
	}
	
	// 판매자 신청 처리
	@PostMapping("/apply.do")
	public String apply(SellerVO vo, HttpSession session, RedirectAttributes rttr) {
		LoginVO login = (LoginVO) session.getAttribute("login");
		// 로그인이 되어 있을 경우 서비스 실행
		if(login != null) {
			vo.setId(login.getId());
			Integer result = service.apply(vo);
			// 판매자 신청 처리 성공
			if(result == 1) {
				rttr.addFlashAttribute("msg", "판매자 신청이 되었습니다<br>관리자 승인 후 판매자로 변경됩니다");
			}
			// 판매자 신청 처리 실패
			else {
				rttr.addFlashAttribute("msg", "판매자 신청에 실패했습니다<br>다시 신청하시거나 관리자에게 문의해주세요");
			}
		}
		// 로그인이 되어 있지 않을 경우 로그인 창으로 보냅니다
		else {
			return "redirect:/member/login.do";
		}
		// 판매자 신청 처리가 끝나면 마이페이지로 이동시킵니다
		return "redirect:/member/mypage.do";
	}
	
	// 판매자 마이페이지
	@GetMapping("/mypage.do")
	public String mypageForm(HttpSession session, Model model) {
		LoginVO login = (LoginVO) session.getAttribute("login");
		if(login != null) {
			model.addAttribute("vo", service.view(login.getId()));
		}
		return "member/seller/mypage";
	}
	
	// 관리자용 판매자 관리 리스트 페이지
	@GetMapping("/list.do")
	public String list(Integer grade_no, Model model) {
		// list(int grade_no)
		// grade_no - 0 : 전체
		// grade_no - 6 : 판매자 승인 대기중
		// grade_no - 7 : 판매자
		if(grade_no == null) grade_no = 0;
		model.addAttribute("list", service.list(grade_no));
		return "member/seller/list";
	}
	
	// 판매자 신청 데이터 수정
	@PostMapping("/update.do")
	public String update(SellerVO vo, RedirectAttributes rttr) {
		Integer result = service.update(vo);
		if(result == 1) {
			rttr.addFlashAttribute("msg", "판매자 정보가 수정되었습니다");
		}
		else {
			rttr.addFlashAttribute("msg", "판매자 정보 수정에 실패했습니다");
		}
		return "redirect:/member/seller/mypage.do";
	}
	
	// 판매자 취소 신청
	@GetMapping("/withdrawals.do")
	public String delete(HttpSession session, RedirectAttributes rttr) {
		LoginVO login = (LoginVO) session.getAttribute("login");
		String id;
		if(login != null)
			id = login.getId();
		else
			return "redirect:/main.do";
		Integer result = service.delete(id);
		if(result == 1) {
			rttr.addFlashAttribute("msg", "판매자 정보가 삭제되었습니다");
		}
		else {
			rttr.addFlashAttribute("msg", "판매자 정보 삭제에 실패했습니다");
		}
		return "redirect:/member/mypage.do";
	}
}
