package com.zy.controller;

import com.zy.pojo.Role;
import com.zy.pojo.User;
import com.zy.service.PermissionService;
import com.zy.service.RoleService;
import com.zy.utils.Constants;
import com.zy.vo.ResultVo;
import com.zy.vo.TreeNodeVo;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.List;

@RestController
@RequestMapping("/sys/role")
public class RoleController {
    @Resource
    RoleService roleService;
    @Resource
    PermissionService permissionService;

    @GetMapping("/list")

    public ResultVo getList(){
        List<Role> roles = roleService.searchAllList();
        return ResultVo.success(roles);
    }
    @PostMapping("/add")
    public ResultVo addRole(@RequestBody Role role, HttpSession session){
        try {
            User user = (User) session.getAttribute(Constants.USER_SESSION);
            roleService.addRole(role);
            return ResultVo.success("增加角色成功");
        }catch (Exception e){
            return ResultVo.faile("增加角色失败",e);
        }
    }
    @PostMapping("/update")
    public ResultVo updateRole(@RequestBody Role role, HttpSession session){
        try {
            roleService.updateRole(role);
            return ResultVo.success("修改角色成功");
        }catch (Exception e){
            return ResultVo.faile("修改角色失败",e);
        }
    }
    @GetMapping("/delete")
    public ResultVo updateRole(@RequestParam Integer id){
        try {
            roleService.deleteById(id);
            return ResultVo.success("删除角色成功");
        }catch (Exception e){
            return ResultVo.faile("删除角色失败",e);
        }
    }
    @GetMapping("/searchTreeNode")
    public ResultVo searchTreeNode(@RequestParam Integer id){
            List<TreeNodeVo> list = permissionService.searchTreeNode(id);
            return ResultVo.success(list);
    }
    @GetMapping("/graint")
    public ResultVo graintRole(Integer roleId,Integer [] ids){
        try {
            permissionService.graint(roleId,ids);
            return ResultVo.success("角色授权成功");
        }catch (Exception e){
            return ResultVo.faile("角色授权失败",e);
        }
    }
}
