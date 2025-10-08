<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<html>
<head>
    <title>Meals</title>
</head>
<body>
<div class="jumbotron pt-4">
    <div class="container">
        <h3><a href="index.html">Home</a></h3>
        <hr>
        <h2>Meals</h2>
        <div id="datatable_wrapper" class="dataTables_wrapper dt-bootstrap4 no-footer">
            <div class="row">
                <div class="col-sm-12">
                    <table class="table table-striped dataTable no-footer" id="datatable" role="grid" aria-describedby="datatable_info" style="width: 1110px;">
                        <thead>
                        <tr role="row">
                            <th class="sorting_desc" tabindex="0" aria-controls="datatable" rowspan="1" colspan="1" aria-label="Дата/Время: activate to sort column ascending" aria-sort="descending" style="width: 167px;">Дата/Время</th>
                            <th class="sorting" tabindex="0" aria-controls="datatable" rowspan="1" colspan="1" style="width: 597px;" aria-label="Описание: activate to sort column ascending">Описание</th>
                            <th class="sorting" tabindex="0" aria-controls="datatable" rowspan="1" colspan="1" style="width: 114px;" aria-label="Калории: activate to sort column ascending">Калории</th>
                        </tr>
                        </thead>
                        <tbody>
                     <c:forEach var="meal" items="${mealToList}">
                         <tr style="background-color:${meal.excess ? 'red' : 'green'};">
                             <td>${fn:replace(meal.dateTime, 'T', ' ')}</td>
                             <td>${meal.description}</td>
                             <td>${meal.calories}</td>
                         </tr>
                     </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>