package com.ec.survey;

import com.ec.survey.service.BasicService;
import com.ec.survey.service.ExportService;
import com.ec.survey.service.ParticipationService;
import com.ec.survey.service.WebserviceService;
import com.mysql.cj.jdbc.AbandonedConnectionCleanupThread;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.BeanFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Enumeration;
import java.util.Set;

public class ShutdownListener implements ServletContextListener {
    private static final Logger logger = LoggerFactory.getLogger(ShutdownListener.class);

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        logger.info("Context initialized.");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        logger.info("Context destroyal initiatied.");
        logger.debug("Attempting to collect web application context ... ");

        WebApplicationContext webApplicationContext = ContextLoader.getCurrentWebApplicationContext();

        // Shutting Down Background Threads
        if (webApplicationContext instanceof ConfigurableApplicationContext) {
            try {
                AbandonedConnectionCleanupThread.checkedShutdown();
                // Shutting Down Background Threads
                logger.debug(": context acquired! ");
                logger.debug("Shutdown of background services: Initiated");
                // Scheduler
                ThreadPoolTaskScheduler scheduler = (ThreadPoolTaskScheduler) webApplicationContext.getBean("taskScheduler");
                scheduler.shutdown();
                logger.debug("\t[1] Task Scheduler: Completed.");
            } catch (Exception e) {
                logger.info("Context destroyal failed due for: {}", e.getLocalizedMessage());
            }

            try {
                // Services Pool
                BasicService basicService = (BasicService) webApplicationContext.getBean("basicService");
                basicService.getPool().shutdown();
                basicService.getPDFPool().shutdown();
                logger.debug("\t[2] Service Pools: Completed.");
            } catch (Exception e) {
                logger.info("Context destroyal failed due for: {}", e.getLocalizedMessage());
            }
            
            try {
                // Database Connection Drivers
                logger.debug("\t[3] Connection Drivers: ");
                final Enumeration<Driver> drivers = DriverManager.getDrivers();
                while (drivers.hasMoreElements()) {
                    final Driver driver = drivers.nextElement();
                    try {
                        DriverManager.deregisterDriver(driver);
                        logger.info("\t\t[SUCCESS] - Deregistered '{}' JDBC driver.", driver);
                    } catch (SQLException sQLException) {
                        logger.warn("\t\t[FAILED]- Failed to deregister '{}' JDBC driver. ", driver);
                        logger.warn("\t\t\t-Exception: {}", sQLException.getLocalizedMessage());
                    }
                }
                logger.debug("\tDONE! ");
            } catch (Exception e) {
                logger.info("Context destroyal failed due for: {}", e.getLocalizedMessage());
            }
            
            try {
                // Threads
                logger.debug("\t[4] Threads - ");
                Set<Thread> threadSet = Thread.getAllStackTraces().keySet();
                Thread[] threadArray = threadSet.toArray(new Thread[threadSet.size()]);
                for(Thread t:threadArray) {
                    if(t.getName().contains("Abandoned connection cleanup thread")) {
                        synchronized(t) {
                            t.interrupt(); //don't complain, it works
                        }
                    }
                }
                logger.debug("\tDONE! ");
            } catch (Exception e) {
                logger.info("Context destroyal failed due for: {}", e.getLocalizedMessage());
            }

            ((ConfigurableApplicationContext) webApplicationContext).close();
            logger.info("-------------------\nContext destroyal completed.");
        }
        logger.info("-------------------\nApplication Termination Completed");
    }

    private void deregisterJdbcDrivers() {

        try {

        }
        catch (Exception e)
        {
            //ignore
        }

        try {
            Thread.sleep(5000);
        } catch (InterruptedException e) {
            //ignore
        }
    }
}