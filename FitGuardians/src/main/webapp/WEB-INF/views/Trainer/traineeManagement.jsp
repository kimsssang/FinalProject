<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Trainer's Dashboard</title>
<!-- Custom fonts for this template-->
    <link href="resources/templates/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    
    <!-- FullCalendar cdn -->
    <script src="
    https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js
    "></script>

    <!-- 해당 파일 외부 css -->
    <link href="resources/css/traineeManagement.css" rel="stylesheet" type="text/css">

</head>

<body>

    <body id="page-top">
        <!-- Page Wrapper -->
        <div id="wrapper">
         <jsp:include page="../common/sideTrainer.jsp" />
         <div id="content-wrapper" class="d-flex flex-column">
         <!-- Main Content -->
             <div id="content">
                 <jsp:include page="../common/topBar.jsp"/>
                 <!-- Begin Page Content -->
                    <div class="container-fluid">
					
						<!-- Page Heading -->
                        <h1 class="h3 mb-4 text-gray-800" style="font-weight:600;">회원 관리</h1>		

                         <!-- 회원 관리 카드 row -> 회원 한명씩 추가될 때 마다 col 카드 추가 -->

                            <div class="row">

                                <div class="col-lg-6">
                                <c:forEach var="m" items="${list}">
                                    <div class="card mb-3 py-4 border-left-primary">
                                        <div class="card-body"  style="display:flex;">
                                            <div style="margin-left:30px;">
                                                <div style="border-radius:50%; border:1px solid royalblue; width:150px; height:150px; overflow:hidden;">
                                                    <img src="${ pageContext.request.contextPath }/resources/uploadFiles/manprofile.PNG" style="max-width:100%; max-height:100%; object-fit:cover;"/>
                                                
                                                </div>
                                            </div>
                                            <div style="margin-left:30px;">
                                                <a class = "traineeName" href="traineeDetail.me?userId=${m.userId}" style="cursor:pointer; text-decoration:none;">${m.userName}</a>
                                                <br/>
                                                <span>나이 : ${m.age}살</span> &nbsp;&nbsp;&nbsp;&nbsp; <span>성별: ${m.gender}</span> <br/>
                                                <span>키 : ${m.height}cm</span> &nbsp;&nbsp;&nbsp;&nbsp; <span>몸무게 : ${m.weight}kg</span> <br/>
                                                <span>골격근량 : <fmt:formatNumber value="${m.smm}" pattern="#.#" /> &#37;</span> &nbsp;&nbsp;&nbsp;&nbsp; <span>BMI(체질량지수) :  <fmt:formatNumber value="${m.bmi}" pattern="#.#" /> &#37;</span> &nbsp;&nbsp;&nbsp;&nbsp; <span>체지방량 : <fmt:formatNumber value="${m.fat}" pattern="#.#" /> &#37;</span> <br/>
                                                <span>운동 목표 : ${m.goal}</span> <br/>
                                            </div>
                                        </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>

                        <!-- 회원 관리 카드 끝 -->

                    </div>
             </div>
         </div>
        </div>
    </body>

</body>
</html>