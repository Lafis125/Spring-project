package com.ikeo.cart.mapper;

import java.util.List;

import com.ikeo.cart.vo.CartListVO;

public interface CartMapper {

	public Integer addCart(CartListVO cart);
	public Integer delete(CartListVO cart);
	public List<CartListVO> list(String id);
	
}
