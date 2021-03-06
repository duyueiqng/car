package com.zy.pojo;


import com.fasterxml.jackson.annotation.JsonFormat;
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
	 * 状态
	 */
	private Integer isFree;

	/**
	 * 创建时间
	 */
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm")
	private java.time.LocalDateTime createtime;


}
