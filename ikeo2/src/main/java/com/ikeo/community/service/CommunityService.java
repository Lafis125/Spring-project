package com.ikeo.community.service;

import java.util.List;

import com.ikeo.community.vo.CommunityImageVO;
import com.ikeo.community.vo.CommunityTagItemVO;
import com.ikeo.community.vo.CommunityVO;
import com.webjjang.util.page.PageObject;

public interface CommunityService {

	public List<CommunityVO> list(PageObject pageObject);
	
	public CommunityVO view(Long no, Long inc);
	public List<CommunityImageVO> getImageFile(Long no)throws Exception;

	public Integer write(CommunityVO vo, List<CommunityImageVO> fileList);
	
	public Integer delete(CommunityVO vo) throws Exception;
	
	public Integer update(CommunityVO vo)throws Exception;

	//changeImage
	public Integer changeImage(CommunityImageVO vo);
	
	// 이미지 삭제
	public Integer deleteImage(Long image_no, String id);
	
	// 상세 이미지만 수정
	public Integer detailImageWrite(CommunityImageVO vo);
	
	public List<CommunityTagItemVO> searchItem(String word);
	
}
