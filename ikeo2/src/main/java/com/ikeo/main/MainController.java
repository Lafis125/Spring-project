package com.ikeo.main;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ikeo.product.pageObject.ProductPageObject;
import com.ikeo.product.service.ProductServiceImpl;

import lombok.Data;
import lombok.extern.java.Log;

@Controller
@Data
@Log
public class MainController {
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductServiceImpl service;

	@RequestMapping(value = "/main.do", method = RequestMethod.GET)
	public String main(@ModelAttribute(name = "pageObject") ProductPageObject pageObject, Model model,
			HttpServletRequest request) {
		String perPageNumStr = request.getParameter("perPageNum");
		pageObject.setPerPageNum(
				(perPageNumStr == null || perPageNumStr.equals("null") || perPageNumStr.equals(null)) ? 8L
						: Long.parseLong(perPageNumStr));
		pageObject.setCategory_no(1L);
		model.addAttribute("category01", service.Mainlist(pageObject));

		pageObject.setCategory_no(2L);
		model.addAttribute("category02", service.Mainlist(pageObject));

		pageObject.setCategory_no(3L);
		model.addAttribute("category03", service.Mainlist(pageObject));

		pageObject.setCategory_no(4L);
		model.addAttribute("category04", service.Mainlist(pageObject));
		return "main";
	}

}
