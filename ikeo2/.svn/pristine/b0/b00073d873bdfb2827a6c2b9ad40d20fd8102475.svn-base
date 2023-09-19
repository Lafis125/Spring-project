package com.ikeo.cart.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.ikeo.cart.service.CartService;
import com.ikeo.cart.vo.CartListVO;
import com.ikeo.member.vo.LoginVO;

import lombok.Data;
import lombok.extern.java.Log;

@RestController
@RequestMapping("/cartAjax")
@Data
@Log
public class CartAjaxController {

	@Autowired
	@Qualifier("cartServiceImpl")
	private CartService cartService;

//	장바구니 추가
	@PostMapping(value = "/addCart.action", produces = { "application/json; charset=utf-8" })
	public @ResponseBody Integer addCart(CartListVO cart, HttpSession session) {
		log.info("Controller - addCart() ------" + cart);

		LoginVO login = (LoginVO) session.getAttribute("login");

		Integer result = 0;
		if (login != null) {
			cart.setId(login.getId());
			cartService.addCart(cart);
			result = 1;
			return result;
		} else {
			return result;
		}
	}
}
