<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Trainee's Dashboard</title>
    <!-- Custom fonts for this template-->
    <link href="resources/templates/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">
	
    <!-- sweetalert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.14.1/dist/sweetalert2.all.min.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.14.1/dist/sweetalert2.min.css" rel="stylesheet">
    
    <!-- FullCalendar cdn -->
    <script src="
    https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js
    "></script>

    <!-- 외부 자바스크립트 파일 : 회원 개인 -->
    <script defer src ="./resources/js/traineeDetailInfo.js"></script>

    <!-- 외부 자바스크립트 파일 : 캘린더-->
    <script defer src ="./resources/js/exerciseCalendar.js"></script>

</head>

<body id="page-top">
	<c:if test="${ not empty alertMsg }">
    		<script>
		   		 Swal.fire({
				      icon: 'success',
				      title: '성공',
				      text: "${alertMsg}",
				    });
    		</script>
    		<c:remove var="alertMsg" scope="session"/>
   	</c:if>
	<!-- Page Wrapper -->
    <div id="wrapper">
     <c:choose>
	    <c:when test="${ not empty loginUser }">
	    	<c:choose>
	    		<c:when test="${ loginUser.userLevel == 2 }">
				     <jsp:include page="../common/sideTrainee.jsp" />
	    		</c:when>
	    		<c:otherwise>
	    			<jsp:include page="../common/sideTrainer.jsp" />
	    		</c:otherwise>
	    	</c:choose>
	    </c:when>	
	    <c:otherwise>
	    	<jsp:include page="../common/sideTrainee.jsp" />
	    </c:otherwise>
    </c:choose>
     <div id="content-wrapper" class="d-flex flex-column">
     <!-- Main Content -->
     	<div id="content">
     		<jsp:include page="../common/topBar.jsp"/>
     		<!-- Begin Page Content -->
                <div class="container-fluid">
				
                                        <!-- Page Heading -->
                                        <div class="d-sm-flex align-items-center justify-content-between mb-4">
                                            <h1 class="h3 mb-0 text-gray-800" style="font-weight:700;">${loginUser.userName}님, 환영합니다!</h1>
                                        </div>
                    
                                        <!-- Content Row -->
                                        <div class="row">
                    
                                            <!-- 이번달 PT횟수 Example -->
                                            <div class="col-xl-3 col-md-6 mb-4">
                                                <div class="card border-left-primary shadow h-100 py-2">
                                                    <div class="card-body">
                                                        <div class="row no-gutters align-items-center">
                                                            <div class="col mr-2">
                                                                <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                                                    이번달 PT횟수</div>
                                                                <div class="h5 mb-0 font-weight-bold text-gray-800">4번 출석</div>
                                                            </div>
                                                            <div class="col-auto">
                                                                <i class="fas fa-calendar fa-2x text-gray-300"></i>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                    
                                            <!-- 이번달 자유운동 횟수 Example -->
                                            <div class="col-xl-3 col-md-6 mb-4">
                                                <div class="card border-left-success shadow h-100 py-2">
                                                    <div class="card-body">
                                                        <div class="row no-gutters align-items-center">
                                                            <div class="col mr-2">
                                                                <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                                                    이번달 자유운동 횟수</div>
                                                                <div class="h5 mb-0 font-weight-bold text-gray-800">10번 출석</div>
                                                            </div>
                                                            <div class="col-auto">
                                                                <i class="fas fa-dollar-sign fa-2x text-gray-300"></i>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                    
                                            <!-- Earnings (Monthly) Card Example -->
                                            <div class="col-xl-3 col-md-6 mb-4">
                                                <div class="card border-left-info shadow h-100 py-2">
                                                    <div class="card-body">
                                                        <div class="row no-gutters align-items-center">
                                                            <div class="col mr-2">
                                                                <div class="text-xs font-weight-bold text-info text-uppercase mb-1">내 운동 목표
                                                                </div>
                                                                <div class="row no-gutters align-items-center">
                                                                    <div class="col-auto">
                                                                        <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">${mi.goal}</div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-auto">
                                                                <i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                    
                                            <!-- Pending Requests Card Example -->
                                            <div class="col-xl-3 col-md-6 mb-4">
                                                <div class="card border-left-warning shadow h-100 py-2">
                                                    <div class="card-body">
                                                        <div class="row no-gutters align-items-center">
                                                            <div class="col mr-2">
                                                                <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                                                    담당 트레이너</div>
                                                                <div class="h5 mb-0 font-weight-bold text-gray-800">${trainer.userName}</div>
                                                            </div>
                                                            <div class="col-auto">
                                                                <i class="fas fa-comments fa-2x text-gray-300"></i>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                    
                                        <!-- Content Row -->
                    
                                        <div class="row">
                    
                                           <!-- 차트조회 -->
                                         <div class="col-xl-12 col-lg-10">
                                            <div class="card shadow mb-4">
                                               
                                                <div
                                                    class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                                    <h6 class="m-0 font-weight-bold text-primary">${loginUser.userName}님의 변화</h6>
                                                </div>
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
                                        </div>

                                        <!-- 차트 호출 스크립트 -->
                                        <script>
                                        let recentBi = "${recentBi}";

                                        //console.log(recentBi);
                                        </script>
                                        <script src="resources/js/traineeDetailInfo.js"></script>
                    
                                    </div> 
                    
                                        <!-- 운동, 식단 플랜 보여주기 -->
                                           <div class="row"> 
                                                <div class="card shadow mb-4" style="width:58%;">
                                                    <!-- Card Header - Dropdown -->
                                                    <div
                                                        class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                                        <h6 class="m-0 font-weight-bold text-primary">오늘의 운동 · 식단 플랜</h6>
                                                        <div class="dropdown no-arrow">
                                                            <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink"
                                                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                                <i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
                                                            </a>
                                                            <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in"
                                                                aria-labelledby="dropdownMenuLink">
                                                                <a class="dropdown-item" href="traineeExercisePlanner.tn">운동 플랜 입력하기</a>
                                                                <a class="dropdown-item" href="traineesnedMealplan.bo">식단 플랜 입력하기</a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!-- Card Body -->
                                                    <div class="card-body">
                                                        <b>오늘의 운동</b>
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
                                                        <b>오늘의 식단</b>
                                                        	<table id="mealtable" class="table table-bordered"  style="border: 1px solid black;  margin-top: 20px; background-color: white;"> 
																<thead > 
																	<tr style="background-color: rgb(251,251,251);"> 
																		<th >번호</th> 
																		<th  >음식명</th>
											                           	<th >칼로리(kcal)</th>
											                           	<th > 당(g)</th>
											                           	<th >탄수화물(g)</th>
											                           	<th >단백질(g)</th>
											                           	<th >지방(g)</th>
																	</tr>
																</thead>
															
																	<tbody>
																	
																	</tbody>
																	
															</table>
                                                    </div>
                                                    

                                                    
                                                    <script>
                                                    
                                                    $(document).ready(function() {
                                                    	let userId = '${loginUser.userId}';

                                                        //console.log("userId:", userId);

                                                        $.ajax({
                                                        	url : "selectTodayWorkout.ex",
                                                        	data : {
                                                        		userId : userId,
                                                        	},
                                                            success : function(result){
                                                                //console.log(result);
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
                                                                   // console.log("운동 날짜 문자열:", workoutDateString);
                            
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
                    
                                                <!-- 트레이너가 설정한 스케줄 화면 -->
                                                <div class="card shadow mb-4" style="width:40%; left:1%;">
                                                    <div
                                                        class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                                        <h6 class="m-0 font-weight-bold text-primary">${loginUser.userName}님의 스케줄</h6>
                                                    </div>
                                                    <div class="card-body" id='calendar'>
                                                    </div>
                                                    
                                                    <script>
                                                        document.addEventListener('DOMContentLoaded', function() {
                                                            window.isLevel = "${loginUser.userLevel}"; // 캘린더의 '일정추가' 버튼이 회원 jsp에선 보이면 안된다 - 사용자의 level을 외부 자바스크립트로 보냄(회원 === 2)
                                                            // console.log("회원 화면", isLevel);
                                                        });
                                                    </script>

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
                                                        let memId = '${loginUser.userId}';

                                                        document.addEventListener('DOMContentLoaded', function(){
                                                            $.ajax({
                                                                url:"selectWorkout.ex",
                                                                method:"post",
                                                                data:{userId:memId},
                                                                success:function(response){
                                                                    showWorkouts(response);
                                                            },
                                                                error:function(){},
                                                            })
                                                        })
                                                    </script>

                                                      <script >
                                                      // 그날 보낸 식단 확인용 스크립트
                                                      // 오늘날짜 확인
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
																 url: 'traineesendmealmainplanlist.bo',
														            data: { day: day, getUserId : $('.trainerId').text() },
														            success: function(data) {
														            	   let value = "";
														            	 if (data == ""){
														            		 value = "<h2>${loginUser.userName} 님이 " + 오늘 + " 보낸 식단이 없습니다</h2>";
														            		 $('#mealtable').html(value);
														            	 }
														            	 else{
														            		 
													                    for (let i in data) {
													                        let num = parseInt(i) + 1;
													                        value += "<tr>" +
													                                 "<td>" + num + "</td>" + 
													                                 "<td>" + data[i].foodName + "</td>" + 
													                                 "<td>" + data[i].kcal + "</td>" + 
													                                 "<td>" + data[i].sugar + "</td>" + 
													                                 "<td>" + data[i].carbs + "</td>" + 
													                                 "<td>" + data[i].protein + "</td>" + 
													                                 "<td>" + data[i].fat + "</td>" + 
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

                    
                                                </div>
                                           </div>
                    
                </div>
     	</div>
     </div>
    </div>
</body>

</html>