package com.zy.vo;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class ResultVo {

    private int code;   //响应的代号
    private String msg;//用于增删改
    private Object result;//返回的数据

    public static ResultVo success(String msg){
        ResultVo resultVo = new ResultVo();
        resultVo.setCode(2000);
        resultVo.setMsg(msg);

        return resultVo;
    }
    public static ResultVo success(Object result){
        ResultVo resultVo = new ResultVo();
        resultVo.setCode(2000);
        resultVo.setResult(result);
        return resultVo;
    }
    public static ResultVo faile(String msg,Exception ex){
        ResultVo resultVo = new ResultVo();
        resultVo.setCode(5000);
        resultVo.setMsg(msg);
        log.info(msg,ex);
        return resultVo;
    }
    public static ResultVo faile(Object result){
        ResultVo resultVo = new ResultVo();
        resultVo.setCode(5000);
        resultVo.setResult(result);
        return resultVo;
    }

    @Override
    public String toString() {
        return "ResultVo{" +
                "code=" + code +
                ", msg='" + msg + '\'' +
                ", result=" + result +
                '}';
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Object getResult() {
        return result;
    }

    public void setResult(Object result) {
        this.result = result;
    }
}
