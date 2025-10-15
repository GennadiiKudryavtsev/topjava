package ru.javawebinar.topjava.service;

import org.springframework.beans.factory.annotation.Autowired;
import ru.javawebinar.topjava.model.Meal;
import ru.javawebinar.topjava.repository.MealRepository;
import ru.javawebinar.topjava.util.exception.NotFoundException;

import java.util.List;

import static ru.javawebinar.topjava.web.SecurityUtil.authUserId;
import static ru.javawebinar.topjava.util.ValidationUtil.checkNotFound;

public class MealService {

    private MealRepository repository;

    @Autowired
    public MealService(MealRepository repository) {
        this.repository = repository;
    }

    public Meal create(Meal meal) {
        return repository.save(authUserId(), meal);
    }

    public void delete(int id) throws NotFoundException {
        checkNotFound(repository.delete(authUserId(), id), id);
    }

    public Meal get(int id) throws NotFoundException {
        return checkNotFound(repository.get(authUserId(), id), id);
    }

    public List<Meal> getAll() {
        return repository.getAll(authUserId());
    }

    public void update(Meal meal) throws NotFoundException {
        checkNotFound(repository.save(authUserId(), meal), meal.getId());
    }

}