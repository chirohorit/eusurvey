/*
package com.ec.survey.config;

import jakarta.annotation.PostConstruct;
import org.apache.camel.CamelContext;
import org.apache.camel.impl.engine.LimitedPollingConsumerPollStrategy;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.beans.factory.config.MethodInvokingFactoryBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;
import java.util.Locale;
import java.util.Properties;

@Configuration
@EnableAsync
@EnableScheduling
public class AppInfrastructureConfig {

    // Inject the value of the export.fileDir property
    @Value("${export.fileDir}") private String exportFileDir;

    // Replaces <systemPrereqs> MethodInvokingFactoryBean
    @PostConstruct
    public void systemPrereqs() {
        // Assuming 'export.fileDir' is defined in your properties
        System.setProperty("org.owasp.esapi.resources", exportFileDir);
        System.out.println("Set system property 'org.owasp.esapi.resources' to: " + exportFileDir);
    }

    // Apache Camel Context
    @Bean
    public LimitedPollingConsumerPollStrategy tryFiveTimes() {
        LimitedPollingConsumerPollStrategy strategy = new LimitedPollingConsumerPollStrategy();
        strategy.setLimit(5);
        return strategy;
    }

    // Locale Resolver
    @Bean
    public SessionLocaleResolver localeResolver() {
        SessionLocaleResolver slr = new SessionLocaleResolver();
        slr.setDefaultLocale(new Locale("en", "GB"));
        return slr;
    }

    // Replaces <task:executor id="taskExecutor">
    @Bean(name = "taskExecutor")
    public ThreadPoolTaskExecutor taskExecutor() {
        ThreadPoolTaskExecutor executor = new ThreadPoolTaskExecutor();
        executor.setCorePoolSize(10);
        executor.setMaxPoolSize(10);
        executor.setQueueCapacity(10000);
        executor.setWaitForTasksToCompleteOnShutdown(true);
        return executor;
    }

    // Repeat the pattern above for 'taskExecutorLong' and 'taskExecutorLongRestore'
    @Bean(name = "taskExecutorLong")
    public ThreadPoolTaskExecutor taskExecutorLong() {
        ThreadPoolTaskExecutor executor = new ThreadPoolTaskExecutor();
        executor.setCorePoolSize(10);
        executor.setMaxPoolSize(10);
        executor.setQueueCapacity(10000);
        executor.setWaitForTasksToCompleteOnShutdown(true);
        return executor;
    }

    @Bean(name = "taskExecutorLongRestore")
    public ThreadPoolTaskExecutor taskExecutorLongRestore() {
        ThreadPoolTaskExecutor executor = new ThreadPoolTaskExecutor();
        executor.setCorePoolSize(10);
        executor.setMaxPoolSize(10);
        executor.setQueueCapacity(10000);
        executor.setWaitForTasksToCompleteOnShutdown(true);
        return executor;
    }
}
*/
