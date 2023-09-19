package com.ikeo.cart.service;

import java.util.List;

import com.ikeo.cart.vo.CartListVO;

public interface CartService {
	
	public Integer[] addCart(CartListVO cart);
	public Integer delete(CartListVO cart);
	public List<CartListVO> list(String id);

}
