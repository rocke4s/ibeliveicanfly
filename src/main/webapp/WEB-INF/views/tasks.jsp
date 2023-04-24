<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=utf-8" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<html>
<head>

    <title>Задачи!</title>
    <style type="text/css">
        summary {
            background: #333;
            color: #FFF;
            border-radius: 3px;
            padding: 5px 10px;
        }

        /* Style the summary when details box is open */
        details[open] summary {
            background: #69c773;
            color: #333;
        }

        /* Custom Markers */
        #custom-marker summary {
            font-size: 17px;
            vertical-align: top;
        }

        #custom-marker summary::-webkit-details-marker {
            display: none;
        }

        #custom-marker summary:before {
            display: inline-block;
            width: 18px;
            height: 18px;
            margin-right: 8px;
            content: "";
            background-image: url(https://s3-us-west-2.amazonaws.com/s.cdpn.io/4621/treehouse-icon-sprite.png);
            background-repeat: no-repeat;
            background-position: 0 0;
        }

        #custom-marker[open] summary:before {
            background-position: -18px 0;
        }


        table {
            border: 0;
            width: 100%;
        }

        th, td {
            vertical-align: top;
            text-align: left;
            padding: 0.5em;
            border-bottom: 1px solid #E6E6E6;
        }

        th {
            width: 200px;
        }
        .layer1 {
            color: white; /* Цвет текста */
            padding: 10px; /* Поля вокруг текста */
            margin-bottom: -7px; /* Отступ снизу */
        }
        #chat-page ul {
            list-style-type: none;
            background-color: #FFF;
            margin: 0;
            overflow: auto;
            overflow-y: scroll;
            padding: 0 20px 0px 20px;
            height: calc(100% - 150px);
        }
    </style>
</head>
<body>
<div align="left">
    <c:if test="${pageContext.request.userPrincipal.name != null}">
        <form id="logoutForm" method="post" action="${contextPath}/logout">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </form>
        <h2>Список задач пользователя ${pageContext.request.userPrincipal.name}
        </h2>
        <sec:authorize access="hasRole('ROLE_USER')"> <!-- Проверяем, что пользователь авторизован -->
            <a href="/welcome" class="btn">Назад</a> <!-- Отображаем ссылку на профиль -->
        </sec:authorize>
    </c:if>
</div>
<c:forEach var="Task" items="${Tasks.getTasks()}">
    <details ><div class="layer1" margin-top="5px"  margin-bottom="5px"><button>Чат</button></div>
     <summary>Номер задачи: [${Task.getTaskNumber()}]; Название задачи - ${Task.getNameTask()}</summary>

            <table>
                <thead>
                <tr>
                    <c:if test="${!Task.getTaskUrl().isEmpty()}"><th>Ссылка</th></c:if>
                    <c:if test="${!Task.getTaskPartner().isEmpty()}"><th>Контрагент</th></c:if>
                    <c:if test="${!Task.getTaskStatus().isEmpty()}"><th>Состояние заявки</th></c:if>
                    <c:if test="${Task.getTaskStatus()=='Проверено' && Task.getTaskStatus()=='Выполнена' && Task.getTaskStatus()!='Отменено'}">
                        <th>Изменить состояние</th>
                    </c:if>
                    <c:if test="${!Task.getTypeTask().isEmpty()}"><th>Тип задачи</th></c:if>
                    <c:if test="${!Task.getTaskImportance().isEmpty()}"><th>Важность</th></c:if>
                    <c:if test="${!Task.getTaskContent().isEmpty()}"><th>Содержание</th></c:if>
                    <c:if test="${!Task.getTaskDeadline().isEmpty()}"><th>СрокДо</th></c:if>
                    <c:if test="${!Task.getTaskIntensity().isEmpty()}"><th>Трудоемкость</th></c:if>
                    <c:if test="${!Task.getTaskId().isEmpty()}"><th>ID</th></c:if>
                    <c:if test="${!Task.getTaskDataDone().isEmpty()}"><th>Дата Выполнено</th></c:if>
                    <c:if test="${!Task.getTaskContentLVR().isEmpty()}"><th>Содержание ЛУВР</th></c:if>
                    <c:if test="${!Task.getTaskData().isEmpty()}"><th>Дата</th></c:if>
                    <c:if test="${!Task.getTaskEmployee().isEmpty()}"><th>Сотрудник</th></c:if>
                </tr>
                </thead>
            <c:forEach var="Task" items="${Tasks.getTasks()}">
                <tr>
                    <c:if test="${!Task.getTaskUrl().isEmpty()}"><td>${Task.getTaskUrl()}</td></c:if>
                    <c:if test="${!Task.getTaskPartner().isEmpty()}"><td>${Task.getTaskPartner()}</td></c:if>
                    <c:if test="${!Task.getTaskStatus().isEmpty()}"><td>${Task.getTaskStatus()}</td></c:if>
                    <c:if test="${Task.getTaskStatus()=='Проверено' && Task.getTaskStatus()!='На доработке' &&
                                  Task.getTaskStatus()!='Выполнена' && Task.getTaskStatus()!='Отменено'}">
                        <td>
                            <div>
                                <form method="GET" action="/changestatus">
                                    <input type="hidden" value="${Task.getUidDoc()}" name="uidDoc_5">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                    <button type="submit">Доработка</button>
                                </form>
                            </div>
                        </td>
                    </c:if>
                    <c:if test="${Task.getTaskStatus()!='Проверено' && Task.getTaskStatus()!='Выполнена' && Task.getTaskStatus()!='Отменено'}">
                        <td>
                            <div>
                                <form method="GET" action="/changestatus">
                                    <input type="hidden" value="${Task.getUidDoc()}" name="uidDoc_8">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                    <button type="submit">Проверено</button>
                                </form>
                            </div>
                        </td>
                    </c:if>
                    <c:if test="${!Task.getTypeTask().isEmpty()}"><td>${Task.getTypeTask()}</td></c:if>
                    <c:if test="${!Task.getTaskImportance().isEmpty()}"><td>${Task.getTaskImportance()}</td></c:if>
                    <c:if test="${!Task.getTaskContent().isEmpty()}"><td>${Task.getTaskContent()}</td></c:if>
                    <c:if test="${!Task.getTaskDeadline().isEmpty()}"><td>${Task.getTaskDeadline()}</td></c:if>
                    <c:if test="${!Task.getTaskIntensity().isEmpty()}"><td>${Task.getTaskIntensity()}</td></c:if>
                    <c:if test="${!Task.getTaskId().isEmpty()}"><td>${Task.getTaskId()}</td></c:if>
                    <c:if test="${!Task.getTaskDataDone().isEmpty()}"><td>${Task.getTaskDataDone()}</td></c:if>
                    <c:if test="${!Task.getTaskContentLVR().isEmpty()}"><td>${Task.getTaskContentLVR()}</td></c:if>
                    <c:if test="${!Task.getTaskData().isEmpty()}"><td>${Task.getTaskData()}</td></c:if>
                    <c:if test="${!Task.getTaskEmployee().isEmpty()}"><td>${Task.getTaskEmployee()}</td></c:if>
                </tr>
            </c:forEach>

            </tr>
        </table>
        <div id="chat-page">
            <ul id="messageArea">

            </ul>
            <form id="messageForm" name="messageForm" nameForm="messageForm">
                <div class="form-group">
                    <div class="input-group clearfix">
                        <input type="text" id="message" placeholder="Введите сообщение..." autocomplete="off" class="form-control"/>
                        <button type="submit" class="primary">Отправить</button>
                    </div>
                </div>
            </form>
        </div>
    </details>
</c:forEach>
</div>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="${contextPath}/resources/js/bootstrap.min.js"></script>

</body>
</html>