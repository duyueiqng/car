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
    @Select("select * from car ,renttable   where car.car_number=renttable.car_Id and YEAR(renttable.should_return_date) = #{year} AND MONTH(renttable.should_return_date) = #{month}\n" +
            "and return_date is NULL")
    List<Car> getCarListByYearMonth(@Param("year") String year,@Param("month") String month);
}
