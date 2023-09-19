package com.ikeo.product.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.ikeo.product.mapper.CategoryMapper;
import com.ikeo.product.mapper.OptionMapper;
import com.ikeo.product.mapper.ProductMapper;
import com.ikeo.product.pageObject.ProductPageObject;
import com.ikeo.product.vo.ProductVO;
import com.webjjang.util.page.PageObject;

import lombok.Data;
import lombok.extern.java.Log;

@Service
@Qualifier("productServiceImpl")
@Data
@Log
public class ProductServiceImpl implements ProductService {

	@Inject
	private ProductMapper productmapper;

	@Inject
	private OptionMapper optionmapper;

	@Inject
	private CategoryMapper categorymapper;

	@Override
	public List<ProductVO> list(ProductPageObject pageObject) {
		log.info("ServiceImpl - list()" + pageObject);
		pageObject.setTotalRow(productmapper.getTotalRow(pageObject));

		return productmapper.list(pageObject);
	}

	@Override
	public ProductVO view(Long no) {
		log.info("ServiceImpl - view()" + no);
		return productmapper.view(no);
	}

	@Override
	public List<ProductVO> optionList(Long item_no) {
		log.info("ServiceImpl - view() - optionList : " + item_no);
		return optionmapper.list(item_no);
	}

	@Override
	public List<ProductVO> categoryList() {
		log.info("ServiceImpl - write() - categoryList ");
		return categorymapper.list();
	}

	@Override
	public List<ProductVO> Mainlist(ProductPageObject pageObject) {
		log.info("ServiceImpl - Mainlist()" + pageObject);

		return categorymapper.Mainlist(pageObject);
	}

	@Override
	public Integer write(ProductVO vo) {
		log.info("ServiceImpl - write()" + vo);

		Integer result = productmapper.write(vo);
		log.info("serviceImpl()-write result : " + result);
		vo.setItem_no(productmapper.productlist().get(productmapper.productlist().size() - 1).getItem_no());
		for (int i = 0; i < vo.getOption_names().length; i++) {
			vo.setOption_name(vo.getOption_names()[i]);
			vo.setOption_price(vo.getOption_prices()[i]);
			vo.setOption_info(vo.getOption_infos()[i]);
			Integer optionresult = optionmapper.write(vo);
			if (optionresult != 1) {
				log.info((i + 1) + "번 째를 실패했습니다.");
			} else {
				log.info((i + 1) + "번 째를 성공했습니다.");
			}
		}

		return result;
	}

	@Override
	public Integer update(ProductVO vo) {
		log.info("ServiceImpl - update()" + vo);
		Integer result = productmapper.update(vo);
		log.info("ServiceImpl - product update result : " + result);
		if (vo.getOption_nos() != null) {
			for (int i = 0; i < vo.getOption_nos().length; i++) {
				vo.setOption_no(vo.getOption_nos()[i]);
				vo.setOption_name(vo.getOption_names()[i]);
				vo.setOption_price(vo.getOption_prices()[i]);
				vo.setOption_info(vo.getOption_infos()[i]);
				result = optionmapper.update(vo);
				log.info("ServiceImpl -  option update result : " + result);
			}
			if (vo.getOption_nos().length != vo.getOption_names().length) {
				for (int i = vo.getOption_nos().length; i < vo.getOption_names().length; i++) {
					vo.setOption_name(vo.getOption_names()[i]);
					vo.setOption_price(vo.getOption_prices()[i]);
					vo.setOption_info(vo.getOption_infos()[i]);
					result = optionmapper.write(vo);
					log.info("ServiceImpl - option insert result : " + result);
				}
			}
		} else {
			if (vo.getOption_names() != null) {
				for (int i = 0; i < vo.getOption_names().length; i++) {
					vo.setOption_name(vo.getOption_names()[i]);
					vo.setOption_price(vo.getOption_prices()[i]);
					vo.setOption_info(vo.getOption_infos()[i]);
					result = optionmapper.write(vo);
					log.info("ServiceImpl - option insert result : " + result);
				}
			}
		}

		return result;
	}

	@Override
	public Integer delete(ProductVO vo) {
		log.info("ServiceImpl - delete()" + vo);
		return productmapper.delete(vo);
	}

}
