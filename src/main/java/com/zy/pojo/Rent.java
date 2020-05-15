package com.zy.pojo;


import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

@Data
public class Rent {

	/**
	 * 主键
	 */
	private Integer id;

	/**
	 * 订单编号
	 */
	private String idOrder;

	/**
	 * 身份证号
	 */
	private String numCard;

	/**
	 * 车辆车牌号
	 */
	private String carNumber;

	/**
	 *  状态
	 */
	private String isTree;

	/**
	 * 价格
	 */
	private Double money;

	/**
	 * 出租时间
	 */
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm")
	private java.time.LocalDateTime startdate;

	/**
	 * 归还时间
	 */
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm")
	private java.time.LocalDateTime enddate;

	/**
	 * 操作员
	 */
	private String employees;


}
