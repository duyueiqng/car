package com.zy.pojo;


import lombok.Data;

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
	 * 性别
	 */
	private Integer sex;

	/**
	 * 生日
	 */
	private java.time.LocalDate birthday;

	/**
	 * 身份证信息
	 */
	private String idCard;

	/**
	 * 用户角色
	 */
	private String userRole;

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
	private java.time.LocalDateTime createdate;

	/**
	 * 省份证正面
	 */
	private String attachPath;

	/**
	 * 省份证反面
	 */
	private String attachDescr;


}
