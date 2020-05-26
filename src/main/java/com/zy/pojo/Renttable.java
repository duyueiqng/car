package com.zy.pojo;


import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

@Data
public class Renttable {

	private String id;

	/**
	 * 预付款
	 */
	private Integer imprest;

	/**
	 * 应付款
	 */
	private Integer shouldPayPrice;

	/**
	 * 价格
	 */
	private Integer price;

	/**
	 * 开始日期
	 */
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm")
	private java.util.Date beginDate;

	/**
	 * 到期日期
	 */
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm")
	private java.util.Date shouldReturnDate;

	/**
	 * 归还日期
	 */
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm")
	private java.util.Date returnDate;

	/**
	 * 是否归还
	 */
	private Double rentflag;

	/**
	 * 身份证
	 */
	private String custId;

	/**
	 * 汽车ID
	 */
	private String carId;

	/**
	 * 操作员
	 */
	private String userId;


}
