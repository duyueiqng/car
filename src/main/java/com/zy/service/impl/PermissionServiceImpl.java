package com.zy.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.zy.mapper.PermissionMapper;
import com.zy.mapper.RoleMenuMapper;
import com.zy.pojo.Menu;
import com.zy.pojo.RoleMenu;
import com.zy.service.PermissionService;
import com.zy.vo.TreeNodeVo;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @author shkstart
 * @date 2020/5/8 - 15:26
 */
@Service
public class PermissionServiceImpl extends ServiceImpl<PermissionMapper,Menu> implements PermissionService {
    @Resource
    PermissionMapper permissionMapper;

    @Resource
    RoleMenuMapper roleMenuMapper;

    @Override
    public List<TreeNodeVo> searchTreeNode(Integer id) {
        List<TreeNodeVo> treeNodeVos = this.searchByParentId(null, id);
        for (TreeNodeVo treeNodeVo : treeNodeVos) {
            List<TreeNodeVo> nodeVos = this.searchByParentId(treeNodeVo.getId(),id);
            treeNodeVo.setChildren(nodeVos);
            for (TreeNodeVo treeNode:nodeVos){
                List<TreeNodeVo> nodeVo = this.searchByParentId(treeNodeVo.getId(),id);
                treeNode.setChildren(nodeVo);
            }
        }
        return treeNodeVos;
    }

    @Override
    public List<String> searchPermByRoleId(Integer roleId) {
        return permissionMapper.searchPermByRoleId(roleId);
    }

    @Override
    public List<Menu> searchMenuList() {
        Subject subject = SecurityUtils.getSubject();
        List<Menu> menuList01 = this.getPermissions(null);
        menuList01.stream().filter(p->subject.isPermitted(p.getPermCode())).collect(Collectors.toList());
        for (Menu menu : menuList01){
            List<Menu> menuList02 = this.getPermissions(menu.getId());
            menuList02.stream().filter(p->subject.isPermitted(p.getPermCode())).collect(Collectors.toList());
            menu.getChildren().addAll(menuList02);
        }
        return menuList01;
    }

    @Override
    public void graint(Integer roleId, Integer[] ids) {
        QueryWrapper wrapper = Wrappers.<RoleMenu>query();
        wrapper.eq("role_id",roleId);
        roleMenuMapper.delete(wrapper);
        if (ids!=null&& ids.length>0){
            for (Integer id:ids){
                RoleMenu roleMenu = new RoleMenu(roleId,id);
                roleMenuMapper.insert(roleMenu);
            }
        }
    }

    private List<Menu> getPermissions(Integer parentId) {
        QueryWrapper wrapper = Wrappers.<Menu>query();
        if (parentId==null){
            wrapper.isNull("parent_id");
        }else{
            wrapper.eq("parent_id",parentId);
        }
        return super.list(wrapper);
    }
    public List<TreeNodeVo> searchByParentId(Integer parentId,Integer roleId) {
        List<Integer> perIdByRoleId = permissionMapper.getPerIdByRoleId(roleId);
        List<TreeNodeVo> treeNodeVos = new ArrayList<>();
        QueryWrapper wrapper = Wrappers.<Menu>query();
        if (parentId==null){
            wrapper.isNull("parent_id");
        }else{
            wrapper.eq("parent_id",parentId);
        }
        List<Menu> list = super.list(wrapper);
        for (Menu menu : list) {
            TreeNodeVo treeNodeVo = new TreeNodeVo();
            treeNodeVo.setId(menu.getId());

            QueryWrapper<Menu> query = Wrappers.<Menu>query();
            query.eq("parent_id", menu.getId());
            Integer count = this.baseMapper.selectCount(query);
            if (perIdByRoleId.contains(menu.getId()) && count == 0){
                treeNodeVo.setChecked(true);
            }else{
                treeNodeVo.setChecked(false);
            }
            treeNodeVo.setExpand(false);
            treeNodeVo.setTitle(menu.getName());
            treeNodeVos.add(treeNodeVo);
        }
        return treeNodeVos;
    }
}
