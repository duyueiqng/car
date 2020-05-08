package com.zy.pojo;


import lombok.Data;

@Data
public class Car {

	/**
	 * 主键
	 */
	private Integer id;

	/**
	 * 车牌号
	 */
	private String carNumber;

	/**
	 * 汽车类型
	 */
	private String carType;

	/**
	 * 颜色
	 */
	private String carColor;

	/**
	 * 汽车价格
	 */
	private Double carPrice;

	/**
	 * 汽车描述
	 */
	private String carDemp;

	/**
	 * 租赁价格
	 */
	private Double rentprice;

	/**
	 * 租赁押金
	 */
	private Double deposit;

	/**
	 * 汽车图片
	 */
	private String carImg;

	/**
	 * 创建时间
	 */
	private java.time.LocalDateTime createtime;


}
