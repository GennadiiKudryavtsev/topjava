package ru.javawebinar.topjava.util;

import ru.javawebinar.topjava.model.UserMeal;
import ru.javawebinar.topjava.model.UserMealWithExcess;

import java.time.*;
import java.util.*;
import java.util.function.Function;
import java.util.stream.Collectors;

public class UserMealsUtil {
    public static void main(String[] args) {
        List<UserMeal> meals = Arrays.asList(
                new UserMeal(LocalDateTime.of(2020, Month.JANUARY, 30, 10, 0), "Завтрак", 500),
                new UserMeal(LocalDateTime.of(2020, Month.JANUARY, 30, 13, 0), "Обед", 1000),
                new UserMeal(LocalDateTime.of(2020, Month.JANUARY, 30, 20, 0), "Ужин", 500),
                new UserMeal(LocalDateTime.of(2020, Month.JANUARY, 31, 0, 0), "Еда на граничное значение", 100),
                new UserMeal(LocalDateTime.of(2020, Month.JANUARY, 31, 10, 0), "Завтрак", 1000),
                new UserMeal(LocalDateTime.of(2020, Month.JANUARY, 31, 13, 0), "Обед", 500),
                new UserMeal(LocalDateTime.of(2020, Month.JANUARY, 31, 20, 0), "Ужин", 410)
        );

        List<UserMealWithExcess> mealsTo = filteredByCycles(meals, LocalTime.of(7, 0), LocalTime.of(12, 0), 2000);
        mealsTo.forEach(System.out::println);

        System.out.println(filteredByStreams(meals, LocalTime.of(7, 0), LocalTime.of(12, 0), 2000));
    }

    public static List<UserMealWithExcess> filteredByCycles(List<UserMeal> meals, LocalTime startTime, LocalTime endTime, int caloriesPerDay) {
        Map<LocalDate, Integer> sumCalories = new HashMap<>();
        for (UserMeal userMeal : meals) {
            sumCalories.merge(userMeal.getDateTime().toLocalDate(), userMeal.getCalories(), (a, b) ->
                    sumCalories.getOrDefault(userMeal.getDateTime().toLocalDate(), 0) + b);
        }

        List<UserMealWithExcess> userMealWithExcessList = new ArrayList<>();
        for (UserMeal userMeal : meals) {
            if (userMeal.getDateTime().toLocalTime().isAfter(startTime) && userMeal.getDateTime().toLocalTime().isBefore(endTime)) {
                if (sumCalories.get(userMeal.getDateTime().toLocalDate()) > caloriesPerDay) {
                    userMealWithExcessList.add(new UserMealWithExcess(userMeal.getDateTime(),
                            userMeal.getDescription(), userMeal.getCalories(), true));
                }
            }
        }
        // TODO return filtered list with excess. Implement by cycles
        return userMealWithExcessList;
    }

    public static List<UserMealWithExcess> filteredByStreams(List<UserMeal> meals, LocalTime startTime, LocalTime endTime, int caloriesPerDay) {
        Map<LocalDate, Integer> mapStream = meals.stream()
                .collect(Collectors.groupingBy(e -> e.getDateTime().toLocalDate(), Collectors.summingInt(UserMeal::getCalories)));

        // TODO Implement by stream
        return meals.stream()
                .filter(e -> e.getDateTime().toLocalTime().isAfter(startTime) && e.getDateTime().toLocalTime().isBefore(endTime))
                .filter(e -> mapStream.get(e.getDateTime().toLocalDate()) > caloriesPerDay)
                .map(e -> new UserMealWithExcess(e.getDateTime(), e.getDescription(), e.getCalories(), true))
                .collect(Collectors.toList());
    }
}
