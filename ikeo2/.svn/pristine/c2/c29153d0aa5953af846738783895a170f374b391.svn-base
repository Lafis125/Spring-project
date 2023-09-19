package com.ikeo.communityReply.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class CommunityReplyVO {
	private Long rno;
	private Long no;
	private String content;
	private String reply_id;
	private String nickname;
	private String par_nickname; // 부모답변 닉네임
	private Long ref_no; // 관련글 - 질문번호
	private Long par_no; // 부모글 질문 null
	private Long ord_no; // 순서번호
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date write_date;
}
