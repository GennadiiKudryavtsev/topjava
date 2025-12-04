<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<html>
<jsp:include page="fragments/headTag.jsp"/>
<head>
    <link rel="stylesheet"
          href="https://cdn.datatables.net/1.13.1/css/jquery.dataTables.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">
</head>

<body>
<jsp:include page="fragments/bodyHeader.jsp"/>

<section class="container mt-3">

    <h3><spring:message code="meal.title"/></h3>

    <!-- FILTER FORM -->
    <form id="filterForm" class="row g-3">

        <div class="col-md-3">
            <label class="form-label"><spring:message code="meal.startDate"/></label>
            <input type="date" name="startDate" class="form-control" value="${param.startDate}">
        </div>

        <div class="col-md-3">
            <label class="form-label"><spring:message code="meal.endDate"/></label>
            <input type="date" name="endDate" class="form-control" value="${param.endDate}">
        </div>

        <div class="col-md-3">
            <label class="form-label"><spring:message code="meal.startTime"/></label>
            <input type="time" name="startTime" class="form-control" value="${param.startTime}">
        </div>

        <div class="col-md-3">
            <label class="form-label"><spring:message code="meal.endTime"/></label>
            <input type="time" name="endTime" class="form-control" value="${param.endTime}">
        </div>

        <div class="col-md-12 mt-2">
            <button type="submit" class="btn btn-primary">
                <spring:message code="meal.filter"/>
            </button>
            <button type="button" id="resetFilter" class="btn btn-warning">
                Сбросить
            </button>
        </div>
    </form>

    <hr>

    <!-- ADD BUTTON -->
    <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#mealModal">
        <spring:message code="meal.add"/>
    </button>

    <hr>

    <!-- DATATABLE -->
    <table id="mealsTable" class="display table table-striped">
        <thead>
        <tr>
            <th>ID</th>
            <th><spring:message code="meal.dateTime"/></th>
            <th><spring:message code="meal.description"/></th>
            <th><spring:message code="meal.calories"/></th>
            <th></th>
        </tr>
        </thead>
    </table>
</section>

<!-- MODAL -->
<div class="modal fade" id="mealModal" tabindex="-1">
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
                <button class="btn btn-secondary" data-bs-dismiss="modal">Отмена</button>
                <button class="btn btn-primary" onclick="createMeal()">Сохранить</button>
            </div>
        </div>
    </div>
</div>

<jsp:include page="fragments/footer.jsp"/>

<!-- JS -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.datatables.net/1.13.1/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>

    let table;

    $(function () {
        table = $("#mealsTable").DataTable({
            "ajax": {
                "url": "ajax/meals",
                "dataSrc": ""
            },
            "columns": [
                {"data": "id"},
                {"data": "dateTime"},
                {"data": "description"},
                {"data": "calories"},
                {
                    "data": null,
                    "render": function (data, type, row) {
                        return `<a href="#" onclick="deleteMeal(${row.id})">Удалить</a>`;
                    }
                }
            ]
        });
    });

    // CREATE MEAL
