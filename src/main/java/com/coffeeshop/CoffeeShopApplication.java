package com.coffeeshop;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.boot.web.context.WebServerInitializedEvent;
import org.springframework.context.event.EventListener;
import com.coffeeshop.config.AiConfig;

/**
 * 应用程序启动类
 *
 * @author Wen
 */
@SpringBootApplication
@MapperScan(basePackages = { "com.coffeeshop.mapper" })
@EnableConfigurationProperties(AiConfig.class)
public class CoffeeShopApplication {

    public static void main(String[] args) {
        SpringApplication.run(CoffeeShopApplication.class, args);
    }

    @EventListener(WebServerInitializedEvent.class)
    public void onStartup(WebServerInitializedEvent event) {
        int port = event.getWebServer().getPort();
        String contextPath = event.getApplicationContext().getEnvironment()
                .getProperty("server.servlet.context-path", "");
        System.out.println("\n----------------------------------------------------------");
        System.out.println("  ☕ Coffee Shop 启动成功！");
        System.out.println("  \uD83C\uDF10 访问地址: http://localhost:" + port + contextPath + "/");
        System.out.println("----------------------------------------------------------\n");
    }

}
