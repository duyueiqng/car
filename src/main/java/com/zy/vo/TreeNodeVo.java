package com.zy.vo;

import lombok.Data;

import java.util.List;

@Data
public class TreeNodeVo {
    private Integer id;
    private String title;
    private boolean expand;//是否展开直子节点
    private boolean checked;//是否勾选
    private List<TreeNodeVo> children;//子节点属性数组
}
