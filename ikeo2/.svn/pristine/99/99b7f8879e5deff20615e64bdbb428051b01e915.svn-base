package com.ikeo.cart.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.ikeo.cart.mapper.CartMapper;
import com.ikeo.cart.vo.CartListVO;

import lombok.Data;
import lombok.extern.java.Log;

@Service
@Qualifier("cartServiceImpl")
@Data
@Log
public class CartServiceImpl implements CartService {

	@Inject
	private CartMapper cartmapper;

	@Override
	public Integer[] addCart(CartListVO cart) {

		System.out.println("CartServicceImpl.addCart........................" + cart);
		Integer result[] = new Integer[cart.getOption_nos().length];
		 for (int i = 0; i < cart.getOption_nos().length; i++) {
			cart.setOption_no(cart.getOption_nos()[i]);
			cart.setCnt(cart.getCnts()[i]);
			result[i] = cartmapper.addCart(cart);
		}
		
		log.info("CartServiceImpl() - result : " + result);
		return result;
	}

	@Override
	public List<CartListVO> list(String id) {
		// TODO Auto-generated method stub
		return cartmapper.list(id);
	}

	@Override
	public Integer delete(CartListVO cart) {
		// TODO Auto-generated method stub
		return cartmapper.delete(cart);
	}

}
