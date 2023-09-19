package com.ikeo.eventReply.vo;

import java.util.Date;

import lombok.Data;

@Data
public class EventReplyVO {
	private Long rno;
	private Long no;
	private String content;
	private String reply_id;
	private String nickname;
	private String par_nickname; // 부모답변 닉네임
	private Long ref_no; // 관련글 - 질문번호
	private Long par_no; // 부모글 질문 null
	private Long ord_no; // 순서번호
	private Date write_date;
}
