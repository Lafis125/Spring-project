package com.ikeo.order.controller;

import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.Collection;
import java.util.List;
import java.util.logging.Logger;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ikeo.cart.service.CartService;
import com.ikeo.cart.vo.CartListVO;
import com.ikeo.member.vo.LoginVO;
import com.ikeo.order.service.OrderService;
import com.ikeo.order.vo.OrderDetailVO;
import com.ikeo.order.vo.OrderVO;

import lombok.Data;
import lombok.extern.java.Log;

@Controller
@RequestMapping("/order")
@Data
@Log
public class OrderController {
	
	@Autowired
	@Qualifier("orderServiceImpl")
	private OrderService orderService;
	@Autowired
	@Qualifier("cartServiceImpl")
	private CartService cartService;
	
	@GetMapping("/list.do")
	public String list(Model model, HttpSession session) throws Exception {
		 log.info("주문 리스트.......................................");
		 LoginVO login = (LoginVO)session.getAttribute("login");		 
		 String id = login.getId();	
		 List<OrderVO> list = orderService.list(id);
		 
		 model.addAttribute("list", list);
		 
		 return "order/list";
		}

	@GetMapping("/write.do")
	public String writeForm(HttpSession session, Model model) {
		 LoginVO login = (LoginVO)session.getAttribute("login");		 
		 String id = login.getId();		 
		 model.addAttribute("list", cartService.list(id));
		return "order/write";
	}
	
	@PostMapping("/write.do")
	public String write(OrderVO order, OrderDetailVO detail, HttpSession session) {
		System.out.println("writeController.write");
		 LoginVO login = (LoginVO)session.getAttribute("login");  
		 String id = login.getId();
		 
		 Calendar cal = Calendar.getInstance();
		 int year = cal.get(Calendar.YEAR);
		 String ym = year + new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1);
		 String ymd = ym +  new DecimalFormat("00").format(cal.get(Calendar.DATE));
		 String subNum = "";
		 
		 for(int i = 1; i <= 6; i ++) {
		  subNum += (int)(Math.random() * 10);
		 }
		 
		 String orderNo = ymd + "_" + subNum;
		 
		 order.setOrderNo(orderNo);
		 order.setId(id);
		 
		 orderService.write(order);
		 detail.setOrderNo(orderNo);
		 orderService.detail(detail);
		 orderService.cartDelete(id);
		return "redirect:/cart/list.do";
	}
	
}
