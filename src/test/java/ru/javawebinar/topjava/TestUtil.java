package ru.javawebinar.topjava;

import org.springframework.test.web.servlet.request.RequestPostProcessor;
import ru.javawebinar.topjava.model.User;
import org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors;

public class TestUtil {

    public static RequestPostProcessor userHttpBasic(User user) {
        return SecurityMockMvcRequestPostProcessors.httpBasic(user.getEmail(), user.getPassword());
    }
}
