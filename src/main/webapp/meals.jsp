<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Meals</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.1/css/jquery.dataTables.min.css">

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.1/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</head>
<body>

<h2>Your Meals</h2>
<button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#mealModal">
    Добавить еду
</button>

<!-- Bootstrap Modal -->
<div class="modal fade" id="mealModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="modal-header">
                <h5 class="modal-title">Добавить еду</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <div class="modal-body">
                <form id="mealForm">
                    <div class="mb-3">
                        <label class="form-label">Дата и время</label>
                        <input type="datetime-local" class="form-control" name="dateTime" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Описание</label>
                        <input type="text" class="form-control" name="description" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Калории</label>
                        <input type="number" class="form-control" name="calories" required>
                    </div>

                </form>

            </div>
             <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Отмена</button>
                <button type="submit" form="mealForm" class="btn btn-primary">Сохранить</button>
            </div>



        </div>
    </div>
</div>
<form id="filterForm" class="row g-3 mb-3">
    <div class="col-auto">
        <label for="filterDate" class="form-label">Дата:</label>
        <input type="date" id="filterDate" name="date" class="form-control">
    </div>
    <div class="col-auto">
        <label for="filterUser" class="form-label">Пользователь:</label>
        <select id="filterUser" name="userId" class="form-select">
            <option value="">Все</option>
            <option value="100000">User</option>
            <option value="100001">Admin</option>
        </select>
    </div>
    <div class="col-auto align-self-end">
        <button type="submit" class="btn btn-primary">Применить</button>
        <button type="button" id="resetFilter" class="btn btn-secondary">Сбросить</button>
    </div>
</form>
<table id="mealsTable" class="display">
    <thead>
    <tr>
        <th>ID</th>
        <th>DateTime</th>
        <th>Description</th>
        <th>Calories</th>
        <th>Actions</th>
    </tr>
    </thead>
</table>

<script>
$(function () {
    // Инициализация DataTables
    const table = $("#mealsTable").DataTable({
       ajax: {
           url: "/api/meals",
           dataSrc: "meals"
       },
        columns: [
            { data: "id" },
            { data: "dateTime" },
            { data: "description" },
            { data: "calories" },
            {
                data: null,
                render: function (data, type, row) {
                    return `<a href="#" onclick="deleteMeal(${row.id})">Delete</a>`;
                }
            }
        ]
    });

    // AJAX добавление еды
    $("#mealForm").submit(function (event) {
        event.preventDefault();

        const formData = {
            dateTime: $("#mealForm [name='dateTime']").val(),
            description: $("#mealForm [name='description']").val(),
            calories: $("#mealForm [name='calories']").val()
        };

        $.ajax({
            type: "POST",
            url: "/api/meals",
            contentType: "application/json",
            data: JSON.stringify(formData),
            success: function () {
                const modal = bootstrap.Modal.getInstance(document.getElementById("mealModal"));
                modal.hide();
                $("#mealForm")[0].reset();
                table.ajax.reload();
            }
        });
    });

    // ===== AJAX фильтр =====
    $("#filterForm").submit(function(event){
        event.preventDefault();
        const params = $(this).serialize(); // собираем все поля формы
        table.ajax.url("/api/meals?" + params).load(); // подгружаем таблицу с фильтром
    });

    $("#resetFilter").click(function(){
        $("#filterForm")[0].reset();
        table.ajax.url("/api/meals").load(); // подгружаем все данные
    });
});

// AJAX удаление еды
function deleteMeal(id) {
    if (!confirm("Удалить запись?")) return;

    $.ajax({
        type: "DELETE",
        url: "/api/meals/" + id,
        success: function () {
            $("#mealsTable").DataTable().ajax.reload();
        }
    });
}
</script>

</body>
</html>
