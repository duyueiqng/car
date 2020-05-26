package com.zy.pojo;


import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;


@Data
@NoArgsConstructor
@AllArgsConstructor
public class Renttable {

	@TableId(value = "id",type = IdType.UUID)
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
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm")
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	private java.time.LocalDateTime beginDate;

	/**
	 * 到期日期
	 */
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm")
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	private java.time.LocalDateTime shouldReturnDate;

	/**
	 * 归还日期
	 */
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm")
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	private java.time.LocalDateTime returnDate;

	/**
	 * 是否归还
	 */
	private Double rentflag;

	/**
	 * 用户身份证
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
