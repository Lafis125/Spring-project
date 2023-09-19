package com.ikeo.event.mapper;

import java.util.List;
import java.util.Map;

import com.ikeo.community.vo.CommunityImageVO;
import com.ikeo.event.vo.EventImageVO;
import com.ikeo.event.vo.EventVO;
import com.webjjang.util.page.PageObject;

public interface EventMapper {
	// 이벤트 리스트
	List<EventVO> list(PageObject pageObject);
	// getTotalRow 페이지 처리
	public Long getTotalRow(PageObject pageObject);
	
	// 글보기, 이미지 리스트 가져오기
	List<EventImageVO> getImageFile(Long no);
	public EventVO view(Long no);
	
	// write
	public Integer write(EventVO vo);
	
	//file write 
	public Integer writeFile(EventImageVO vo);
	
	// 글삭제
	Integer delete(EventVO vo);
	
	// 글수정
	Integer update(EventVO vo);
	
	//이미지 바꾸기 
	public Integer changeImage(EventImageVO vo);
	
	//이미지 지우기
	public Integer deleteImage(Map<String, Object> map);
	
	// 상세 이미지만 저장
	public Integer detailImageWrite(EventImageVO vo);
	
	// 상세 이미지만 삭제
	public Integer detailImageDelete(EventImageVO vo);

}
