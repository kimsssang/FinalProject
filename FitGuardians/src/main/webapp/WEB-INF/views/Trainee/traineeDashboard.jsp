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
                                                                <a class="dropdown-item" href="#">운동 플랜 보러가기</a>
                                                                <a class="dropdown-item" href="#">식단 플랜 보러가기</a>
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
                                                        <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Itaque ex omnis totam, ipsum fugiat doloremque impedit sit temporibus quasi fugit maiores quas laboriosam in, necessitatibus tempore quam esse quisquam. Accusantium.</p>
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

                                                                // 오늘 날짜 구하기
                                                                let today = new Date().toISOString().split("T")[0];

                                                                //console.log("today :", today);

                                                                // result의 결과의 날짜가 오늘인 경우
                                                                 let todayWorkout = result.filter(plan =>{
                                                                    //console.log("plan.workoutDate", plan.workoutDate);

                                                                    // YYYY-MM-DD로 변환
                                                                    let workoutDateString = plan.workoutDate.split(" ")[0];

                                                                    // workoutDate를 ISO로 변환
                                                                    let workoutDate = new Date(workoutDateString + 'T00:00:00Z'); //시간대를 utc로 설정
                                                                    let formattedDate = workoutDate.toISOString().split("T")[0]; // YYYY-MM-DD형식으로 변환
                                                                    return formattedDate === today;
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
                                                                    let workoutDate = new Date(plan.workoutDate).toISOString().split("T")[0];
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
                    
                                                <div class="card shadow mb-4" style="width:40%; left:1%;">
                                                    <!-- Card Header - Dropdown -->
                                                    <div
                                                        class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                                        <h6 class="m-0 font-weight-bold text-primary">스케줄</h6>
                                                        <div class="dropdown no-arrow">
                                                            <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink"
                                                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                                <i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
                                                            </a>
                                                            <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in"
                                                                aria-labelledby="dropdownMenuLink">
                                                                <a class="dropdown-item" href="#">스케줄 전체보기</a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!-- Card Body -->
                                                    <div class="card-body" id='calendar'>
                                                    </div>
                    
                                                    <script>
                    
                                                        document.addEventListener('DOMContentLoaded', function() {
                                                          const calendarEl = document.getElementById('calendar')
                                                          const calendar = new FullCalendar.Calendar(calendarEl, {
                                                            initialView: 'dayGridMonth'
                                                          })
                                                          calendar.render()
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