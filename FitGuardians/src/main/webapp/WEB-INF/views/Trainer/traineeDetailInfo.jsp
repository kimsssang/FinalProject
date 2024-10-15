<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보</title>
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
                <h1 class="h3 mb-4 text-gray-800" style="font-weight:600;"> 뫅두팔님 관리페이지</h1>

                <div class="row">

                    <div class="col-lg-6">
                       <!-- 회원정보 -->
                       <div class="card mb-3 py-4 border-left-primary">
                           <div class="card-body"  style="display:flex;">
                               <div style="margin-left:30px;">
                                   <div style="border-radius:50%; border:1px solid royalblue; width:150px; height:150px; overflow:hidden;">
                                       <img src="${ pageContext.request.contextPath }/resources/uploadFiles/manprofile.PNG" style="max-width:100%; max-height:100%; object-fit:cover;"/>
                                   </div>
                               </div>
                               <div style="margin-left:30px;">
                                   <div class = "traineeName">뫅두팔</div>
                                   <br/>
                                   <span>나이 : 30살</span> &nbsp;&nbsp;&nbsp;&nbsp; <span>성별: 남성</span> <br/>
                                   <span>키 : 175cm</span> &nbsp;&nbsp;&nbsp;&nbsp; <span>몸무게 : 100kg</span> <br/>
                                   <span>골격근량 : 2%</span> &nbsp;&nbsp;&nbsp;&nbsp; <span>BMI(체질량지수) : 88%</span> &nbsp;&nbsp;&nbsp;&nbsp; <span>체지방량 :85%</span> <br/>
                                   <span>운동 목표 : 개돼지에서 벗어나고 차은우로 다시태어나기</span> <br/>
                               </div>
                           </div>
                       </div>

                    <!-- 운동, 식단 플래너 -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">뫅두팔님의 운동, 식단 플래너</h6>
                        </div>
                        <div class="card-body">
                            <div style="height:165px;">
                                <span class="planner">운동 플래너</span>
                                <ul>
                                    <li>
                                        상체 : 깔쌈하게 운동하기(5회 5세트)
                                    </li>
                                    <li>
                                        코어 : 깔쌈하게 운동하기(5회 5세트)
                                    </li>
                                    <li>
                                        하체 : 깔쌈하게 운동하기(5회 5세트)
                                    </li>
                                </ul>
                            </div>
                            <br/>
                            <div style="height:165px;">
                                <span class="planner">식단 플래너</span>
                                <ul>
                                    <li>
                                        아침 : 깔쌈하게 운동하기(5회 5세트)
                                    </li>
                                    <li>
                                        점심 : 깔쌈하게 운동하기(5회 5세트)
                                    </li>
                                    <li>
                                        간식 : 깔쌈하게 운동하기(5회 5세트)
                                    </li>
                                    <li>
                                        저녁 : 깔쌈하게 운동하기(5회 5세트)
                                    </li>
                                </ul>
                            </div>
                            
                        </div>
                    </div>

                   </div>

                   <!-- 회원 PT스케줄 -->
                   <div class="col-lg-6" style="display:inline;">
                       <div class="card shadow mb-4">
                           <div class="card-header py-3">
                               <h6 class="m-0 font-weight-bold text-primary">뫅두팔님의 스케줄</h6>
                           </div>
                           <div class="card-body" id='calendar'>
                              
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
              
                  </script>

               </div>
                   
               <!-- 회원 신체 정보 -->
               <div class="card shadow mb-8">
                   <!-- Card Header - Dropdown -->
                   <div
                       class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                       <h6 class="m-0 font-weight-bold text-primary">뫅두팔님의 신체정보 관리</h6>
                       <div class="dropdown no-arrow">
                           <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink"
                               data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                               <i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
                           </a>
                           <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in"
                               aria-labelledby="dropdownMenuLink">
                               <a class="dropdown-item" href="#">정보수정</a>
                           </div>
                       </div>
                   </div>
                   <!-- Card Body -->
                   <div class="card-body">
                       
                       <div class="info-title">골격근량</div>
                       <div style="height:165px;"></div>

                       <div class="info-title">BMI(체질량지수) </div>
                       <div style="height:165px;"></div>

                       <div class="info-title">체지방량</div>
                       <div style="height:165px;"></div>

                   </div>
               </div>

               </div>
             
             </div>
         </div>
        </div>
    </body>


</html>