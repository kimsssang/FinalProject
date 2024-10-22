<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 조회</title>
    <!-- Custom fonts for this template-->
    <link href="resources/templates/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
    href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
    rel="stylesheet">

    <!-- FullCalendar cdn -->
    <script src="
    https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js
    "></script>

    <!-- 외부 css -->
    <link href="resources/css/traineeDetailInfo.css" rel="stylesheet" type="text/css">

    <!-- 외부 자바스크립트 파일 : 캘린더 -->
    <script defer src ="./resources/js/exerciseCalendar.js"></script>

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
                 <jsp:include page="../common/topBar.jsp"/>
                 <!-- Begin Page Content -->
                    <div class="container-fluid">
                        
                <!-- Page Heading -->
                <h1 class="h3 mb-4 text-gray-800" style="font-weight:600;"> ${m.userName}님 관리페이지</h1>

                <div class="row">

                    <div class="col-lg-6">
                       <!-- 회원정보 -->
                       <div class="card mb-3 py-4 border-left-primary">
                           <div class="card-body"  style="display:flex;">
                               <div style="margin-left:30px;">
                                   <div style="border-radius:50%; border:1px solid royalblue; width:150px; height:150px; overflow:hidden;">
                                       <img src="${m.profilePic}" style="max-width:100%; max-height:100%; object-fit:cover;"/>
                                   </div>
                               </div>
                               <div style="margin-left:30px;">
                                   <div class = "traineeName">${m.userName}</div>
                                   <br/>
                                   <span>나이 : ${m.age}살</span> &nbsp;&nbsp;&nbsp;&nbsp; <span>성별: ${m.gender}</span> <br/>
                                   <span>키 : ${mi.height} cm</span> &nbsp;&nbsp;&nbsp;&nbsp; <span>몸무게 : ${mi.weight}kg</span> <br/>
                                   <span>골격근량 : ${lastSmm}&#37;</span> &nbsp;&nbsp;&nbsp;&nbsp; <span>BMI(체질량지수) : ${lastBmi}&#37;</span> &nbsp;&nbsp;&nbsp;&nbsp; <span>체지방량 :${lastFat} &#37;</span> <br/>
                                   <span>운동 목표 : ${mi.goal} </span> <br/>
                               </div>
                           </div>
                       </div>

                    <!-- 운동, 식단 플래너 -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">${m.userName}님의 운동, 식단 플래너</h6>
                        </div>
                        <div class="card-body">
                            <div style="height:165px;">
                                <span class="planner">운동 플래너</span>
                               
                                <div class="traineePlanner">
                                    <table class="table table-bordered exerciseTable" id="exercisePlanTable">
                                        <thead class="thead-light">
                                            <tr>
                                                <th>플랜 번호</th>
                                                <th>플랜 제목</th>
                                                <th>날짜</th>
                                                <th>난이도</th>
                                                <th>설명</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <!-- 여기에 값 들어올 예정 -->
                                        </tbody>
                                    </table>
                                </div>
                                <script>
                                    window.isLevel = "${loginUser.userLevel}"; // 전역 변수로 정의 
                                                                               // $(document).ready 밖에 작성해야 한다!

                                    $(document).ready(function() {
                                        let userId = '${m.userId}';
                                        console.log(window.isLevel);
                                        $.ajax({
                                            url : "selectTodayWorkoutforTrainer.ex",
                                            data : {
                                                userId : userId,
                                            },
                                            success : function(result){
                                                console.log(result);
                                                $('#exercisePlanTable tbody').empty();
            
                                                // let now = new Date();
                                                // console.log("Local Date:", now);
                                                // console.log("ISO String:", now.toISOString());

                                                // // 오늘 날짜 구하기
                                                // let today = new Date().toISOString().split("T")[0];
                                                // console.log("today(formatted) :", today);

                                                // -> 이렇게 했더니, toISOString()을 사용하면 UTC 시간을 반환하는데, 이는 한국 지역시와 차이가 있어서 오류가 발생할 수 있다(새벽 1시 기준)
                                                // 따라서 지역시간(toLocaleDateString)을 사용해야 한다.

                                                // 한국 표준시 형식
                                                let today = new Date();
                                                let todayString = today.getFullYear() + '-' + 
                                                                  String(today.getMonth() + 1).padStart(2, '0') + '-' + 
                                                                  String(today.getDate()).padStart(2, '0');
                                                //console.log('오늘 날짜 :', todayString);

                                                // result의 결과의 날짜가 오늘인 경우
                                                 let todayWorkout = result.filter(plan =>{
                                                    //console.log("plan.workoutDate", plan.workoutDate);
            
                                                    // YYYY-MM-DD로 변환
                                                    let workoutDateString = plan.workoutDate.split(" ")[0];
                                                    //console.log("운동 날짜 문자열:", workoutDateString);
            
                                                    return workoutDateString === todayString;
                                                 }) 
                                                 //console.log("todayWorkout :", todayWorkout);
            
                                                if(todayWorkout.length>0){ // 배열값이 하나라도 있을때
                                                    
                                                    // html 작성하기
                                                    // value를 forEach문 밖으로 꺼내기
                                                    let value = '';
            
                                                    // 오늘 날짜의 배열의 값을 하나하나 뽑기
                                                    todayWorkout.forEach((plan)=>{
                                                    let exerciseNo = plan.exerciseNo;
                                                    let workoutTitle = plan.workoutTitle;
                                                    let workoutDate = new Date(plan.workoutDate).toLocaleDateString('ko-KR');
                                                    let workoutCategory = plan.workoutCategory;
                                                    let difficulty = plan.difficulty;
                                                    let description = plan.description;
            
                                                    value += "<tr>"
                                                           + "<td>" + exerciseNo + "</td>"
                                                           + "<td>" + workoutTitle + "</td>"
                                                           + "<td>" + workoutDate + "</td>"
                                                           + "<td>" + difficulty + "</td>"
                                                           + "<td>" + description + "</td>"
                                                           + "</tr>";
                                                        });
            
                                                        // value값 table에 동적으로 생성하기 
                                                        $("#exercisePlanTable tbody").html(value);
                                                }else{
                                                    $('#exercisePlanTable tbody').html('<tr><td colspan="5">운동 계획이 없습니다.</td></tr>')
                                                }
            
                                            },
                                            error : function(){},
                                        })
                                        
                                    })
                                    </script>
            
                            </div>
                            <br/>
                            <div style="height:165px;">
                                <span class="planner">식단 플래너</span>
                                	<table id="mealtable" class=""  style="border: 0px solid black;  margin-top: 10px; background-color: white; width: 90%;"> 
										
									
											<tbody>
											<tr><td>${m.userName}님이 오늘 보낸 식단이 없습니다<td></tr>
											</tbody>
											
									</table>
                            </div>
                            
                        </div>
                    </div>

                   </div>
                   <script >
                   
               
				    let today = new Date();
                 //날짜 형식 변경 함수
                 			
				    function formatDate(date) {
				        // yyyy-MM-dd 형식으로 변환
				        let fomartday = date.getFullYear() + "-" + ((date.getMonth() + 1).toString().padStart(2, '0')) + "-" + (date.getDate().toString().padStart(2, '0'));
				        return fomartday;
				   			 }
                 //지금날짜 변경된거(day)
                  let day = formatDate(today);
						//ajax로 파일 가져오기
						$.ajax({
							 url: 'traineesendmealplanlist2.bo',
					            data: { day: day, sendUserId :'${m.userId}'},
					            success: function(data) {
					            
					            	   let value = "";
					            	 if (data == ""){
					            		 value = "<tr><td>${m.userName}님이 " + '오늘' + " 보낸 식단이 없습니다<td></tr>";
					            		 $('#mealtable tbody').html(value);
					            	 }
					            	 else{
					            		
				                    for (let i in data) {
				                        let num = parseInt(i) + 1;
				                        value += "<tr>" +
				                                 
				                                 "<td style='width:10px'>" + data[i].foodName + "</td>" + 
				                                 "<td style='width:40px'>" + data[i].kcal +'kcal' + "</td>" + 
				                                 "</tr>";
				                    }
				                    
				                    $('#mealtable tbody').html(value);
					            	 }
					            },
					            error : function(){
					            	console.log("식단 ajax오류")
					            }
						})


</script>

                   <!-- 회원 PT스케줄 -->
                   <div class="col-lg-6" style="display:inline;">
                       <div class="card shadow mb-4">
                           <div class="card-header py-3">
                               <h6 class="m-0 font-weight-bold text-primary">${m.userName}님이 기록한 운동 일정</h6>
                           </div>
                           <div class="card-body detail-view" id='calendar'>
                              
                           </div>
                       </div>
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
                                    <p id="modalDescription"></p>
                                </div>
                            </div>
                        </div>
                    </div>

                   <script>

                    document.addEventListener('DOMContentLoaded', function() {
                      const calendarEl = document.getElementById('calendar')
                      const calendar = new FullCalendar.Calendar(calendarEl, {
                        initialView: 'dayGridWeek'
                      })
                      calendar.render()
                    })
              

                    $(document).ready(function() {
                        let userId = '${m.userId}';
                        if (userId) {
                            $.ajax({
                                url: "selectTraineeWorkoutList.ex",
                                method: "post",
                                data: { userId: userId },
                                success: function(response) {
                                    showWorkouts(response); 
                                },
                                error: function() {
                                    console.log("조회 실패");
                                },
                            });
                        }
                    });
                  </script>

               </div>
                   
               <!-- 회원 신체 정보 -->
               <div class="card shadow mb-8">
                   <!-- Card Header - Dropdown -->
                   <div
                       class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                       <h6 class="m-0 font-weight-bold text-primary">${m.userName}님의 신체정보 관리</h6>
                       <div style="display:flex;">
	                  	  <button style="margin:5px;" class="btn btn-info btn-circle" data-toggle="modal" data-target="#updateModal"><i class="fas fa-info-circle"></i></button>
	                      <button style="margin:5px;" class="btn btn-warning btn-circle" data-toggle="modal" data-target="#deleteModal"><i class="fas fa-exclamation-triangle"></i></button>
                      </div>
                    </div>
                   <!-- 차트 삽입 예정-->
                   <div class="card-body">
                       
                       <div class="info-title">골격근량</div>
                       <div style="height:250px;" class="chart-area">
                            <canvas id="smmChart"></canvas>
                       </div>
                       <br />
                       <div class="info-title">BMI(체질량지수) </div>
                       <div style="height:250px;"  class="chart-area">
                            <canvas id="bmiChart"></canvas>
                       </div>
                       <br />
                       <div class="info-title">체지방량</div>
                       <div style="height:250px;"  class="chart-area">
                            <canvas id="fatChart"></canvas> 
                       </div>

                   </div>
               </div>
               
               <!-- 키, 몸무게 입력 모달창 -->
               <div class="modal fade" id="updateModal" tabindex="-1" aria-labelledby="updateModalLabel" aria-hidden="true" >
				    <div class="modal-dialog">
				        <div class="modal-content">
				            <div class="modal-header">
				                <h5 class="modal-title" id="updateModalLabel">측정하기</h5>
				                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				                    <span aria-hidden="true">&times;</span>
				                </button>
				            </div>
				            <div class="modal-body">
				                <form id="updateForm">
				                    <div class="form-group">
				                        <label for="height">키 (cm)</label>
				                        <input type="number" class="form-control" id="height" placeholder="키를 입력하세요">
				                    </div>
				                    <div class="form-group">
				                        <label for="weight">몸무게 (kg)</label>
				                        <input type="number" class="form-control" id="weight" placeholder="몸무게를 입력하세요">
				                    </div>
				                  <div class="bodyResult">
				                  
				                  </div>
				                </form>
				            </div>
				            <div class="modal-footer">
				                <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
				                <button type="button" class="btn btn-primary" id="saveButton">측정하기</button>
				            </div>
				        </div>
				    </div>
				</div>

                <!-- 신체정보 조회, 삭제 모달창 -->
               <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="updateModalLabel" aria-hidden="true" >
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="deleteModalLabel">기록 조회</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <form id="delteForm">
                                <div class="bodyResult">
                                  <c:forEach var="b" items="${bi}">
                                        <table class="table">
                                            <thead>
                                                <tr>
                                                    <th>측정일</th>
                                                    <th>골격근량</th>
                                                    <th style="width:100px;">체질량<br />지수(BMI)</th>
                                                    <th>체지방량</th>
                                                    <th> </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td><fmt:formatDate value="${b.measureDate}" pattern="yy/MM/dd" /></td>
                                                    <td><fmt:formatNumber value="${b.smm}" maxFractionDigits="1" /></td>
                                                    <td><fmt:formatNumber value="${b.bmi}" maxFractionDigits="1" /></td>
                                                    <td><fmt:formatNumber value="${b.fat}" maxFractionDigits="1" /></td>
                                                    <td>
                                                        <div class="btn btn-danger btn-circle btn-sm deleteButton" data-body-info-no="${b.bodyInfoNo}">
                                                            <i class="fas fa-trash"></i>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
									    <br />
									</c:forEach>
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                        </div>
                    </div>
                </div>
            </div>
				
				<!-- 모달창 스크립트 : 외부로 빼냄 -->
				<script>
					// 회원 정보 데이터 조회하는 메소드
					let traineeData = {
						id : '${m.userId}',
						name: '${m.userName}', // el구문은 자바스크립트 내에서 사용할 수 없지만, 변수에 담아서 사용할 수 있다.
				        gender: '${m.gender}', // 외부 자바스크립트에서 el 구문을 사용할 수 없지만, 객체에 담아서 외부 자바스크립트로 데이터를 전송할 수 있다.
				        age: ${m.age}, // 숫자에는 ''태그를 쓰지 않아도 되고, 이름이나 성별같은 문자열에는 ''를 씌워야 한다.
					};
					
                    let recentBi = "${recentBi}"; // 서버에서 넘어온 배열을 문자열로 반환
	
				</script>
				<script src="resources/js/traineeDetailInfo.js"></script>

               </div>
             
             </div>
         </div>
        </div>
    </body>


</html>