package com.coffeeshop.component;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.lang.NonNull;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.util.Objects;

/**
 * 邮箱工具类
 *
 */
@Component
public class MailClient {

    /**
     * 邮件发送器
     */
    @Autowired
    private JavaMailSenderImpl mailSender;

    /**
     * 邮件发送方
     */
    @Value("${spring.mail.username:}")
    private String fromEmail;

    /**
     * 发送账号密码
     */
    public void sendEmail(@NonNull String email, @NonNull String password) {
        MimeMessage mimeMessage = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(mimeMessage);
        try {
            helper.setSubject("咖啡商城-忘记密码");
            helper.setText("<h2 >咖啡商城</h2>" + "您好像忘记了您在咖啡商城的账号密码，没关系，我来告诉您：<br><br>" + "登陆邮箱: <span style='color : red'>" + email + "</span><br>" + "登陆密码: <span style='color : red'>" + password + "</span><br>" + "<hr>" + "<h5 style='color : red'>如果并非本人操作,请忽略本邮件</h5>", true);
            helper.setFrom(Objects.requireNonNull(fromEmail));
            helper.setTo(email);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
        mailSender.send(mimeMessage);
    }
}
