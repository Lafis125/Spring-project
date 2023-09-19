package com.ikeo.order.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.ikeo.order.mapper.OrderMapper;
import com.ikeo.order.vo.OrderDetailVO;
import com.ikeo.order.vo.OrderVO;
@Service
@Qualifier("orderServiceImpl")
public class OrderServiceImpl implements OrderService{

	@Inject
	private OrderMapper orderMapper;
	
	@Override
	public Integer write(OrderVO order) {
		// TODO Auto-generated method stub
		return orderMapper.write(order);
	}

	@Override
	public List<OrderVO> list(String id) {
		// TODO Auto-generated method stub
		return orderMapper.list(id);
	}

	@Override
	public Integer cartDelete(String id) {
		// TODO Auto-generated method stub
		return orderMapper.cartDelete(id);
	}

	@Override
	public Integer detail(OrderDetailVO detail) {
		// TODO Auto-generated method stub
		return orderMapper.detail(detail);
	}

}
