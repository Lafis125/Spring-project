package com.ikeo.community.mapper;

import java.util.List;
import java.util.Map;

import com.ikeo.community.vo.CommunityImageVO;
import com.ikeo.community.vo.CommunityTagItemVO;
import com.ikeo.community.vo.CommunityVO;
import com.webjjang.util.page.PageObject;

public interface CommunityMapper {
		// 이벤트 리스트
		List<CommunityVO> list(PageObject pageObject);
		// getTotalRow 페이지 처리
		public Long getTotalRow(PageObject pageObject);
		
		// 글보기, 이미지 리스트 가져오기
		List<CommunityImageVO> getImageFile(Long no);
		public CommunityVO view(Long no);
		public Integer increase(Long no);
		
		// write
		public Integer write(CommunityVO vo);
		
		//file write 
		public Integer writeFile(CommunityImageVO vo);
		
		// 글삭제
		Integer delete(CommunityVO vo);
		
		// 글수정
		Integer update(CommunityVO vo);
		
		//이미지 바꾸기 
		public Integer changeImage(CommunityImageVO vo);
		
		//이미지 지우기
		public Integer deleteImage(Map<String, Object> map);
		
		// 상세 이미지만 저장
		public Integer detailImageWrite(CommunityImageVO vo);
		
		List<CommunityTagItemVO> searchItem(String word);
}
