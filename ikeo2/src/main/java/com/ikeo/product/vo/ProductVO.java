package com.ikeo.product.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ProductVO {

	private Long item_no, option_no, category_no;

	private String item_title, item_thum, item_price, item_content;

	private String item_status, item_img, option_name, option_price, option_info;

	private String category_name;

	private MultipartFile thum_File;

	private MultipartFile img_File;

	private String[] option_names;

	private String[] option_prices;

	private String[] option_infos;

	private Long[] option_nos;
}
