package com.ikeo.event.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class EventVO {
	private Long no;
	private String title;
	private String content;
	private String id;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date start_date;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date end_date;
	private Date write_date;
	private Date update_date;
	
	private String file_name;
	
	private MultipartFile preImageFile;
	
	private MultipartFile imageFile;
} 