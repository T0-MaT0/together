package edu.kh.project.member;

import java.util.Properties;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.google.code.kaptcha.impl.DefaultKaptcha;
import com.google.code.kaptcha.util.Config;

@Configuration
public class CaptchaConfig {

	@Bean
    public DefaultKaptcha captchaProducer() {
        DefaultKaptcha kaptcha = new DefaultKaptcha();
        Properties props = new Properties();

        props.setProperty("kaptcha.border", "no");
        props.setProperty("kaptcha.textproducer.font.color", "black");
        props.setProperty("kaptcha.image.width", "150");
        props.setProperty("kaptcha.image.height", "50");
        props.setProperty("kaptcha.textproducer.font.size", "40");
        props.setProperty("kaptcha.session.key", "captcha");
        props.setProperty("kaptcha.textproducer.char.length", "6");
        props.setProperty("kaptcha.textproducer.font.names", "Arial,Courier");

        Config config = new Config(props);
        kaptcha.setConfig(config);
        return kaptcha;
    }
}
