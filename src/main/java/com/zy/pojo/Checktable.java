package com.zy.pojo;


import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

@Data
public class Checktable {

	private Integer id;

	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm")
	private java.time.LocalDateTime checkDate;

	/**
	 * 反馈，评价
	 */
	private String field;

	private String problem;

	/**
	 * 是否盈利
	 */
	private Double paying;

	private String checkUserId;

	private Integer rentId;


}
