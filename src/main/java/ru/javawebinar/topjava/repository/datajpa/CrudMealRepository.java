package ru.javawebinar.topjava.repository.datajpa;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import ru.javawebinar.topjava.model.Meal;

public interface CrudMealRepository extends JpaRepository<Meal, Integer> {
}
