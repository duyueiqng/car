package com.zy.pojo;


import lombok.Data;

@Data
public class Role {

	/**
	 * id主键
	 */
	private Integer id;

	/**
	 * 角色编码
	 */
	private String roleCode;

	/**
	 * 角色名称
	 */
	private String roleName;

	/**
	 * 创建时间
	 */
	private java.time.LocalDateTime createdate;


}
