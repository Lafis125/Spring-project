package com.ikeo.member.vo;

import lombok.Data;

@Data
public class SearchVO {
	
	private String key;
	private String word;
	private Long page;
	private Long endRno;
	
	public void setEndRno() {
		this.endRno = this.page * 20;
	}
	
	
	// 기본 생성자
	public SearchVO() {
		key = "\"id\"";
		word = "\"\"";
		page = 1L;
	}
	
}
