package com.ikeo.product.mapper;

import java.util.List;

import com.ikeo.product.pageObject.ProductPageObject;
import com.ikeo.product.vo.ProductVO;

public interface CategoryMapper {

	public List<ProductVO> list();

	public List<ProductVO> Mainlist(ProductPageObject pageObject);
}
