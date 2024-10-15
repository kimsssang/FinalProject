<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>트레이너 전용 운동 플랜 페이지</title>
<!-- Custom fonts for this template -->
<link href="resources/templates/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- FullCalendar cdn -->
<script
	src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js"></script>

<!-- 외부 css파일 -->
<link href="resources/css/trainerExercise.css" rel="stylesheet"
	type="text/css">
</head>

<body id="page-top">
	<!-- Page Wrapper -->
	<div id="wrapper">
		<jsp:include page="../common/sideTrainer.jsp" />
		<div id="content-wrapper" class="d-flex flex-column">
			<!-- Main Content -->
			<div id="content">
				<jsp:include page="../common/topBar.jsp" />
				<!-- Begin Page Content -->
				<div class="container-fluid">
					<h1 class="h3 mb-4 text-gray-800" style="font-weight: 600;">
						운동 플래너</h1>

					<div class="card mb-4 py-3 border-bottom-warning">
						<div style="display: flex;">
							&nbsp; &nbsp; &nbsp;
							<p>회원 선택 :</p>
							&nbsp; &nbsp; &nbsp; <select name="traineeExercise"
								class="selectTrainee" style="width: 130px; height: 25px;">
								<option value="none" autofocus>회원 선택하기</option>
								<c:forEach var="m" items="${list}">
									<option value="${m.userId}">${m.userName}</option>
								</c:forEach>
							</select>
						</div>
						
						<!-- 모달 - 스케줄 세부사항 -->
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
						                <p id="modalWorkoutTitle"></p>
						                <p id="modalWorkoutCategory"></p>
						                <p id="modalDifficulty"></p>
						                <p id="modalDescription"></p>
						            </div>
						            <div class="modal-footer">
						                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
						            </div>
						        </div>
						    </div>
						</div>

						<!-- <script>
						let calendar;
						
                        $(document).ready(function(){
                        	
                        	$('.selectTrainee').change(function(){
                        		let userName = $(this).find('option:selected').text(); // 선택된 회원의 이름 표시. val()은 회원의 아이디 표시
                            	let userId = $(this).find('option:selected').val(); // 선택된 회원의 아이디

                        		$('#trainee').text(userName + "님의 운동 계획하기");
                        		$('#addExerciseList').text(userName + "님의 스케줄 등록하기");
                        		
                        		// 트레이너가 선택한 회원의 모든 운동 스케줄 조회
                        		// 전달값이 userId 하나이므로
                        		// 2) String 문자열로 값 보내고 받기
                            	if(userId !== "none"){
                            		$.ajax({
                            			url: "selectWorkout.ex",
                            			method : "post",
                            			// contentType:"application/json; charset=utf-8", // 이것만으론 JSON 문자열임을 알릴 수 없다. contentType + JSON.stringify()로 변환해야 한다.
                            			// JSON.stringify를 사용하지 않는다면?
                            			// 이 경우 컨트롤러에서 request.getParameter 방식으로 userId를 가져와야 한다.
                            			// @RequestParam 사용
                            			data : {userId : userId},
                            			success: function(response){
                            				console.log("조회 성공");
                            				
                            				showWorkouts(response);
                            				
                            			},
                            			error : function(){
                            				console.log("조회 실패");
                            			},
                            		})
                            	}
                        	})
                        	
                        })
              
                        </script> -->

						<div style="display: flex;">
							<div class="card mb-3 py-2 border-bottom-info"
								style="width: 50%; margin: 50px; margin-right: 25px;">
								<h4
									style="margin-left: 10px; font-weight: 600; padding: 20px; margin: 20px;"
									align="center" id="trainee">운동 계획하기</h4>
								<div class="prescription" align="center">
									<div class="exercisePrescription">
										<span>운동 목적</span> <select class="selectExercise" name="goal">
											<option value="체중_감량">체중 감량</option>
											<option value="근력_증가">근력 증가</option>
											<option value="수술_후_재활">수술 후 재활</option>
											<option value="유연성_운동">유연성 운동</option>
											<option value="균형_증가">균형 증가</option>
											<option value="심혈관_기능증진">심혈관 기능증진</option>
										</select>
									</div>
									<div class="exercisePrescription">
										<span>운동 강도</span> <select class="selectExercise"
											name="fitness_level">
											<option value="basic">초급</option>
											<option value="intermediate">중급</option>
											<option value="advanced">고급</option>
										</select>
									</div>
									<div class="exercisePrescription">
										<span>운동 유형</span> <select class="selectExercise"
											name="exercise_types">
											<option value="cardiovascular">심혈관 운동</option>
											<option value="aerobic">유산소 운동</option>
											<option value="weight_triaing">무산소 운동(웨이트 트레이닝)</option>
											<option value="stretching">유연성 운동</option>
											<option value="calisthenics">맨몸운동</option>
										</select>
									</div>
									<div class="exercisePrescription">
										<span>기구 선택</span> <select class="selectExercise"
											name="equipment_available">
											<option value="none">필요 없음</option>
											<option value="dumbbell">아령</option>
											<option value="barbell">바벨</option>
											<option value="kettlebell">케틀벨</option>
											<option value="ball">공</option>
											<option value="theraband">세라밴드</option>
											<option value="yoga_mat">요가매트</option>
											<option value="theraband">세라밴드</option>
											<option value="foam_roller">폼롤러</option>
											<option value="treadmill">런닝머신</option>
										</select>
									</div>
									<div class="exercisePrescription">
										<span>건강 상태</span> <select class="selectExercise"
											name="health_conditions">
											<option value="none">정상</option>
											<option value="혈압조절장애">혈압조절장애</option>
											<option value="고지혈증">고지혈증</option>
											<option value="당뇨">당뇨</option>
											<option value="대사증후군">대사증후군</option>
											<option value="디스크(목,허리)">디스크(목,허리)</option>
											<option value="천식">천식</option>
											<option value="심혈관_질환">심혈관 질환</option>
											<option value="골다공증">골다공증</option>
											<option value="관절염">관절염</option>
											<option value="편두통">편두통</option>
											<option value="갑상선_장애">갑상선 장애</option>
										</select>
									</div>
									<div class="exercisePrescription">
										<span>스케줄(주n회)</span> <select class="selectExercise"
											name="days_per_week">
											<option value="1">1회</option>
											<option value="2">2회</option>
											<option value="3">3회</option>
											<option value="4">4회</option>
											<option value="5">5회</option>
											<option value="6">6회</option>
											<option value="7">7회</option>
										</select>
									</div>
									<div class="exercisePrescription">
										<span>운동 지속시간</span> <select class="selectExercise"
											name="session_duration">
											<option value="40">40초</option>
											<option value="50">50초</option>
											<option value="60">60초</option>
											<option value="90">90초</option>
											<option value="120">120초</option>
											<option value="150">150초</option>
										</select>
									</div>
									<div class="exercisePrescription">
										<span>주차별 기준 운동 기간</span> <select class="selectExercise"
											name="plan_duration_weeks">
											<option value="4">4주</option>
											<option value="8">8주</option>
											<option value="12">12주</option>
											<option value="16">16주</option>
										</select>
									</div>
									<button type="submit" class="btn btn-info btn-icon-split"
										id="aiPlan">운동 처방 생성하기!</button>
								</div>
							</div>

							<div class="card mb-4 py-3 border-bottom-primary"
								style="width: 50%; margin: 50px; margin-left: 25px;">
								<h4
									style="margin-left: 10px; font-weight: 600; padding: 20px; margin: 20px;"
									align="center">AI가 추천해준 운동계획</h4>
								<div class="prescription aiprep">

									<div class="btn btn-danger btn-circle" id="saveBtn">
										<i class="fas fa-check"></i>
									</div>
									<div class="aiRecommend aiInfo">
										<!-- 운동 정보 삽입될 예정 -->
									</div>
									<div class="aiRecommend aiProgram">
										<!-- 운동 프로그램 생성될 예정 -->
									</div>
								</div>
								<script>
                                // 동적으로 생성된 요소에 이벤트를 거는 방법
                                // 무조건 document.on이어야 한다. 
                                $(document).on('click', '#saveBtn', function(){
                                	makePdf(); // makePdf 함수 실행
                                })
                                
                                function makePdf(){ // makePdf함수 정의
                                	// 보내고 싶은 데이터를 객체에 설정
                                	let exerciseInfo = {
                                			// 운동설명은 객체 형태로
                                			exerciseDesc : {
                                				// aiInfo ul li의 0번째 인덱스의 텍스트를 :를 기준으로 쪼갰을 때(split) 2번쨰 인덱스에 담길 값
                                				days_per_week: $('.aiInfo ul li').eq(0).text().split(':')[1].trim(),
                                				total_weeks : $('.aiInfo ul li').eq(1).text().split(':')[1].trim(),
                                				fitness_level : $('.aiInfo ul li').eq(2).text().split(':')[1].trim(),
                                				goal : $('.aiInfo ul li').eq(3).text().split(':')[1].trim(),
                                				seo_content : $('.aiInfo ul li').eq(4).text().split(':')[1].trim(),
                                			},
                                			// 세부 운동 내용은 배열 형태로
                                			exercise : []
                                	};
                                	
                                	// 제이쿼리 순회 메소드 each
                                	$('.aiProgram .col').each(function(){
                                		let day = $(this).find('.planIndex').text();
                                		// 선택된 선택자(aiProgram col)에서 ul태그를 찾아 값을 추출함
                                		$(this).find('ul').each(function(){
                                			let exerciseDetails = {
                                				day : day,
                                				// ul객체 아래 li 객체의 0번째 인덱스의 텍스트는 xxx : xxx로 되어 있는데, 그걸 쪼개서(split) 만든 배열의 두번째 인덱스
                                				name : $(this).find('li').eq(0).text().split(':')[1],
                                				equipment : $(this).find('li').eq(1).text().split(':')[1],
                                				duration : $(this).find('li').eq(2).text().split(':')[1],
                                				repetitions : $(this).find('li').eq(3).text().split(':')[1],
                                				sets : $(this).find('li').eq(4).text().split(':')[1],
                                			};
                                			// 위 exercise []배열에 exerciseDetails를 집어넣음
                                			exerciseInfo.exercise.push(exerciseDetails);
                                		})
                                	})
                                	
                                	// 집어넣은 데이터 exerciseInfo를 갖고 데이터를 controller단의 exercisePdf.bo에 보낼 예정
                                	$.ajax({
                                		url :"exercisePdf.bo",
                                		type : "post",
                                		contentType : "application/json; charset=utf-8",
                                		// JSON.stringify를 통해 JSON문자열로 반환
                                		// 컨트롤러에서 @RequestBody를 작성했기 때문에 때문에 JSON문자열을 보내야 한다 - Json.stringify를 사용하는 이유
                                		data : JSON.stringify(exerciseInfo),
                                		// XMLHttpRequest객체에 특정속성을 설정할 수 있는 객체(ajax호출을 수행하는데 사용됨)
                                		// 응답 유형 설정 : 응답이 PDF와 같은 파일 다운로드를 처리하는데 중요한 blob파일이 되도록 지정
                                		xhrFields : {
                                			responseType : "blob",
                                		},
                                			 // blob에는 서버에서 반환된 pdf파일이 포함되어 있다.
                                		success : function(blob){
                                			// 파일을 다운로드 하기 위해 사용되는 요소 a가 필요하다(a로 innerHTML하는거랑 다름)
                                            const link = document.createElement('a');
                                            // blob을 나타내는 임시 URL을 생성(=createObjectURL)
                                			const url = window.URL.createObjectURL(blob);
                                            // a태그의 href를 url(blob링크가 있는 url객체)로 설정
                                            link.href = url;
                                            // 사용자가 파일을 다운로드할 때 기본 파일 이름을 지정함
                                            link.download = 'exercise_plan.pdf'; 
                                            
                                            // 다운로드에는 필요하지 않지만 호환성을 위해 추가되는 코드
                                            // 링크는 문서 본문에 일시적으로 추가된다.
                                            document.body.appendChild(link);
                                            link.click(); // 링크를 클릭하면 다운로드 시작(트리거)
                                            
                                            // DOM을 깨끗하게 유지하기 위해 문서에서 링크를 제거해야 한다.
                                            setTimeout(() => {
                                                document.body.removeChild(link);
                                                window.URL.revokeObjectURL(url); // blob url을 해제하여 메모리를 확보한다.
                                            }, 100);
                                		},
                                		error : function(result){
                                			console.log('pdf 생성 실패');
                                		}
                                	})
                                	
                                	
                                };
                                
                                </script>
							</div>
						</div>
					</div>
					<!-- 주간 달력 생성 -->
					<div class="col-md-2" style="display: inline;">
						<div class="card shadow mb-4">
							<div class="card-header py-3">
								<h6 class="m-0 font-weight-bold text-primary"
									id="addExerciseList">스케줄 등록</h6>
							</div>
							<div class="card-body" id='calendar'>
								<!-- 캘린더 들어오는 자리 -->
							</div>
						</div>
					</div>

					<!-- modal 추가 -->
					<div class="modal fade" id="calendarModal" tabindex="-1"
						role="dialog" aria-labelledby="exampleModalLabel"
						aria-hidden="true">
						<div class="modal-dialog" role="document">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="exampleModalLabel">회원 스케줄 등록</h5>
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
											<label><input type="checkbox" class="target"
												value="UE">상체</label> <label><input type="checkbox"
												class="target" value="ABS">복부</label> <label><input
												type="checkbox" class="target" value="LE">하체</label>
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
					</div>

					<script>
					
                    // 캘린더 데이터 관리
                    document.addEventListener('DOMContentLoaded', function() {
                    	
    					// 캘린더 값 조회 (원래 위에 있었는데 도저히 안되서 이사옴)
                        $(document).ready(function(){
                        	
                        	$('.selectTrainee').change(function(){
                        		let userName = $(this).find('option:selected').text(); // 선택된 회원의 이름 표시. val()은 회원의 아이디 표시
                            	let userId = $(this).find('option:selected').val(); // 선택된 회원의 아이디

                        		$('#trainee').text(userName + "님의 운동 계획하기");
                        		$('#addExerciseList').text(userName + "님의 스케줄 등록하기");
                        		
                        		// 트레이너가 선택한 회원의 모든 운동 스케줄 조회
                        		// 전달값이 userId 하나이므로
                        		// 2) String 문자열로 값 보내고 받기
                            	if(userId !== "none"){
                            		$.ajax({
                            			url: "selectWorkout.ex",
                            			method : "post",
                            			// contentType:"application/json; charset=utf-8", // 이것만으론 JSON 문자열임을 알릴 수 없다. contentType + JSON.stringify()로 변환해야 한다.
                            			// JSON.stringify를 사용하지 않는다면?
                            			// 이 경우 컨트롤러에서 request.getParameter 방식으로 userId를 가져와야 한다.
                            			// @RequestParam 사용
                            			data : {userId : userId},
                            			success: function(response){
                            				console.log("조회 성공");
                            				console.log(response);
                            				showWorkouts(response);
                            				
                            			},
                            			error : function(){
                            				console.log("조회 실패");
                            			},
                            		})
                            	}
                        	})
                        	
                        })
                    	
                    // 캘린더 설정화면	
				    const calendarEl = document.getElementById('calendar');
				    const calendar = new FullCalendar.Calendar(calendarEl, {
				        themeSystem: 'bootstrap5',
				        height: '600px',
				        initialView: 'dayGridMonth',
				        navLinks: true,
				        editable: true,
				        nowIndicator: true,
				        dayMaxEvents: true,
				        selectable: true,
				        weekNumbers: true,
				        displayEventTime: false,
				        headerToolbar: {
				            start: 'dayGridMonth,dayGridWeek,dayGridDay',
				            center: 'title',
				            end: 'today prev,next,addEventButton'
				        },
				        locale: 'ko',
				        events: [], // 조회 시 추가됨
				        customButtons: {
				            addEventButton: {
				                text: '일정 추가',
				                click: function() {
				                    $("#calendarModal").modal("show");
				                }
				            }
				        },
				        eventClick: function(info) {
				        	
				        	const plan = info.event;
				        	
				        	// 난이도에 대한 switch문 
						    switch (plan.extendedProps.difficulty) {
						    case 'M':
						        difficultyLabel = '중간';
						        break;
						    case 'L':
						        difficultyLabel = '쉬움';
						        break;
						    case 'H':
						        difficultyLabel = '어려움';
						        break;
						    default:
						        difficultyLabel = '없음';
							}
				        	
						 	// 표적에 대한 switch문 
						    switch (plan.extendedProps.workoutCategory) {
						    case 'UE':
						        category = '상체';
						        break;
						    case 'ABS':
						        category = '복부, 코어';
						        break;
						    case 'LE':
						        category = '하체';
						        break;
						    default:
						        category = '없음';
							}
				        	
			        	    // Populate the modal with the event details
			        	    $('#modalWorkoutTitle').text('제목: ' + plan.title);
						    $('#modalWorkoutCategory').text(' 운동 표적: '+ category);
						    $('#modalDifficulty').text('운동 난이도: ' + difficultyLabel);
						    $('#modalDescription').text('운동 설명: '+ plan.extendedProps.description);
							
			        	    // Show the modal
			        	    $('#eventModal').modal('show');
				        },
				    }); // calendar 로드 스크립트
				   
				    
				    // 캘린더에 데이터 추가할 값 받기
				    let ajaxRequest = null;
				
				    $("#addCalendar").on("click", function() {
				    	let userId = $(".selectTrainee").find('option:selected').val();
				        let title = $("#calendar_title").val();
				        let difficulty = $(".difficulty:checked").val();
				        let date = $("#calendar_date").val();
				        let selectTarget = $(".target:checked").val();
				        let description = $("#calendar_description").val();
				
				        // 정규화
				        if (!userId || userId === "none") {
				            alert("회원을 먼저 선택해 주세요.");
				        	return;
				        } else if (!title) {
				            alert("제목을 입력하세요.");
				            return;
				        } else if (!difficulty) {
				            alert("난이도를 선택하세요.");
				            return;
				        } else if (!date) {
				            alert("일자를 선택하세요.");
				            return;
				        } else if (!description) {
				            alert("설명을 작성하세요.");
				            return;
				        } else if (!selectTarget) {
				            alert("표적 부위를 선택하세요.");
				            return;
				        } else {
				        	
				        	// 여기에 ajax 시전
				        	// ajax 2번 호출되고 있어서 abort 사용
				        	if(ajaxRequest !== null){
				        		ajaxRequest.abort();
				        	}
				        	
				        	// 1) JSON객체로 값 보내고 받기
				        	ajaxRequest = $.ajax({
				        		url : "addExercise.bo",
				        		method : "post",
				        		data: JSON.stringify({ // JSON.stringify와 
				        		      userId: userId,
				        		      title: title,
				        		      difficulty: difficulty,
				        		      date: date,
				        		      description: description,
				        		      selectTarget: selectTarget
				        		  }),
				        		contentType : "application/json; charset=utf-8", // contetntType이 같이 사용되야 JSON객체로 주고받을 수 있다.
				        		success: function(response){
				        			
				        			// Controller에서 삼항 연산자로 성공하면 "success"가 나오게, 실패하면 "error"가 나오게 설정했다.
				        			// response가 success라는 단어로 나온다면
				        			if(response.result === "success"){
				        				alert("운동 계획이 성공적으로 추가되었습니다.");
				                      
					        			// 값 초기화
					        			$("#calendarModal").modal("hide");
					        			$("#calendar_title").val("");
					        			$("#calendar_description").val("");
					        			$("#calendar_date").val("");
					        			$("input[type='checkbox']").prop('checked', false);
					        			
				        			}
				        		
				        		},
				        		error : function(){
				        			console.log("추가 실패");
				        		},
				        	});
				        }
				    });// 캘린더에 값 넣기(insert문)
				    
				    // 캘린더 렌더링
				    calendar.render();
				    
				    // 삽입한 캘린더 값으로부터 결과 조회하고 캘린더에 표시하기
				    function showWorkouts(response){

				    	if (Array.isArray(response) && response.length > 0) {
				            response.forEach(event => {
				            	
				            	// console.log("Adding event:", event.workoutTitle);
				            	 
				                // Extract values from each event object
				                let eventDate = event.workoutDate; // Get workoutDate
				                let eventStart = eventDate; // Using the same date for start
				                let eventEnd = eventDate; // Adjust if you need a specific duration
				                
				                // Add each event to the calendar
				                calendar.addEvent({
				                    title: event.workoutTitle,
				                    start: new Date(event.workoutDate), // Ensure this is a Date object
				                    extendedProps: {
				                        difficulty: event.difficulty,
				                        workoutCategory: event.workoutCategory,
				                        description: event.description,
				                    }
				                });
				                
				            });

				            // Render the calendar after adding events
				            calendar.render();
				        } else {
				            console.error("이벤트 삽입이 안되용");
				        }
        				
                    } // showWorkouts
				    
				});// document.addEventListener('DOMContentLoaded', function
                   
				</script>
				</div>

				<script>
                // ai 플랜 출력 스크립트
                $(function(){
                	
                	$("#aiPlan").click(function(){
                        $.ajax({
                		url:"exercisePlan.bo",
                		type:"POST",
                		contentType:"application/json; charset=utf-8",
                		data:JSON.stringify({
	                         goal: encodeURIComponent($('select[name="goal"]').val()),
	                         fitness_level : encodeURIComponent($('select[name="fitness_level"]').val()),
	                         exercise_types : encodeURIComponent($('select[name="exercise_types"]').val()),
	                         equipment_available : encodeURIComponent($('select[name="equipment_available"]').val()),
	                         health_conditions : encodeURIComponent($('select[name="health_conditions"]').val()),
	                         days_per_week : encodeURIComponent($('select[name="days_per_week"]').val()),
	                         session_duration : encodeURIComponent($('select[name="session_duration"]').val()),
	                         plan_duration_weeks : encodeURIComponent($('select[name="plan_duration_weeks"]').val()),
                		}),
                		success: function(data){
                			
                			let exerciseArr = data.result;
                			let info = '<span>운동 정보</span>';
                			let value = '<span> 운동스케줄 </span> <br /> <div class = "row">';
                			
                			//aiInfo 메소드
                			
               				info += '<div>'
               				      + '<ul>'
               				      + '<li> 회수 : 주 ' + exerciseArr.schedule.days_per_week + '회 </li>'
               				      + '<li> 플랜 기간 : ' + exerciseArr.total_weeks + '주 </li>'
               				      + '<li> 난이도 : ' + exerciseArr.fitness_level + '</li>'
               				      + '<li> 운동 목적 : ' + exerciseArr.goal + '</li>'
               				      + '<li> 프로그램 설명 : ' + exerciseArr.seo_content + '</li>'
               					  + '</ul>'
               					  + '</div>';
                				      
                			
                			//aiProgram 메소드
                			$.each(exerciseArr.exercises, function(index, exerciseDay){
                				value += '<div class = "col">'
                				      + '<div class = "planIndex">' + exerciseDay.day + ' 운동 </div>'
                				  
                				let sessionCount = 1;
                				      
                			  $.each(exerciseDay.exercises, function(i, exercise){
                					value += '<div>' + sessionCount + '회차 운동 </div>'
		              				      + '<br />'
		            				      + '<ul>'
		            				      + '<li> 운동명 :' + exercise.name +'</li>'
		            				      + '<li> 기구 :' + exercise.equipment +'</li>'
		            				      + '<li> 지속 기간 :' + exercise.duration +'</li>'
		            				      + '<li> 횟수 : ' + exercise.repetitions +'</li>'
		            				      + '<li> 세트수 : ' + exercise.sets +'</li>'
                				  	      + '</ul>'
		            				      + '<br />';
                				  	      sessionCount++;
                			  })	      
                				value += '</div>'; //col
                					   + '</div>' //row
                				       + '<br />';
                			}); // aiProgram을 위한 메소드
                			
                			$('.aiInfo').html(info);
                			$('.aiProgram').html(value);
                			
                		},
                		error : function(){
                			console.log("ajax실패");
                		}
                	})
                    })
                })
                </script>

			</div>
		</div>
	</div>
</body>
</html>
