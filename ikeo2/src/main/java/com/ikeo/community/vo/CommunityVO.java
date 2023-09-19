package com.ikeo.community.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class CommunityVO {
	private Long no;
	private String title;
	private String id;
	private String content;
	private String nickname;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date write_date;
	private Long hit;
	
	private String file_name;
	
	private MultipartFile preImageFile;
	
	private MultipartFile imageFile;
}
