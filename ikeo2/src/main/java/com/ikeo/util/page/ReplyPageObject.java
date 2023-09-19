package com.ikeo.util.page;

import com.webjjang.util.page.PageObject;

import lombok.Data;


public class ReplyPageObject extends PageObject {

	private Long no;

	public Long getNo() {
		return no;
	}

	public void setNo(Long no) {
		this.no = no;
	}

	@Override
	public String toString() {
		return super.toString() + ", ReplyPageObject [no=" + no + "]";
	}
	
}
