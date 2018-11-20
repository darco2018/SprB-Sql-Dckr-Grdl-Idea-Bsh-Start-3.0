package pl.ust.app;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController("/gradle")
public class GradleController {

    @GetMapping
    public String helloGradle() {
        return "Hello Gradle!";
    }

}
