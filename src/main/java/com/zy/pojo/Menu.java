package com.zy.pojo;


import lombok.Data;

@Data
public class Menu {

	private Integer id;

	private String name;

	private String resourceType;

	private String icon;

	private String permCode;

	private Integer sort;

	private String url;

	private Integer parentId;


}
