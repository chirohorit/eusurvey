//package com.ec.survey.config;
//
//import org.springframework.context.annotation.Bean;
//import org.springframework.context.annotation.Configuration;
//import org.springframework.core.task.TaskExecutor;
//import org.springframework.scheduling.annotation.EnableAsync;
//import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
//
//@Configuration
//@EnableAsync // Required to enable @Async method execution
//public class TaskExecutorConfig {
//
//    @Bean(name = "taskExecutor") // Give your executor a specific name
//    public TaskExecutor taskExecutor() {
//        ThreadPoolTaskExecutor executor = new ThreadPoolTaskExecutor();
//        executor.setCorePoolSize(8);
//        executor.setMaxPoolSize(16);
//        executor.setQueueCapacity(100);
//        executor.setThreadNamePrefix("Root-Executor-");
//        executor.initialize(); // Important to initialize the executor
//        return executor;
//    }
//
//    @Bean(name = "taskExecutorLong") // Give your executor a specific name
//    public TaskExecutor taskExecutorLong() {
//        ThreadPoolTaskExecutor executor = new ThreadPoolTaskExecutor();
//        executor.setCorePoolSize(8);
//        executor.setMaxPoolSize(16);
//        executor.setQueueCapacity(100);
//        executor.setThreadNamePrefix("LongTask-");
//        executor.initialize(); // Important to initialize the executor
//        return executor;
//    }
//
//    @Bean(name = "taskExecutorLongRestore") // Give your executor a specific name
//    public TaskExecutor taskExecutorLongRestore() {
//        ThreadPoolTaskExecutor executor = new ThreadPoolTaskExecutor();
//        executor.setCorePoolSize(8);
//        executor.setMaxPoolSize(16);
//        executor.setQueueCapacity(100);
//        executor.setThreadNamePrefix("RestoreTask-");
//        executor.initialize(); // Important to initialize the executor
//        return executor;
//    }
//}