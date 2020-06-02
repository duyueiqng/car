package com.zy.pojo;


import lombok.Data;

@Data
public class CarConfig {

	/**
	 * 主键
	 */
	private String id;

	/**
	 * 发动机配件
	 */
	private String engine;

	/**
	 * 传动系配件
	 */
	private String transmission;

	/**
	 * 转向系配件
	 */
	private String steering;

	/**
	 * 汽车内饰
	 */
	private String carInterior;

	/**
	 * 汽车外饰
	 */
	private String carTrim;


}
