package com.ikeo.product.mapper;

import java.util.List;

import com.ikeo.product.pageObject.ProductPageObject;
import com.ikeo.product.vo.ProductVO;
import com.webjjang.util.page.PageObject;

public interface ProductMapper {

	// list
	public List<ProductVO> list(ProductPageObject pageObject);

	public void CateNum(Long category_no);

	// page
	public Long getTotalRow(PageObject pageObject);

	// view
	public ProductVO view(Long item_no);

	// write
	public Integer write(ProductVO vo);

	// productList
	public List<ProductVO> productlist();

	// update
	public Integer update(ProductVO vo);

	// delete
	public Integer delete(ProductVO vo);

}
