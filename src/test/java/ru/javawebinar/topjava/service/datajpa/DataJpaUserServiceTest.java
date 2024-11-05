package ru.javawebinar.topjava.service.datajpa;

import org.junit.Assert;
import org.junit.Test;
import org.springframework.test.context.ActiveProfiles;
import ru.javawebinar.topjava.Profiles;
import ru.javawebinar.topjava.UserTestData;
import ru.javawebinar.topjava.model.User;
import ru.javawebinar.topjava.service.UserServiceTest;
import ru.javawebinar.topjava.util.exception.NotFoundException;

import static ru.javawebinar.topjava.UserTestData.*;
import static ru.javawebinar.topjava.MealTestData.*;

import static org.assertj.core.api.Assertions.assertThat;

@ActiveProfiles(Profiles.DATAJPA)
public class DataJpaUserServiceTest extends UserServiceTest {

    @Test
    public void getWithMeals() throws Exception {
        User user = service.getWithMeals(USER_ID);
        USER_MATCHER.assertMatch(user, user);
        MEAL_MATCHER.assertMatch(user.getMeals(), MEALS);
    }

    @Test
    public void getWithMealsNotFound() throws Exception {
        Assert.assertThrows(NotFoundException.class,
                () -> service.getWithMeals(1));
    }

    @Test
    public void getWithoutMeals() throws Exception {
        User newUser = UserTestData.getNew();
        User user = service.create(newUser);
        User userMeal = service.getWithMeals(user.getId());
        assertThat(userMeal.getMeals()).isEmpty();
    }
}