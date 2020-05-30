package com.zy.utils;

import com.zy.pojo.User;
import com.zy.service.PermissionService;
import com.zy.service.UserService;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;

import java.util.List;

/**
 * @author shkstart
 * @date 2020/5/11 - 9:00
 */
public class CarRealm extends AuthorizingRealm {
    private UserService uservice;

    private PermissionService permissionService;

    public void setUservice(UserService uservice){
        this.uservice=uservice;
    }
    public void setPermissionService(PermissionService permissionService){
        this.permissionService=permissionService;
    }

    @Override
    //授权
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        System.out.println("权限配置‐‐>CarShiroRealm.doGetAuthorizationInfo()");
        //获取当前的用户
        User user = (User) principalCollection.getPrimaryPrincipal();

        //得到其对应的权限
        List<String> stringList = permissionService.searchPermByRoleId(user.getUserRole());
        System.out.println(stringList);
        //将权限放入SimpleAuthorizationInfo对象
        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
        for (String s : stringList) {
            info.addStringPermission(s);
        }
        return info;
    }

    @Override
    //认证
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        System.out.println("CarShiroRealm.doGetAuthenticationInfo()");
        String username = (String) token.getPrincipal();

        //查找数据库中的   user
        User user = uservice.findByUsername(username);
        if (user == null){
            return null;
        }
//        System.out.println(user);
        AuthenticationInfo authenticationInfo = new SimpleAuthenticationInfo(user, //用户名
                user.getPassword(), //密码
                ByteSource.Util.bytes(user.getSalt()),//salt=username+salt
                getName() );//realm name
        return authenticationInfo;
    }
}
