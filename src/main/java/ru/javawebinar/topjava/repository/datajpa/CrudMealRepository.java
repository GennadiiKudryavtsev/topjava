package ru.javawebinar.topjava.repository.datajpa;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;
import ru.javawebinar.topjava.model.Meal;

import java.time.LocalDateTime;
import java.util.List;

public interface CrudMealRepository extends JpaRepository<Meal, Integer> {

    @Modifying
    @Transactional
    @Query("DELETE FROM Meal m WHERE m.id = :id AND m.user.id = :userId")
    int deleteByIdAndUserId(@Param("id") int id, @Param("userId") int userId);

    @Transactional
    @Query("SELECT m FROM Meal m WHERE m.user.id = :userId ORDER BY m.dateTime DESC")
    List<Meal> getAllByUserIdOrderByDateTimeDesc(@Param("userId") int userId);

    @Transactional
    @Query("SELECT m FROM Meal m WHERE m.user.id = :userId AND m.dateTime >= :start AND m.dateTime < :end ORDER BY m.dateTime DESC")
    List<Meal> getBetweenHalfOpen(@Param("start") LocalDateTime start,
                                  @Param("end") LocalDateTime end,
                                  @Param("userId") int userId);

    @Transactional
    @Query("SELECT m FROM Meal m WHERE m.id = :id AND m.user.id = :userId")
    Meal get(@Param("id") int id, @Param("userId") int userId);
}
