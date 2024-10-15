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
		<!-- bootstrap	
		<link href='https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/css/bootstrap.css' rel='stylesheet'>
		<link href='https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@5.13.1/css/all.css' rel='stylesheet'>
		-->

		<!-- 외부 자바스크립트 -->
		<script defer src="./resources/js/traineeExerciseCalendar.js"></script>
		
	 	<!-- sweetalert2 -->
	    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.14.1/dist/sweetalert2.all.min.js"></script>
		<link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.14.1/dist/sweetalert2.min.css" rel="stylesheet">
		
		<style>
		input[type=checkbox]{
			margin:10px;
			text-align: center;
		}
		
		
		</style>

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
						<h1 class="h3 mb-4 text-gray-800">오늘 운동 계획표 입력하기</h1>
							
						<div id='calendar'></div>

						<!-- modal 입력창 -->
							<div class="modal fade" id="calendarModal" tabindex="-1"
							role="dialog" aria-labelledby="exampleModalLabel"
							aria-hidden="true">
							<div class="modal-dialog" role="document">
								<div class="modal-content">
									<div class="modal-header">
										<h5 class="modal-title" id="exampleModalLabel">${loginUser.userName}의 운동 플랜 기록하기</h5>
										<button type="button" class="close" data-dismiss="modal"
											aria-label="Close">
											<span aria-hidden="true">&times;</span>
										</button>
									</div>
									<div class="modal-body">
										<div class="form-group">
											<label for="taskId" class="col-form-label">일정 제목</label> <input
												type="text" class="form-control" id="calendar_title"
												name="calendar_title"> <label for="taskId"
												class="col-form-label">난이도</label>
											<div style="display: flex;">
												<label><input type="checkbox" class="difficulty"
													value="H">어려움(H)</label> <label><input
													type="checkbox" class="difficulty" value="M">보통(M)</label> <label><input
													type="checkbox" class="difficulty" value="L">쉬움(L)</label>
											</div>

											<label for="taskId" class="col-form-label">운동 부위</label>
											<div style="display: flex;">
												<select id="muscleGroup" class="form-select" name="muscle">
													<option value="none">선택하세요</option>
													<option value="biceps">이두근</option>
													<option value="triceps">삼두근</option>
													<option value="chest">가슴근</option>
													<option value="abdominals">복근</option>
													<option value="lats">광배근</option>
													<option value="back">등근</option>
													<option value="glutes">엉덩이근</option>
													<option value="quadriceps">사두근</option>
													<option value="hamstrings">햄스트링근</option>
												</select>
											</div>

											<label for="taskId" class="col-form-label">운동일</label> <input
												type="date" class="form-control" id="calendar_date"
												name="calendar_date"> <label for="taskId"
												class="col-form-label">운동 내용</label>
											<textarea class="form-control" id="calendar_description"
												name="calendar_description" style="height: 200px;"></textarea>

										</div>
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-warning" id="addCalendar">추가</button>
										<button type="button" class="btn btn-secondary"
											data-dismiss="modal" id="sprintSettingModalClose">취소</button>
									</div>

								</div>
							</div>
						<script>
							
							$("#addCalendar").on("click", function() {
								
							
							// 로그인한 회원의 아이디로 데이터를 저장할 것이므로..
							let userId = '${loginUser.userId}';
							let title = $('#calendar_title').val();
							let difficulty = $(".difficulty:checked").val();
							let date = $("#calendar_date").val();
							let selectTarget = $("select[name='muscle']").val();
							let description = $("#calendar_description").val();
							
							console.log(userId, title, difficulty, date, selectTarget, description)

							// 정규화
							if (!title) {
							Swal.fire({
							title: "제목을 입력하세요",
							icon: "warning",
							});
							} else if (!difficulty) {
							Swal.fire({
							title: "난이도를 선택하세요.",
							icon: "warning",
							});
							} else if (!date) {
							Swal.fire({
							title: "일자를 선택하세요.",
							icon: "warning",
							});
							} else if (!description) {
							Swal.fire({
							title: "설명을 작성하세요.",
							icon: "warning",
							});
							} else if (selectTarget === "none") {
							Swal.fire({
							title: "표적 부위를 선택하세요.",
							icon: "warning",
							});
							} else {
						 
								$.ajax({
									url : "addTraineeExPlan.tn",
									method : "post",
									contentType : 'application/json; charset=utf-8',
									data: JSON.stringify({
										userId : userId,
										title : title,
										difficulty : difficulty,
										date : date,
										target : selectTarget,
										description: description,
									}),
									success: function(response){
										 // "success"로 값을 받았더니 안된다
										 // 너무 안되서 그냥 1 받는걸로 했다.
										if(response === 1){
											
										Swal.fire({
											title: "플랜이 성공적으로 추가되었습니다.",
											icon: "success",
											});
											
											// 값 초기화
											$("#calendarModal").modal("hide");
											$("#calendar_title").val("");
											$("#calendar_description").val("");
											$("#calendar_date").val("");
											$("select[name='muscle']").prop('selectedIndex', 0); // 첫번째 값 선택되도록
											
										}else{
										 Swal.fire({
								            title: "플랜 추가에 실패했습니다.",
								            icon: "error",
									        });
										}
									 
									},
									error : function(){
										//console.log("추가 실패");
									},
								});
							}
						});
						</script>
						<script>
							let exPlanList = ${list};
						</script>
						<script src="./resources/js/traineeExerciseCalendar.js"></script>
					</div>

					<!-- 회원의 입력 플래너 보기 -->
					<div class="modal fade" id="eventModal" tabindex="-1" role="dialog" aria-labelledby="eventModalLabel" aria-hidden="true">
						<div class="modal-dialog" role="document">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="eventModalLabel">운동 세부일정표</h5>
									<button type="button" class="close" data-dismiss="modal" aria-label="Close">
										<span aria-hidden="true">&times;</span>
									</button>
								</div>
								<div class="modal-body">
									<p id="modalExerciseNo" style="display:none;"></p>
									<p id="modalWorkoutTitle"></p>
									<p id="modalWorkoutTarget"></p>
									<p id="modalDifficulty"></p>
									<p id="modalDescription"></p>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
									<button type="button" class="btn btn-danger" data-dismiss="modal" onclick="deleteExPlan();">삭제</button>
								</div>
							</div>
						</div>
					</div>
					<script>
						// 플래너 삭제버튼 구현
						function deleteExPlan(){
							let exerciseNo = $('#modalExerciseNo').text();
							$.ajax({
								url : "deleteTraineeExPlan.tn",
								method : "post",
								data : {
									exerciseNo : exerciseNo,
								},
								success : function(result){
									if(result == 1){
										Swal.fire({
											title: "플랜이 성공적으로 삭제되었습니다.",
											icon: "success",
											});
									}
								},
								error : function(){
									
								},
							})
						}
					</script>
				</div>
			</div>
		</div>
	</body>
</html>