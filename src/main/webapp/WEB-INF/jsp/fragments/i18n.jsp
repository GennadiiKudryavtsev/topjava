<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="page" value="${param.page != null ? param.page : 'common'}"/>

<script type="text/javascript">
    const i18n = {}; // https://learn.javascript.ru/object

    // Заголовки для кнопок "Добавить" / "Редактировать"
    i18n["addTitle"] = '<spring:message code="${page}.add" text="Добавить"/>';
    i18n["editTitle"] = '<spring:message code="${page}.edit" text="Редактировать"/>';

    // Общие сообщения
    <c:set var="keys" value="common.deleted,common.saved,common.enabled,common.disabled,common.errorStatus,common.confirm"/>
    <c:forEach var="key" items="${fn:split(keys, ',')}">
        i18n['${key}'] = '<spring:message code="${key}" text="${key}"/>';
    </c:forEach>
</script>