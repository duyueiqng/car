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
    /**
     * 查询所有的权限
     * @param id
     * @return
     */
    List<TreeNodeVo> searchTreeNode(Integer id);

    /**
     * 根据角色得到对应的权限列表
     * @param roleId
     * @return
     */
    public List<String> searchPermByRoleId(Integer roleId);



    /**
     * 授权
     * @param roleId
     * @param ids
     */
    void graint(Integer roleId, Integer[] ids);

    /**
     * 根据角色id查找对应的菜单
     * @return
     */
    List<Menu> searchMenuList(Integer userRole);
}
