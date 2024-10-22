<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix='fn' uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="com.google.gson.Gson" %> 
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
            <title>Trainer Calendar</title>
            <!-- calendar -->
            <script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js"></script>
			<!-- sweetalert2 -->
    		<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.14.1/dist/sweetalert2.all.min.js"></script>
			<link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.14.1/dist/sweetalert2.min.css" rel="stylesheet">
        </head>
        <body>
            <c:if test="${ not empty alertMsg }">
                <script>
                    Swal.fire({icon: 'success', title: '성공', text: "${alertMsg}"});
                </script>
                <c:remove var="alertMsg" scope="session"/>
            </c:if>
            <c:if test="${ not empty errorMsg }">
                <script>
                    Swal.fire({icon: 'warning', title: '실패', text: "${errorMsg}"});
                </script>
                <c:remove var="errorMsg" scope="session"/>
            </c:if>
            <!-- Page Wrapper -->
            <div id="wrapper">
                <c:choose>
                    <c:when test="${ not empty loginUser }">
                        <c:choose>
                            <c:when test="${ loginUser.userLevel == 2 }">
                                <jsp:include page="../common/sideTrainee.jsp"/>
                            </c:when>
                            <c:otherwise>
                                <jsp:include page="../common/sideTrainer.jsp"/>
                            </c:otherwise>
                        </c:choose>
                    </c:when>
                    <c:otherwise>
                        <jsp:include page="../common/sideTrainee.jsp"/>
                    </c:otherwise>
                </c:choose>
                <div id="content-wrapper" class="d-flex flex-column">
                    <!-- Main Content -->
                    <div id="content">
                        <jsp:include page="../common/topBar.jsp"/>
                        <!-- Begin Page Content -->
                        <div class="container-fluid">
						<!-- Page Heading -->
							<h1 class="h3 mb-4 text-gray-800">calendar</h1>
							
							<script>
								var sch = []
							</script>
							<c:forEach var="s" items="${schedule}">
								<script>
									sch.push({
										title:"${s.scheduleTitle}",
										start:"${s.startDate}",
										end:"${s.endDate}",
										backColor:"${s.backColor}"
									});
								</script>
							</c:forEach>
								<script>
									document.addEventListener('DOMContentLoaded', function () {
										
										const eventDate = sch.map(event => ({
											title: event.title,
											start: event.start,
											end: event.end,
											color: event.backColor,
										}))
										
										
										$("input[id=allday]").on('change', ()=>{
											if($("input[id=allday]").is(":checked")){
												// 체크 됐을 때
												$("#calendar_start_time").val("00:00");
												$("#calendar_end_time").val("00:00");
											}else{
												// 체크 해제 했을 때
												$("#calendar_start_time").val("");
												$("#calendar_end_time").val("");
											}
										})
										
										const calendarEl = document.getElementById('calendar');
										const calendar = new FullCalendar.Calendar(calendarEl,
											{
												customButtons:{
													
													saveButton:{
														text:"톡캘린더 저장하기",
														click: ()=>{
															const events = calendar.getEvents();
															const eventsData = events.map(event=> ({
																scheduleTitle: event.title,
																startDate: event.start ? event.start : null,
																endDate: event.end ? event.end : null,
																backColor: event.backgroundColor,
																allDay: event.allDay,
																scheduleDes: event.extendedProps.description,
															}));
															console.log(eventsData);
															$.ajax({
																url:"addCalendar.kt",
																type:"POST",
																contentType: 'application/json',
																data: JSON.stringify(eventsData),
																success:(result)=>{
																	if(result === "YYYC"){
																		Swal.fire({icon: 'success', text: "일정 저장 성공!"});
																	}else if(result === "NNNC"){
																		Swal.fire({icon: 'error', text: "일정 저장에 실패 했습니다"});
																	}else if(result === "DDDC"){
																		Swal.fire({icon: 'warning', text: "새로운 일정이 없습니다."});
																	}
																	
																},
																error:()=>{
																	console.log("add calendar ajax failed");
																},
															})
														}
													}
												},
												headerToolbar: {
													left: 'prev saveButton,today',
													center: 'title',
													right: 'dayGridMonth,dayGridWeek,dayGridDay next',
												},
												height: '800px',
												expandRows:true,
												themeSystem: 'bootstrap',
												initialView: 'dayGridMonth',
												selectable: true,
												editable: true,
												displayEventTime: true,
												events:eventDate,											
											}
											
										)
										calendar.render()
										calendar.on('eventClick', (info)=>{
											console.log(info);
										})
									
										
									})
									
								
								
								</script>
							<%-- </c:if> --%>
						<div id='calendar'></div>

					</div>
				</div>
			</div>
		</div>
	</body>
</html>