//package com.ec.survey.config;
//
//import org.springframework.beans.factory.annotation.Value;
//import org.springframework.boot.context.properties.ConfigurationProperties;
//import org.springframework.boot.jdbc.DataSourceBuilder;
//import org.springframework.context.annotation.Bean;
//import org.springframework.context.annotation.Configuration;
//import org.springframework.context.annotation.Primary;
//import org.springframework.orm.hibernate5.HibernateTransactionManager;
//import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
//import org.springframework.transaction.PlatformTransactionManager;
//import org.springframework.transaction.annotation.EnableTransactionManagement;
//
//import javax.sql.DataSource;
//import java.util.Properties;
//
//@Configuration
//@EnableTransactionManagement
//public class HibernateConfig {
//
//    @Value("${hibernate.show_sql}") private String showSql;
//    @Value("${hibernate.generate_statistics}") private String genStats;
//    @Value("${hibernate.driver}") private String hibernateDriver;
//
//    @Value("${app.jdbc.driverClassName}") private String appJdbcDriverClass;
//    @Value("${app.jdbc.url}") private String appJdbcURL;
//    @Value("${app.jdbc.username}") private String appJdbcUsername;
//    @Value("${app.jdbc.password}") private String appJdbcPassword;
//
//    // --- APP DATABASE ---
//
//    @Primary
//    @Bean(name = "appdb")
//    @ConfigurationProperties(prefix = "app.jdbc")
//    public DataSource appDataSource() {
//        return DataSourceBuilder.create().build();
//    }
//
//    @Primary
//    @Bean(name = "sessionFactory")
//    public LocalSessionFactoryBean sessionFactory() {
//        LocalSessionFactoryBean sessionFactory = new LocalSessionFactoryBean();
//        sessionFactory.setDataSource(appDataSource());
//        sessionFactory.setPackagesToScan("com.ec.survey.model", "com.ec.survey.model.survey", "com.ec.survey.model.administration");
//        sessionFactory.setHibernateProperties(hibernateProperties());
//        return sessionFactory;
//    }
//
//    @Primary
//    @Bean(name = "transactionManager")
//    public PlatformTransactionManager hibernateTransactionManager() {
//        HibernateTransactionManager transactionManager = new HibernateTransactionManager();
//        transactionManager.setSessionFactory(sessionFactory().getObject());
//        return transactionManager;
//    }
//
//    // --- REPORTING DATABASE ---
//
//    @Bean(name = "reportingdb")
//    @ConfigurationProperties(prefix = "reporting.jdbc")
//    public DataSource reportingDataSource() {
//        return DataSourceBuilder.create().build();
//    }
//
//    @Bean(name = "sessionFactoryReporting")
//    public LocalSessionFactoryBean sessionFactoryReporting() {
//        LocalSessionFactoryBean sessionFactory = new LocalSessionFactoryBean();
//        sessionFactory.setDataSource(reportingDataSource());
//        sessionFactory.setPackagesToScan("com.ec.survey.servicereporting");
//        sessionFactory.setHibernateProperties(hibernateProperties());
//        return sessionFactory;
//    }
//
//    @Bean(name = "transactionManagerReporting")
//    public PlatformTransactionManager transactionManagerReporting() {
//        HibernateTransactionManager transactionManager = new HibernateTransactionManager();
//        transactionManager.setSessionFactory(sessionFactoryReporting().getObject());
//        return transactionManager;
//    }
//
//    // Common Hibernate Properties (C3P0, Dialect, etc.)
//    private Properties hibernateProperties() {
//        Properties props = new Properties();
//        props.put("hibernate.dialect", "org.hibernate.dialect.MySQLDialect");
//        props.put("hibernate.show_sql", showSql);
//        props.put("hibernate.hbm2ddl.auto", "none");
//        props.put("hibernate.generate_statistics", genStats);
//        props.put("hibernate.driver", hibernateDriver);
//        props.put("hibernate.connection.driver_class", appJdbcDriverClass);
//        props.put("hibernate.connection.url", appJdbcURL);
//        props.put("hibernate.connection.username", appJdbcUsername);
//        props.put("hibernate.connection.password", appJdbcPassword);
//
//        // C3P0 settings from your XML
//        /*props.put("hibernate.connection.provider_class", "org.hibernate.c3p0.internal.C3P0ConnectionProvider");
//        props.put("hibernate.c3p0.minPoolSize", "3");
//        props.put("hibernate.c3p0.maxPoolSize", "15");
//        props.put("hibernate.c3p0.timeout", "300");
//        props.put("hibernate.c3p0.testConnectionOnCheckout", "true");*/
//
//        // Legacy query handling
//        props.put("hibernate.query.substitutions", "true 1, false 0");
//        props.put("hibernate.allow_update_outside_transaction", "true");
//        return props;
//    }
//}
