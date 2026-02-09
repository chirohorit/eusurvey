/*
package com.ec.survey.config;

import com.ec.survey.ShutdownListener;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.boot.web.servlet.ServletListenerRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.orm.hibernate5.support.OpenSessionInViewFilter;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

@Configuration
@EnableWebMvc
public class WebConfig {
    // 1. Hibernate OpenSessionInViewFilter
    @Bean
    public FilterRegistrationBean<OpenSessionInViewFilter> hibernateFilter() {
        FilterRegistrationBean<OpenSessionInViewFilter> registrationBean = new FilterRegistrationBean<>();
        OpenSessionInViewFilter filter = new OpenSessionInViewFilter();
        filter.setSessionFactoryBeanName("sessionFactory");
        registrationBean.setFilter(filter);
        registrationBean.addUrlPatterns("/*");
        registrationBean.setOrder(1); // Set priority
        return registrationBean;
    }

    // 2. Custom Shutdown Listener
    @Bean
    public ServletListenerRegistrationBean<ShutdownListener> shutdownListener() {
        return new ServletListenerRegistrationBean<>(new ShutdownListener());
    }
}
*/
