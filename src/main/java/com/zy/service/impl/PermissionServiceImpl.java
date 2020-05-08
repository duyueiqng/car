package com.zy.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.zy.mapper.PermissionMapper;
import com.zy.pojo.Menu;
import com.zy.service.PermissionService;
import com.zy.vo.TreeNodeVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * @author shkstart
 * @date 2020/5/8 - 15:26
 */
@Service
public class PermissionServiceImpl extends ServiceImpl<PermissionMapper,Menu> implements PermissionService {
    @Resource
    PermissionMapper permissionMapper;
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
        return null;
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
