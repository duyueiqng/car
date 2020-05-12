package com.zy.pojo;


import com.baomidou.mybatisplus.annotation.TableField;
import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
public class Menu {

	private Integer id;

	private String name;

	private String resourceType;

	private String icon;

	private String permCode;

	private Integer sort;

	private String url;

	private Integer parentId;

	/**
	 * 角色 -- 权限关系 ：多对多关系
	 */
	@TableField(exist = false)
	private List<Menu> children = new ArrayList<>();


}
