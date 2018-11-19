package pl.ust.app;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
public class Main {

    public static void main(String[] args) {

        SpringApplication.run(Main.class, args);
    }

    @RequestMapping("/")
    public String greeting() {

        return "Greetings from Gradle Spring Boot Application!";
    }


    @RequestMapping(value="/hello", method=RequestMethod.GET)
    public String hello(@RequestParam("name") String name) {

        return "Hello " + name;
    }

    @RequestMapping("/color")
    public String color() {

        return "Hey, your favourite colour is ...";
    }

}