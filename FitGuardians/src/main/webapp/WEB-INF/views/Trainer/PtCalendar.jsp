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
			<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
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
							<select class="mb-4 col-1 custom-select" id="selectTrainee">
								<option value="none" autofocus>회원 선택</option>
								<c:forEach var="m" items="${list}">
									<option value="${m.userId}">${m.userName}</option>
								</c:forEach>
							</select>
							
							<script>
								var sch = []
							</script>
							<c:forEach var="s" items="${schedule}">
								<script>
									sch.push({
										title:"${s.scheduleTitle}",
										start:"${s.startDate}",
										end:"${s.endDate}",
										allDay: "${s.allDay}",
										backColor:"${s.backColor}"
									});
								</script>
							</c:forEach>
							<!-- 캘린더 조회, 저장,  -->
							<script>
							
								document.addEventListener('DOMContentLoaded', function () {
									const userNo = ${loginUser.userNo};
									const eventDate = sch.map(event => ({
										title: event.title,
										start: event.start,
										end: event.end,
										color: event.backColor,
										allDay: event.allDay === 'true' ? true : false,
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
												addEventButton:{
													text:"일정 추가",
													click: ()=>{
														if($("#selectTrainee").val()=== "none"){
															Swal.fire({icon:"warning", title:"회원을 선택해주세요"})
															
														}else{
															$("#calendarModal").modal("show");
														}
													}
												},
												saveButton:{
													text:"저장하기",
													click: ()=>{
														const events = calendar.getEvents();
														const eventsData = events.map(event=> ({
															userNo: userNo,
															ptUser:$("#selectTrainee").val(),
															scheduleTitle: event.title,
															startDate: event.start ? event.start.toISOString() : null,
															endDate: event.end ? event.end.toISOString() : null,
															backColor: event.backgroundColor,
														}));
														console.log(eventsData);
														$.ajax({
															url:"addCalendar.pt",
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
												left: 'prev addEventButton,saveButton,today',
												center: 'title',
												right: 'dayGridMonth,dayGridWeek,dayGridDay next',
											},
											height: '800px',
											expandRows:true,
											slotMinTime: '08:00',
											slotMaxTime: '22:00',
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
								
									// 캘린더에 추가
									$("#addCalendar").on("click",()=>{
										
										let start_date = $("#calendar_start_date").val();
										let end_date = $("#calendar_end_date").val();
										let start_time = $("#calendar_start_time").val();
										let end_time = $("#calendar_end_time").val();
										let allday = $("input[id=allday]").is(":checked");
										
										
										
										var eventData = {
												title: $("#calendar_content").val(),
												start: new Date(start_date + "T" + start_time),
												end: new Date(end_date + "T" + end_time),
												color: $("#color").val(),
												allday: allday,
										}
										
										
										if(eventData.title === null || eventData.title === ""){
											Swal.fire({icon: 'warning', text: "내용을 입력해주세요"});
										}else if(eventData.start === "" || eventData.end === ""){
											Swal.fire({icon: 'warning', text: "날짜를 입력해주세요"});
										}else if(new Date(eventData.end)- new Date(eventData.start) < 0){
											Swal.fire({icon: 'warning', text: "종료일이 시작일보다 먼저입니다"});
										}else if(start_time === "" || end_time === ""){
											Swal.fire({icon: 'warning', text: "시간을 입력해주세요"});
										}else if(eventData.end.valueOf() < eventData.start.valueOf()){
											Swal.fire({icon: 'warning', text: "종료시간이 시작시간보다 먼저입니다"});
										}else{
											calendar.addEvent(eventData);
											$("#calendarModal").modal("hide");
											$("#calendar_content").val("")
											$("#calendar_start_date").val("");
											$("#calendar_end_date").val("");
											$("#calendar_start_time").val("");
											$("#calendar_end_time").val("");
											$("#calendar_description").val("");
											$("input[id=allday]").prop("checked", false);
										}
									})

									// 회원별 캘린더 내용 가져와서 보여주기 
									$("#selectTrainee").change(function(){
										const userId = $(this).val();
										
										console.log(userId);
										$.ajax({
											url:"selectCalendar.pt",
											data:{
												"userId":userId,
												"userNo":userNo
											},
											success:(result)=>{
												console.log(result);
												sch = [];
												for(event of result){
													console.log(event);
													sch.push({
														title: event.scheduleTitle,
														start: event.startDate,
														end:event.endDate,
														color:event.backColor,
														allDay:event.allDay,
														
													});
												}
												
												// 캘린더에 기존 이벤트 제거
												const existingEvents = calendar.getEvents(); // 현재 이벤트 가져오기
												existingEvents.forEach(event => event.remove()); // 모든 이벤트 삭제

												// 새 이벤트 추가
												sch.forEach(event => {
													calendar.addEvent(event);
												});

												calendar.render(); // 캘린더 다시 렌더링
											},
											error:()=>{
												console.log("select clandar ajax failed");
												
											}
										})
									})
									
									flatpickr("#calendar_start_time", {
							            enableTime: true,
							            noCalendar: true,
							            dateFormat: "H:i",
							            minTime: "00:00",
							            maxTime: "23:55",
							            minuteIncrement: 5 // 5분 단위로 증가
							        });
									
									flatpickr("#calendar_end_time", {
							            enableTime: true,
							            noCalendar: true,
							            dateFormat: "H:i",
							            minTime: "00:00",
							            maxTime: "23:55",
							            minuteIncrement: 5 // 5분 단위로 증가
							        });
									
									
								})
								
							</script>
							
					
							
						<div id='calendar'></div>

						<div class="modal fade" id="calendarModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
							<div class="modal-dialog" role="document">
								<div class="modal-content">
									<div class="modal-header">
										<h5 class="modal-title" id="exampleModalLabel">일정을 입력하세요.</h5>
										<button type="button" class="close" data-dismiss="modal" aria-label="Close">
											<span aria-hidden="true">&times;</span>
										</button>
									</div>
									<div class="modal-body">
										<div class="form-group">
											<label for=taskId class="col-form-label">색상</label>
											<select id="color" class="form-control">
												<option value="blue">파랑색</option>
												<option value="red">빨강색</option>
												<option value="orange">주황색</option>
												<option value="yellow">노랑색</option>
												<option value="green">초록색</option>
												<option value="indigo">남색</option>
												<option value="purple">보라색</option>
											</select>
											<label for="taskId" class="col-form-label">일정 내용</label>
											<input type="text" class="form-control" id="calendar_content" name="calendar_content">
											<label for="taskId" class="col-form-label">시작 날짜</label>
											<input type="date" class="form-control" id="calendar_start_date" name="calendar_start_date">
											<label for="taskId" class="col-form-label">종료 날짜</label>
											<input type="date" class="form-control" id="calendar_end_date" name="calendar_end_date">
											<label for="taskId" class="col-form-label">시작 시간</label>
											<input type="text" class="form-control" name="calendar_start_time" id="calendar_start_time">
											<label for="taskId" class="col-form-label">종료 시간</label>
											<input type="text" class="form-control" name="calendar_end_time" id="calendar_end_time">
											<label for="taskId" class="col-form-label">하루종일</label>
											<input type="checkbox" id="allday" name="allday"/> 
										</div>
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-warning" id="addCalendar">추가</button>
										<button type="button" class="btn btn-secondary" data-dismiss="modal"
											id="sprintSettingModalClose">취소</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
	</body>
</html>