package com.ikeo.review.vo;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ReviewVO {

	private Long reNo;
	private Long item_No;
	private Long itemNo;
	private String orderNo;
	private String id;
	private String title;
	private String content;
	private Date reviewDate;
	private Integer stars;
	private Integer refNo;
	private Integer ordNo;
	private Integer levNo;
    private String fileName;
    

	// byte 단위의 실제적인 파일 객체
	// 대표 이미지 - 1개
	private MultipartFile imageFile;
	
	}
	
	
	
	

