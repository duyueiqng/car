package com.zy.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.zy.pojo.Menu;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * @author shkstart
 * @date 2020/5/8 - 15:39
 */
public interface PermissionMapper extends BaseMapper<Menu>{
    @Select("select name from menu where id in(select menu_id from role_menu where role_id=#{roleId})")
    List<String> searchPermByRoleId(@Param("roleId") String roleId);
    //通过角色ID得到权限id列表
    @Select("select menu_id from role_menu where role_id=#{roleId}")
    List<Integer> getPerIdByRoleId(@Param("roleId") Integer roleId);
}
