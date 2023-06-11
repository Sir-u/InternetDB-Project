package com.web_project.db;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;


@WebListener
public class MyServletContextListener implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {
        // 애플리케이션 초기화 작업
    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {
        // 애플리케이션 종료 시 리소스 해제 작업
        DBConnection.closeConnection();
        System.out.println("closeConnection");
    }
}
