//package com.ec.survey.config;
//
//import org.springframework.context.annotation.Configuration;
//import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
//import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
//import org.springframework.web.servlet.i18n.LocaleChangeInterceptor;
//import org.springframework.web.servlet.mvc.WebContentInterceptor;
//import org.springframework.mobile.device.DeviceResolverHandlerInterceptor;
//import org.springframework.mobile.device.DeviceWebArgumentResolver;
//import org.springframework.web.method.support.HandlerMethodArgumentResolver;
//import java.util.List;
//
//@Configuration
//public class MvcConfig implements WebMvcConfigurer {
//    @Override
//    public void addInterceptors(InterceptorRegistry registry) {
//        // Locale Change
//        LocaleChangeInterceptor lci = new LocaleChangeInterceptor();
//        lci.setParamName("language");
//        registry.addInterceptor(lci);
//
//        // Web Content (Cache Control)
//        WebContentInterceptor wci = new WebContentInterceptor();
//        wci.setCacheSeconds(0);
//        registry.addInterceptor(wci);
//
//        // Custom Interceptor
//        registry.addInterceptor(new com.ec.survey.handler.ServerEnvironmentHandlerInterceptor());
//
//        // Spring Mobile
//        //registry.addInterceptor(new DeviceResolverHandlerInterceptor());
//    }
//
//    /*@Override
//    public void addArgumentResolvers(List<HandlerMethodArgumentResolver> resolvers) {
//        resolvers.add(new DeviceWebArgumentResolver());
//    }*/
//}
