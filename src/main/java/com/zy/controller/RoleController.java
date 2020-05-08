package com.zy.controller;

import com.zy.pojo.Role;
import com.zy.pojo.User;
import com.zy.service.PermissionService;
import com.zy.service.RoleService;
import com.zy.utils.Constants;
import com.zy.vo.ResultVo;
import com.zy.vo.TreeNodeVo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.List;

@Controller
@ResponseBody
public class RoleController {
    @Resource
    RoleService roleService;
    @Resource
    PermissionService permissionService;

    @GetMapping("/sys/role/list")

    public ResultVo getList(){
        List<Role> roles = roleService.searchAllList();
        return ResultVo.success(roles);
    }
    @PostMapping("/sys/role/add")
    public ResultVo addRole(@RequestBody Role role, HttpSession session){
        try {
            User user = (User) session.getAttribute(Constants.LoginName);
            roleService.addRole(role);
            return ResultVo.success("增加角色成功");
        }catch (Exception e){
            return ResultVo.success("增加角色失败");
        }
    }
    @PostMapping("/sys/role/update")
    public ResultVo updateRole(@RequestBody Role role, HttpSession session){
        try {
            roleService.updateRole(role);
            return ResultVo.success("修改角色成功");
        }catch (Exception e){
            return ResultVo.success("修改角色失败");
        }
    }
    @GetMapping("/sys/role/delete")
    public ResultVo updateRole(@RequestParam Integer id){
        try {
            roleService.deleteById(id);
            return ResultVo.success("删除角色成功");
        }catch (Exception e){
            return ResultVo.success("删除角色失败");
        }
    }
    @GetMapping("/sys/role/searchTreeNode")
    public ResultVo searchTreeNode(@RequestParam Integer id){
            List<TreeNodeVo> list = permissionService.searchTreeNode(id);
            return ResultVo.success(list);
    }
}
