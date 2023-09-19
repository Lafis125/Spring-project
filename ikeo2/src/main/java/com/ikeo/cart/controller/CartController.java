package com.ikeo.cart.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ikeo.cart.service.CartService;
import com.ikeo.cart.vo.CartListVO;
import com.ikeo.member.vo.LoginVO;

import lombok.Data;
import lombok.extern.java.Log;

@Controller
@RequestMapping("/cart")
@Data
@Log
public class CartController {

	@Autowired
	@Qualifier("cartServiceImpl")
	private CartService cartService;

//	장바구니 삭제
	@GetMapping("/delete.do")
	public String delete(HttpSession session, CartListVO cart) {

		cart.setId(((LoginVO) session.getAttribute("login")).getId());

		cartService.delete(cart);

		return "redirect:/cart/list.do";

	}

//	장바구니 리스트
	@GetMapping("list.do")
	public String list(HttpSession session, Model model, RedirectAttributes rrtr) {

		LoginVO login = (LoginVO) session.getAttribute("login");

		if (login != null) {
			model.addAttribute("list", cartService.list(login.getId()));
			return "cart/list";
		} else {
			rrtr.addFlashAttribute("msg", "로그인 하고 이용해주세요");
			return "redirect:/member/login.do";
		}

	}

	@GetMapping("/view.do")
	public String view() throws Exception {

		return "cart/view";
	}

}
