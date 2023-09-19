package com.ikeo.event.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.ikeo.event.mapper.EventMapper;
import com.ikeo.event.vo.EventImageVO;
import com.ikeo.event.vo.EventVO;
import com.webjjang.util.page.PageObject;

import lombok.Data;

@Service
@Qualifier("eventServiceImpl")
@Data
public class EventServiceImpl implements EventService {
	
	@Inject
	private EventMapper mapper;
	
	@Override
	public List<EventVO> list(PageObject pageObject) {
		pageObject.setTotalRow(mapper.getTotalRow(pageObject));
		return mapper.list(pageObject);
	}

	@Override
	public EventVO view(Long no) {
		// TODO Auto-generated method stub
		return mapper.view(no);
	}
	
	@Override
	public List<EventImageVO> getImageFile(Long no) throws Exception {
		// TODO Auto-generated method stub
		return mapper.getImageFile(no);
	}

	@Override
	public Integer write(EventVO vo, List<EventImageVO> fileList) {
		System.out.println("EventServiceImpl.write()");
		// 1. vo 저장
		mapper.write(vo);
		// for문을 이용해서 데이터 저장 - 반드시 no를 세팅 해야한다. vo.no ->fileVO.no
		for(EventImageVO fileVO : fileList) {
			fileVO.setNo(vo.getNo());
			mapper.writeFile(fileVO);
		}
		return 1;
	}
	
	public Integer update(EventVO vo)throws Exception{
		System.out.println("ImageServiceImpl.update()");
		return mapper.update(vo);
	}
	
	@Override
	public Integer delete(EventVO vo) throws Exception {
		return mapper.delete(vo);
	}

	@Override
	public Integer changeImage(EventImageVO vo) {
		// TODO Auto-generated method stub
		return mapper.changeImage(vo);
	}

	@Override
	public Integer deleteImage(Long image_no, String id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("image_no", image_no);
		map.put("id", id);
		return mapper.deleteImage(map);
	}
	
	// 상세 이미지만 insert
	@Override
	public Integer detailImageWrite(EventImageVO vo) {
		// TODO Auto-generated method stub
		return mapper.detailImageWrite(vo);
	}
}
