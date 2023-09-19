package com.ikeo.communityRecommend.service;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.ikeo.community.vo.CommunityRecommendVO;
import com.ikeo.communityRecommend.mapper.CommunityRecommendMapper;

import lombok.Data;

@Service
@Qualifier("communityRecommendServiceImpl")
@Data
public class CommunityRecommendServiceImpl implements CommunityRecommendService {
	
	@Inject
	private CommunityRecommendMapper mapper;

	@Override
	public Integer recommend(CommunityRecommendVO vo) {
		// TODO Auto-generated method stub
		return mapper.recommend(vo);
	}

	@Override
	public Integer disRecommend(CommunityRecommendVO vo) {
		// TODO Auto-generated method stub
		return mapper.disRecommend(vo);
	}

	@Override
	public Integer chkRecommend(CommunityRecommendVO vo) {
		// TODO Auto-generated method stub
		return mapper.chkRecommend(vo);
	}

	@Override
	public Integer cntRecommend(Long no) {
		// TODO Auto-generated method stub
		return mapper.cntRecommend(no);
	}

}
