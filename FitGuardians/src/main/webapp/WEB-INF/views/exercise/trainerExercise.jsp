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

<!-- 외부 자바스크립트 파일 : 캘린더 -->
<script defer src ="resources/js/exerciseCalendar.js"></script>

 <!-- sweetalert2 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.14.1/dist/sweetalert2.all.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.14.1/dist/sweetalert2.min.css" rel="stylesheet">

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
						
					<!-- 운동 검색창 -->	
					<div class = "card mb-4 py-3 border-bottom-warning">
					<div style="font-weight:700; font-size:20px; margin:10px;">운동 검색창</div>
					
						 <div class="card mb-4 py-3 border-bottom-info" style="margin:20px;">
					        <div id="exerciseSearchForm" >
					            <div class="mb-3 searchEx">
					                <label for="exerciseType" class="form-label">운동 종류</label>
					                <select id="exerciseType" class="form-select" name="type">
					                    <option value="none">선택하세요</option>
					                    <option value="cardio">유산소</option>
					                    <option value="stretching">스트레칭</option>
					                    <option value="strength">근력운동</option>
					                    <option value="powerlifting">파워리프팅</option>
					                    <option value="plyometrics">플라이오메트릭스</option>
					                </select>
					            </div>
					
					            <div class="mb-3 searchEx">
					                <label for="muscleGroup" class="form-label">타겟 근육</label>
					                <select id="muscleGroup" class="form-select" name="muscle">
					                    <option value="none">선택하세요</option>
					                    <option value="neck">목근</option>
					                    <option value="biceps">이두근</option>
					                    <option value="triceps">삼두근</option>
					                    <option value="chest">가슴근</option>
					                    <option value="forearms">팔꿈치 아래근</option>
					                    <option value="traps">승모근</option>
					                    <option value="abdominals">복근</option>
					                    <option value="lats">광배근</option>
					                    <option value="middle_back">중간 등근</option>
					                    <option value="lower_back">하부 등근</option>
					                    <option value="glutes">엉덩이근</option>
					                    <option value="quadriceps">사두근</option>
					                    <option value="hamstrings">햄스트링근</option>
					                    <option value="abductors">외전근</option>
					                    <option value="adductors">내전근</option>
					                    <option value="calves">종아리근</option>
					                </select>
					            </div>
					
					            <div class="mb-3 searchEx">
					                <label for="difficulty" class="form-label">난이도</label>
					                <select id="difficulty" class="form-select" name="difficulty">
					                    <option value="none">선택하세요</option>
					                    <option value="beginner">쉬움</option>
					                    <option value="intermediate">중간</option>
					                    <option value="expert">어려움</option>
					                </select>
					            </div>
					
					            <button type="button" class="btn btn-info searchExercise" id="searchExercise">검색</button>
					        </div>
					    </div>
					    
					    <script>
					    $(document).ready(function(){
					    	$('#searchExercise').click(()=>{
					    		let type = $('#exerciseType').val();
					    		let muscle = $('#muscleGroup').val();
					    		let difficulty = $('#difficulty').val();
					    		
					    		// console.log(type);
					    		// console.log(muscle);
					    		// console.log(difficulty);
					    		
					    		$.ajax({
					    			url:'searchEx.ex',
					    			type:'get',
					    			data :{
					    				type:type,
					    				muscle:muscle,
					    				difficulty:difficulty,
					    			},
					    			success : (result)=>{
					    				console.log("성공쓰");
					    				
					    				$('.exerciseTable tbody').empty();
					    				let value = '';
					    				
					    				$.each(result, function(index, ex){
					    					value += '<tr>'
					    					       + '<td>' + ex.name + '</td>'
					    					       + '<td>' + ex.type + '</td>'
					    					       + '<td>' + ex.muscle + '</td>'
					    					       + '<td>' + ex.equipment + '</td>'
					    					       + '<td>' + ex.difficulty + '</td>'
					    					       + '<td>' + ex.instructions + '</td>'
					    					       + '</tr>'
					    				})
					    				
					    				$('.exerciseTable tbody').html(value);
					    				
					    			},
					    			error : ()=>{
					    				console.log("실패해부러쓰");
					    			},
					    			
					    		})
					    		
					    	})
					    	
					    })
					    
					    </script>
					    <div class="card mb-4 py-3 border-bottom-primary" style="margin:20px; padding:20px;">
							  <div class="container mt-5">
								 <h4>운동 목록</h4>
							        <table class="table table-bordered exerciseTable">
							            <thead class="thead-light">
							                <tr>
							                    <th>운동 이름</th>
							                    <th>운동 종류</th>
							                    <th>타겟 근육</th>
							                    <th>장비</th>
							                    <th>난이도</th>
							                    <th>설명</th>
							                </tr>
							            </thead>
							            <tbody>
							               <!-- 여기에 값 들어올 예정 -->
							            </tbody>
							        </table>
							  </div>
					    </div>
					</div>
					

					<div class="card mb-4 py-3 border-bottom-warning">
						<div style="font-weight:700; font-size:20px; margin:10px;">AI 운동플래너</div>
						<div style="display: flex;">
							&nbsp; &nbsp; &nbsp; <p>회원 선택 :</p>
							&nbsp; &nbsp; &nbsp; <select name="traineeExercise"
								class="selectTrainee" style="width: 130px; height: 25px;">
								<option value="none" autofocus>회원 선택하기</option>
								<c:forEach var="m" items="${list}" varStatus="status">
									<option value="${m.userId}" 
									data-user-no="${m.userNo}" 
									data-goal="${miList[status.index].goal}" 
									data-disease="${miList[status.index].disease[0]}">
									${m.userName}
									</option>
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
						            	<p id="modalExerciseNo" style="display:none;"></p>
						                <p id="modalWorkoutTitle"></p>
						                <p id="modalWorkoutCategory"></p>
						                <p id="modalDifficulty"></p>
										<p>운동 리스트 :</p>
						                <p id="modalDescription" style="border:1px solid rgb(177, 196, 255); margin:10px; padding:10px;"></p>
						            </div>
						            <div class="modal-footer">
						                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
										<button type="button" class="btn btn-danger" data-dismiss="modal" onclick="deleteExercise();">삭제</button>
						            </div>
						        </div>
						    </div>
						</div>
						
						<!-- 모달 내용 수정, 삭제 스크립트-->
						<script>
					
						// 삭제 함수 정의
						function deleteExercise() {
						    let exerciseNo = $('#modalExerciseNo').text();
						    let isConfirm = Swal.fire({
						        title: "정말로 삭제하시겠습니까?",
						        icon: "question",
						        showDenyButton: true,
						        confirmButtonText: "삭제",
						        denyButtonText: "취소",
						    }).then((result) => {
						        if (result.isConfirmed) {
						            $.ajax({
						                url: 'deleteExercise.ex',
						                method: 'POST', // POST 메소드 명시
						                data: { exerciseNo: exerciseNo },
						                success: function(response) {
						                    if (response === "success") {
						                        Swal.fire("성공적으로 삭제하였습니다.", "", "success").then(() => {
						                            $('#eventModal').modal('hide'); // 모달 닫기
						                            $('#eventModal').attr('aria-hidden', 'true'); // aria-hidden 속성 변경
						                        });
						                    } else {
						                        Swal.fire("삭제에 실패했습니다.", "DB 오류가 발생했습니다.", "error");
						                    }
						                },
						                error: function() {
						                    Swal.fire("삭제에 실패했습니다.", "서버 오류가 발생했습니다.", "error");
						                },
						            });
						        }
						    });
						}

						</script>
						
						<!-- 회원 선택 시 value값도 바뀌는 ㅅ크립트 -->
						<script>
						$(document).ready(function(){
							$(".selectTrainee").change(function(){
								let selectUser = $(this).find("option:selected");
							
							// 목표와 질병 데이터 가져오기
							let goal = selectUser.data('goal');
							let disease = selectUser.data('disease');
							
					        // selected 업데이트
					        if (goal === '없음') {
					            $('select[name="goal"]').val('none');
					        } else {
					            $('select[name="goal"]').val(goal);
					        }

					        if (disease === '없음') {
					            $('select[name="health_conditions"]').val('none');
					        } else {
					            $('select[name="health_conditions"]').val(disease);
					        }
					        
							});
							
						});
						</script>
						
						<div style="display: flex;">
							<div class="card mb-3 py-2 border-bottom-info"
								style="width: 50%; margin: 50px; margin-right: 25px;">
								<h4
									style="margin-left: 10px; font-weight: 600; padding: 20px; margin: 20px;"
									align="center" id="trainee">운동 계획하기</h4>
								<div class="prescription" align="center">
									<div class="exercisePrescription">
										<span>운동 목적</span> <select class="selectExercise" name="goal">
											<option value="none" >* 필수 항목입니다.</option>
											<option value="체중_감량" >체중 감량</option>
											<option value="근력_증가" >근력 증가</option>
											<option value="수술_후_재활" >수술 후 재활</option>
											<option value="유연성_운동" >유연성 운동</option>
											<option value="균형_증가" >균형 증가</option>
											<option value="심혈관_기능증진" >심혈관 기능증진</option>
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
											<option value="none" >정상</option>
											<option value="혈압조절장애" >혈압조절장애</option>
											<option value="고지혈증" >고지혈증</option>
											<option value="당뇨" >당뇨</option>
											<option value="대사증후군" >대사증후군</option>
											<option value="디스크(목,허리)" >디스크(목,허리)</option>
											<option value="천식" >천식</option>
											<option value="심혈관_질환">심혈관 질환</option>
											<option value="골다공증" >골다공증</option>
											<option value="관절염" >관절염</option>
											<option value="편두통" >편두통</option>
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
								<div style="display:flex; align-items:center; justify-content:center; margin-left:10%;">
									<h4
										style="font-weight: 600; padding: 20px; margin: 20px;"
										align="center">AI가 추천해준 운동계획</h4>
										<div class="btn btn-danger btn-circle" id="saveBtn">
											<i class="fas fa-check"></i>
										</div>
								</div> 
								<div class="prescription aiprep">
									<!-- 로딩 중일 때 보이는 화면 -->
									<div id="loading" style="display:none; align-items:center; justify-content:center; " >
									   <div class="loader">
										  <div>
										    <ul>
										      <li>
										        <svg fill="currentColor" viewBox="0 0 90 120">
										          <path d="M90,0 L90,120 L11,120 C4.92486775,120 0,115.075132 0,109 L0,11 C0,4.92486775 4.92486775,0 11,0 L90,0 Z M71.5,81 L18.5,81 C17.1192881,81 16,82.1192881 16,83.5 C16,84.8254834 17.0315359,85.9100387 18.3356243,85.9946823 L18.5,86 L71.5,86 C72.8807119,86 74,84.8807119 74,83.5 C74,82.1745166 72.9684641,81.0899613 71.6643757,81.0053177 L71.5,81 Z M71.5,57 L18.5,57 C17.1192881,57 16,58.1192881 16,59.5 C16,60.8254834 17.0315359,61.9100387 18.3356243,61.9946823 L18.5,62 L71.5,62 C72.8807119,62 74,60.8807119 74,59.5 C74,58.1192881 72.8807119,57 71.5,57 Z M71.5,33 L18.5,33 C17.1192881,33 16,34.1192881 16,35.5 C16,36.8254834 17.0315359,37.9100387 18.3356243,37.9946823 L18.5,38 L71.5,38 C72.8807119,38 74,36.8807119 74,35.5 C74,34.1192881 72.8807119,33 71.5,33 Z"></path>
										        </svg>
										      </li>
										      <li>
										        <svg fill="currentColor" viewBox="0 0 90 120">
										          <path d="M90,0 L90,120 L11,120 C4.92486775,120 0,115.075132 0,109 L0,11 C0,4.92486775 4.92486775,0 11,0 L90,0 Z M71.5,81 L18.5,81 C17.1192881,81 16,82.1192881 16,83.5 C16,84.8254834 17.0315359,85.9100387 18.3356243,85.9946823 L18.5,86 L71.5,86 C72.8807119,86 74,84.8807119 74,83.5 C74,82.1745166 72.9684641,81.0899613 71.6643757,81.0053177 L71.5,81 Z M71.5,57 L18.5,57 C17.1192881,57 16,58.1192881 16,59.5 C16,60.8254834 17.0315359,61.9100387 18.3356243,61.9946823 L18.5,62 L71.5,62 C72.8807119,62 74,60.8807119 74,59.5 C74,58.1192881 72.8807119,57 71.5,57 Z M71.5,33 L18.5,33 C17.1192881,33 16,34.1192881 16,35.5 C16,36.8254834 17.0315359,37.9100387 18.3356243,37.9946823 L18.5,38 L71.5,38 C72.8807119,38 74,36.8807119 74,35.5 C74,34.1192881 72.8807119,33 71.5,33 Z"></path>
										        </svg>
										      </li>
										      <li>
										        <svg fill="currentColor" viewBox="0 0 90 120">
										          <path d="M90,0 L90,120 L11,120 C4.92486775,120 0,115.075132 0,109 L0,11 C0,4.92486775 4.92486775,0 11,0 L90,0 Z M71.5,81 L18.5,81 C17.1192881,81 16,82.1192881 16,83.5 C16,84.8254834 17.0315359,85.9100387 18.3356243,85.9946823 L18.5,86 L71.5,86 C72.8807119,86 74,84.8807119 74,83.5 C74,82.1745166 72.9684641,81.0899613 71.6643757,81.0053177 L71.5,81 Z M71.5,57 L18.5,57 C17.1192881,57 16,58.1192881 16,59.5 C16,60.8254834 17.0315359,61.9100387 18.3356243,61.9946823 L18.5,62 L71.5,62 C72.8807119,62 74,60.8807119 74,59.5 C74,58.1192881 72.8807119,57 71.5,57 Z M71.5,33 L18.5,33 C17.1192881,33 16,34.1192881 16,35.5 C16,36.8254834 17.0315359,37.9100387 18.3356243,37.9946823 L18.5,38 L71.5,38 C72.8807119,38 74,36.8807119 74,35.5 C74,34.1192881 72.8807119,33 71.5,33 Z"></path>
										        </svg>
										      </li>
										      <li>
										        <svg fill="currentColor" viewBox="0 0 90 120">
										          <path d="M90,0 L90,120 L11,120 C4.92486775,120 0,115.075132 0,109 L0,11 C0,4.92486775 4.92486775,0 11,0 L90,0 Z M71.5,81 L18.5,81 C17.1192881,81 16,82.1192881 16,83.5 C16,84.8254834 17.0315359,85.9100387 18.3356243,85.9946823 L18.5,86 L71.5,86 C72.8807119,86 74,84.8807119 74,83.5 C74,82.1745166 72.9684641,81.0899613 71.6643757,81.0053177 L71.5,81 Z M71.5,57 L18.5,57 C17.1192881,57 16,58.1192881 16,59.5 C16,60.8254834 17.0315359,61.9100387 18.3356243,61.9946823 L18.5,62 L71.5,62 C72.8807119,62 74,60.8807119 74,59.5 C74,58.1192881 72.8807119,57 71.5,57 Z M71.5,33 L18.5,33 C17.1192881,33 16,34.1192881 16,35.5 C16,36.8254834 17.0315359,37.9100387 18.3356243,37.9946823 L18.5,38 L71.5,38 C72.8807119,38 74,36.8807119 74,35.5 C74,34.1192881 72.8807119,33 71.5,33 Z"></path>
										        </svg>
										      </li>
										      <li>
										        <svg fill="currentColor" viewBox="0 0 90 120">
										          <path d="M90,0 L90,120 L11,120 C4.92486775,120 0,115.075132 0,109 L0,11 C0,4.92486775 4.92486775,0 11,0 L90,0 Z M71.5,81 L18.5,81 C17.1192881,81 16,82.1192881 16,83.5 C16,84.8254834 17.0315359,85.9100387 18.3356243,85.9946823 L18.5,86 L71.5,86 C72.8807119,86 74,84.8807119 74,83.5 C74,82.1745166 72.9684641,81.0899613 71.6643757,81.0053177 L71.5,81 Z M71.5,57 L18.5,57 C17.1192881,57 16,58.1192881 16,59.5 C16,60.8254834 17.0315359,61.9100387 18.3356243,61.9946823 L18.5,62 L71.5,62 C72.8807119,62 74,60.8807119 74,59.5 C74,58.1192881 72.8807119,57 71.5,57 Z M71.5,33 L18.5,33 C17.1192881,33 16,34.1192881 16,35.5 C16,36.8254834 17.0315359,37.9100387 18.3356243,37.9946823 L18.5,38 L71.5,38 C72.8807119,38 74,36.8807119 74,35.5 C74,34.1192881 72.8807119,33 71.5,33 Z"></path>
										        </svg>
										      </li>
										      <li>
										        <svg fill="currentColor" viewBox="0 0 90 120">
										          <path d="M90,0 L90,120 L11,120 C4.92486775,120 0,115.075132 0,109 L0,11 C0,4.92486775 4.92486775,0 11,0 L90,0 Z M71.5,81 L18.5,81 C17.1192881,81 16,82.1192881 16,83.5 C16,84.8254834 17.0315359,85.9100387 18.3356243,85.9946823 L18.5,86 L71.5,86 C72.8807119,86 74,84.8807119 74,83.5 C74,82.1745166 72.9684641,81.0899613 71.6643757,81.0053177 L71.5,81 Z M71.5,57 L18.5,57 C17.1192881,57 16,58.1192881 16,59.5 C16,60.8254834 17.0315359,61.9100387 18.3356243,61.9946823 L18.5,62 L71.5,62 C72.8807119,62 74,60.8807119 74,59.5 C74,58.1192881 72.8807119,57 71.5,57 Z M71.5,33 L18.5,33 C17.1192881,33 16,34.1192881 16,35.5 C16,36.8254834 17.0315359,37.9100387 18.3356243,37.9946823 L18.5,38 L71.5,38 C72.8807119,38 74,36.8807119 74,35.5 C74,34.1192881 72.8807119,33 71.5,33 Z"></path>
										        </svg>
										      </li>
										    </ul>
										  </div><span style="font-size:20px; font-family:'DungGeunMo'">AI가 열심히 <br /> 만들고 있어요👽</span></div>
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

					<script>
						document.addEventListener('DOMContentLoaded', function() {
							window.isLevel = '${loginUser.userLevel}'; // let isLevel : 지역변수로 선언되서 외부 js화면으로 변수가 적용되지 않는다.
																	   // 변수를 적용하기 위해선 window객체를 사용해야 한다.
																	   // 캘린더의 '일정추가' 버튼이 트레이너 화면에선 보여야 한다 - 사용자의 level을 외부 자바스크립트로 보냄(트레이너 === 1)
							// console.log("트레이너 화면", isLevel);
						})
					</script>

					<!-- modal 추가 -->
					<div class="modal fade" id="calendarModal" tabindex="-1"
						role="dialog" aria-labelledby="exampleModalLabel"
						aria-hidden="true">
						<div class="modal-dialog" role="document">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="exampleModalLabel">회원 운동 플랜 등록</h5>
									<button type="button" class="close" data-dismiss="modal"
										aria-label="Close">
										<span aria-hidden="true">&times;</span>
									</button>
								</div>
								<div class="modal-body">
									<div class="form-group">
										<label for="taskId" class="col-form-label">일정 제목</label> <input
											type="text" class="form-control" id="calendar_title"
											name="calendar_title" value="(이름입력)님의 n일차 운동 플래너"> <label for="taskId"
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
				</div>

				<script>
                // ai 플랜 출력 스크립트
                $(function(){
                	
                	$("#aiPlan").click(function(){
                		// 로딩 화면 보여주는 메소드
                		$("#loading").css("display","flex");
                		$("#loading").show();
                		
                		let daysPerWeek = $('select[name="days_per_week"]').val();
                		console.log("Days per week:", daysPerWeek); // 추가된 디버깅 코드
                		
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
                			// loading화면 숨기기
                			$("#loading").hide();
                			
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