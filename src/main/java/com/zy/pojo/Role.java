package com.zy.pojo;


import com.baomidou.mybatisplus.annotation.TableField;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

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
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm")
	private LocalDateTime createdate;

    /**
     * 角色 -- 权限关系 ：多对多关系
     */
	@TableField(exist = false)
	private List<Menu> children;

    /**
     * 角色 -- 用户关系 ：一对多关系
     */
    @TableField(exist = false)
	private List<User> userList;
}
