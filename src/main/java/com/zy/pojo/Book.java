package com.zy.pojo;


import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

@Data
public class Book {

	private Integer id;

	/**
	 * 预定用户号
	 */
	private String custId;

	/**
	 * 预定车号
	 */
	private String carId;

	/**
	 * 预定单状态 1 进行中 0 已完成
	 */
	private Integer flag;

	/**
	 * 预定时间
	 */
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm")
	private java.time.LocalDateTime date;

	/**
	 * 过期时间
	 */
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm")
	private java.time.LocalDateTime endTime;

	/**
	 * 处理时间
	 */
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm")
	private java.time.LocalDateTime dealTime;

	/**
	 * 处理人
	 */
	private String userId;

	/**
	 * 处理结果 0 通过 1驳回
	 */
	private Integer result;

	/**
	 * 处理意见
	 */
	private String advise;


	/**
	 * 备注 用户是否已经知情结果
	 */
	private String remark;

}
