package com.zy.pojo;


import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Renttable {

	private Integer id;

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
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm")
	private java.time.LocalDateTime beginDate;

	/**
	 * 到期日期
	 */
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm")
	private java.time.LocalDateTime shouldReturnDate;

	/**
	 * 归还日期
	 */
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm")
	private java.time.LocalDateTime returnDate;

	/**
	 * 是否归还
	 */
	private Double rentflag;

	/**
	 * 用户身份证
	 */
	private String numCard;

	/**
	 * 汽车ID
	 */
	private String carId;

	/**
	 * 操作员
	 */
	private String userId;


}
