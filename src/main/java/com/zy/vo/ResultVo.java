package com.zy.vo;

/**
 * @author dyqstart
 * @create 2020-04-21 9:06
 * 用于数据的返回
 */
public class ResultVo {

    private int code;   //响应的代号
    private String msg; //一般用于增删改返回的成功或者是失败的信息
    private Object result;  //返回的数据,一般是查询出的信息

    public static ResultVo success(String msg){
        ResultVo resultVo=new ResultVo();
        resultVo.setCode(2000);
        resultVo.setMsg(msg);
        return resultVo;
    }


    public static ResultVo success(Object result){
        ResultVo resultVo=new ResultVo();
        resultVo.setCode(2000);
        resultVo.setResult(result);
        return resultVo;
    }

    public static ResultVo failure(String msg){
        ResultVo resultVo=new ResultVo();
        resultVo.setCode(5000);
        resultVo.setMsg(msg);
        return resultVo;
    }

//
//    public static ResultVo failure(Object result){
//        ResultVo resultVo=new ResultVo();
//        resultVo.setCode(5000);
//        resultVo.setResult(result);
//        return resultVo;
//    }












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
