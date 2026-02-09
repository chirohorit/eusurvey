//package com.ec.survey.config;
//
//import org.springframework.boot.web.server.ErrorPage;
//import org.springframework.boot.web.server.WebServerFactoryCustomizer;
//import org.springframework.boot.web.servlet.server.ConfigurableServletWebServerFactory;
//import org.springframework.http.HttpStatus;
//import org.springframework.stereotype.Component;
//
//@Component
//public class CustomErrorPageConfig implements WebServerFactoryCustomizer<ConfigurableServletWebServerFactory> {
//    @Override
//    public void customize(ConfigurableServletWebServerFactory factory) {
//        factory.addErrorPages(
//                new ErrorPage(HttpStatus.FORBIDDEN, "/errors/403.html"),
//                new ErrorPage(HttpStatus.NOT_FOUND, "/errors/404.html"),
//                new ErrorPage(HttpStatus.METHOD_NOT_ALLOWED, "/errors/405.html"),
//                new ErrorPage(Exception.class, "/errors/500.html")
//        );
//    }
//}
