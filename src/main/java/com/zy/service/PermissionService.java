package com.zy.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.zy.pojo.Menu;
import com.zy.vo.TreeNodeVo;

import java.util.List;

/**
 * @author shkstart
 * @date 2020/5/8 - 15:21
 */
public interface PermissionService extends IService<Menu> {
    List<TreeNodeVo> searchTreeNode(Integer id);//查询所有的权限
    public List<String> searchPermByRoleId(String roleId);

    //查找菜单
    List<Menu> searchMenuList();

    //授权
    void graint(Integer roleId, Integer[] ids);
}
