package com.zy.config;

import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.zy.mapper.BookMapper;
import com.zy.pojo.Book;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.SchedulingConfigurer;
import org.springframework.scheduling.config.ScheduledTaskRegistrar;
import org.springframework.scheduling.support.CronTrigger;

import java.time.LocalDateTime;
import java.util.List;

/**
 * @author shkstart
 * @date 2020/6/8 - 10:26
 */
@Configuration      //1.主要用于标记配置类，兼备Component的效果。
public class DynamicScheduleTask implements SchedulingConfigurer {

//    @Mapper
//    public interface CronMapper {
//        @Select("select cron from cron limit 1")
//        public String getCron();
//    }
//
//    @Autowired      //注入mapper
//    @SuppressWarnings("all")
//    CronMapper cronMapper;

    @Autowired      //注入mapper
    @SuppressWarnings("all")
    BookMapper bookMapper;
    /**
     * 执行定时任务.
     */
    @Override
    public void configureTasks(ScheduledTaskRegistrar taskRegistrar) {

        taskRegistrar.addTriggerTask(
                //1.添加任务内容(Runnable)
                () -> System.out.println("执行动态定时任务: " + LocalDateTime.now().toLocalTime()),
                //2.设置执行周期(Trigger)
                triggerContext -> {
                    //2.1 从数据库获取执行周期
//                    String cron = cronMapper.getCron();
                    //2.2 合法性校验.
//                    if (StringUtils.isEmpty(cron)) {
                        // Omitted Code ..
                        List<Book> books = bookMapper.selectList(null);
                        for (Book book:books) {
                            System.out.println(book.getEndTime()+"数据库");
                            System.out.println(LocalDateTime.now()+"当前日期");

                            if(book.getEndTime().isBefore(LocalDateTime.now())==true){//你的时间在当前时间之前是true
                               book.setFlag(0);
                               bookMapper.updateById(book);
                               System.out.println(book.getId()+"订单过期了");
                           }else {
                               System.out.println(book.getId()+"订单未过期");
                           }
                        }

//                    }
                    //2.3 返回执行周期(Date)
                    return new CronTrigger("0/600 * * * * ?").nextExecutionTime(triggerContext);
                }
        );
    }

}
