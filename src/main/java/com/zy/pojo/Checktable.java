package com.zy.pojo;


import lombok.Data;

@Data
public class Checktable {

	/**
	 * id
	 */
	private Integer checkId;

	/**
	 * 检查时间
	 */
	private java.util.Date checkDate;

	/**
	 * 评价
	 */
	private String field;

	/**
	 * 检查问题
	 */
	private String problem;

	/**
	 * 违约金
	 */
	private Integer payIng;

	/**
	 * 检查员
	 */
	private String checkUser;

	/**
	 * 租车Id
	 */
	private String rentId;


}
