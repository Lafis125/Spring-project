package com.ikeo.product.category.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.ikeo.product.service.ProductServiceImpl;
import com.ikeo.product.vo.ProductVO;

import lombok.Data;
import lombok.extern.java.Log;

@RestController
@RequestMapping("/categoryAjax")
@Data
@Log
public class CategoryAjaxController {

	@Autowired
	@Qualifier("productServiceImpl")
	private ProductServiceImpl service;

	@GetMapping(value = "/category.action", produces = { "application/json; charset=utf-8" })
	public @ResponseBody ResponseEntity<List<ProductVO>> category() {

		log.info("CategoryAjaxController");
		List<ProductVO> list = service.categoryList();
		log.info("CategoryAjaxController" + list);

		return new ResponseEntity<List<ProductVO>>(list, HttpStatus.OK);

	}

}
