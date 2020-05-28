package com.zy.mapper;

import com.zy.pojo.Car;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * @author shkstart
 * @date 2020/5/25 - 10:46
 */
public interface StstistscsMapper {

    List<Double> getCarListByYearMonth(@Param("year") String year,@Param("month") String month);
}
