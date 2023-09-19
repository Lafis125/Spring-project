package com.ikeo.event.service;

import java.util.List;

import com.ikeo.event.vo.EventImageVO;
import com.ikeo.event.vo.EventVO;
import com.webjjang.util.page.PageObject;

public interface EventService {
	public List<EventVO> list(PageObject pageObject);
	
	public EventVO view(Long no);
	public List<EventImageVO> getImageFile(Long no)throws Exception;

	public Integer write(EventVO vo, List<EventImageVO> fileList);
	
	public Integer delete(EventVO vo) throws Exception;
	
	public Integer update(EventVO vo)throws Exception;

	//changeImage
	public Integer changeImage(EventImageVO vo);
	
	// 이미지 삭제
	public Integer deleteImage(Long image_no, String id);
	
	// 상세 이미지만 수정
	public Integer detailImageWrite(EventImageVO vo);
		
}
