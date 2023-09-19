package com.ikeo.qna.vo;

import java.util.Date;

import lombok.Data;

@Data
public class QnaReplyVO {

	private Long rno;
	private Long no;
	private String content;
	private String id;
	private String name;
	private Date writeDate;
	
}
