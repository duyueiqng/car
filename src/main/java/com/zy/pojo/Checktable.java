package com.zy.pojo;


import com.fasterxml.jackson.annotation.JsonFormat;
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
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm")
	private java.time.LocalDateTime checkDate;

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
	private String checkUserId;

	/**
	 * 租车Id
	 */
	private String rentId;


}
