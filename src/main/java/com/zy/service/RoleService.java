package com.zy.service;

import com.zy.pojo.Role;

import java.util.List;


public interface RoleService {
    List<Role> searchAllList();
    void addRole(Role role);

    void updateRole(Role role);

    void deleteById(Integer id);
}
