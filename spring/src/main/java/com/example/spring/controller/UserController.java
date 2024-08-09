package com.example.spring.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.spring.common.Result;
import com.example.spring.entity.User;
import com.example.spring.mapper.UserMapper;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

@RestController
@RequestMapping("/user")
public class UserController {

    @Resource
    UserMapper userMapper;

    @PostMapping("/login")
    public Result<?> login(@RequestBody User user) {
        User res = userMapper.selectOne(Wrappers.<User>lambdaQuery().eq(User::getUsername, user.getUsername()).eq(User::getPassword, user.getPassword()));
        if(res==null){
            return Result.error("-1","用户名或密码错误");
        }
        return Result.success(res);
    }

    @PostMapping("/register")
    public Result<?> register(@RequestBody User user) {
        User res = userMapper.selectOne(Wrappers.<User>lambdaQuery().eq(User::getUsername, user.getUsername()));
        if(res!=null){
            return Result.error("-1","用户名重复");
        }
        if(user.getPassword()==null){
            user.setPassword("123456");
        }
        userMapper.insert(user);
        return Result.success();
    }

    @PostMapping
    public Result<?> save(@RequestBody User user){
        if(user.getPassword()==null){
            user.setPassword("123456");
        }
        userMapper.insert(user);
        return Result.success();
    }
    @PutMapping
    public Result<?> update(@RequestBody User user){
        userMapper.updateById(user);
        return Result.success();
    }

    @DeleteMapping("/{id}")
    public Result<?> delete(@PathVariable Long id){
        userMapper.deleteById(id);
        return Result.success();
    }

    @GetMapping
    public Result<?> findPage(@RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "1000") Integer pageSize,
                              @RequestParam(defaultValue = "") String search,
                              @RequestParam(defaultValue = "-1") Integer role,
                              @RequestParam(required = false) Integer id) {
        LambdaQueryWrapper<User> queryWrapper = Wrappers.<User>lambdaQuery();

        if (!search.isEmpty()) {
            queryWrapper.like(User::getUsername, search);
        }
        if(id!=null){
            queryWrapper.eq(User::getId,id);
        }
        if (role == 1 || role == 2 || role == 3) {
            queryWrapper.eq(User::getRole, role);
        }

        return Result.success(userMapper.selectPage(new Page<>(pageNum, pageSize), queryWrapper));
    }

    @GetMapping("/gets-elected")
    public Result<?> findByRole(@RequestParam(defaultValue = "-1") Integer role) {
        LambdaQueryWrapper<User> queryWrapper = Wrappers.<User>lambdaQuery();

        if (role == 1 || role == 2 || role == 3) {
            queryWrapper.eq(User::getRole, role);
        }

        // 设置一个非常大的 pageSize 来模拟加载所有记录
        long pageSize = Long.MAX_VALUE;
        Page<User> page = new Page<>(1, pageSize);

        return Result.success(userMapper.selectPage(page, queryWrapper));
    }
    @GetMapping("/getCustomer")
    public Result<?> getCustomer(@RequestParam Integer id){
        User res = userMapper.selectOne(Wrappers.<User>lambdaQuery().eq(User::getId,id));
        return Result.success(res);
    }

}
