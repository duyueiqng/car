package com.zy.pojo;


import com.baomidou.mybatisplus.annotation.TableLogic;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

@Data
public class Checktable {

	private Integer checkId;

	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm")
	private java.time.LocalDateTime checkDate;

	/**
	 * 反馈，评价
	 */
	private String field;

	/**
	 * 问题
	 */
	private String problem;

	/**
	 * 赔偿金额
	 */
	private Double paying;

	private String checkUserId;

	private String rentId;

	/**
	 * 逻辑删除标识 0 未删除  1 已删除
	 */
	@TableLogic
	private Integer deleted;


}