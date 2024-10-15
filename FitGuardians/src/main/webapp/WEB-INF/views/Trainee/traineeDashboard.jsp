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
                                            <h1 class="h3 mb-0 text-gray-800">회원관리</h1>
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
                                                                        <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">100kg 감량</div>
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
                                                                <div class="h5 mb-0 font-weight-bold text-gray-800">김계란</div>
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
                    
                                           <!-- Area Chart -->
                                           <div class="col-xl-8 col-lg-7">
                                            <div class="card shadow mb-4">
                                                <!-- Card Header - Dropdown -->
                                                <div
                                                    class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                                    <h6 class="m-0 font-weight-bold text-primary">뫅두팔님의 골격근량 변화량</h6>
                                                    <div class="dropdown no-arrow">
                                                        <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink"
                                                            data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                            <i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
                                                        </a>
                                                        <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in"
                                                            aria-labelledby="dropdownMenuLink">
                                                            <div class="dropdown-header">Dropdown Header:</div>
                                                            <a class="dropdown-item" href="#">Action</a>
                                                            <a class="dropdown-item" href="#">Another action</a>
                                                            <div class="dropdown-divider"></div>
                                                            <a class="dropdown-item" href="#">Something else here</a>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!-- Card Body -->
                                                <div class="card-body">
                                                    <div class="chart-area">
                                                        <canvas id="myAreaChart"></canvas>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                    
                                        <!-- Pie Chart -->
                                        <div class="col-xl-4 col-lg-5">
                                            <div class="card shadow mb-4">
                                                <!-- Card Header - Dropdown -->
                                                <div
                                                    class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                                    <h6 class="m-0 font-weight-bold text-primary">뫅두팔님의 오늘 운동량</h6>
                                                    <div class="dropdown no-arrow">
                                                        <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink"
                                                            data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                            <i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
                                                        </a>
                                                        <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in"
                                                            aria-labelledby="dropdownMenuLink">
                                                            <a class="dropdown-item" href="#">운동량 입력하러 가기</a>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!-- Card Body -->
                                                <div class="card-body">
                                                    <div class="chart-pie pt-4 pb-2">
                                                        <canvas id="myPieChart"></canvas>
                                                    </div>
                                                    <div class="mt-4 text-center small">
                                                        <span class="mr-2">
                                                            <i class="fas fa-circle text-primary"></i> 상체
                                                        </span>
                                                        <span class="mr-2">
                                                            <i class="fas fa-circle text-success"></i> 복부 및 코어
                                                        </span>
                                                        <span class="mr-2">
                                                            <i class="fas fa-circle text-info"></i> 하체
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div> 
                    
                                        <!-- Content Row -->
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
                                                        <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Itaque ex omnis totam, ipsum fugiat doloremque impedit sit temporibus quasi fugit maiores quas laboriosam in, necessitatibus tempore quam esse quisquam. Accusantium.</p>
                                                        <b>오늘의 식단</b>
                                                        <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Itaque ex omnis totam, ipsum fugiat doloremque impedit sit temporibus quasi fugit maiores quas laboriosam in, necessitatibus tempore quam esse quisquam. Accusantium.</p>
                                                    </div>
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