package com.zy.pojo;


import com.baomidou.mybatisplus.annotation.TableField;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
public class User {

	/**
	 * 主键
	 */
	private Integer id;

	/**
	 * 用户编码
	 */
	private String usercode;

	/**
	 * 用户姓名
	 */
	private String username;

	/**
	 * 用户密码
	 */
	private String password;

	/**
	 * 性别 1 男 0女
	 */
	private Integer sex;

	/**
	 * 生日
	 */
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd")
	private LocalDate birthday;

	/**
	 * 身份证信息
	 */
	private String idCard;

	/**
	 * 用户角色
	 */
	private Integer userRole;

	/**
	 * 手机号
	 */
	private String phone;

	/**
	 * 盐(加密)
	 */
	private String salt;

	/**
	 * 地址
	 */
	private String address;

	/**
	 * 创建时间
	 */
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm")
	private LocalDateTime createdate;

	/**
	 * 省份证正面
	 */
	private String attachPath;

	/**
	 * 省份证反面
	 */
	private String attachDescr;

	/**
	 * 用于显示用户的角色信息
	 * @TableField(exist = false)表示这不是一个数据库相对应的数据
	 */
	@TableField(exist = false)
	private Role role;

	/**
	 * 激活码
	 */
	private String code;

	/**
	 * 邮箱
	 */
	private String email;

	/**
	 * 状态
	 */
	private String state;


}
