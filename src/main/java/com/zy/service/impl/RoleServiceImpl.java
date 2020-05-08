package com.zy.service.impl;

import com.zy.mapper.RoleMapper;
import com.zy.pojo.Role;
import com.zy.service.RoleService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class RoleServiceImpl implements RoleService {
    @Resource
    RoleMapper roleMapper;
    @Override
    public List<Role> searchAllList() {
        return roleMapper.selectList(null);
    }

    @Override
    public void addRole(Role role) {
        roleMapper.insert(role);
    }

    @Override
    public void updateRole(Role role) {
        roleMapper.updateById(role);
    }

    @Override
    public void deleteById(Integer id) {
        roleMapper.deleteById(id);
    }
}
