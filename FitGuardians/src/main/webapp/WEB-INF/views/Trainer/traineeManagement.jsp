<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Trainer's Dashboard</title>
<!-- Custom fonts for this template-->
    <link href="resources/templates/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    
    <!-- FullCalendar cdn -->
    <script src="
    https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js
    "></script>

    <!-- 해당 파일 외부 css -->
    <link href="resources/css/traineeManagement.css" rel="stylesheet" type="text/css">

</head>

<body>

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
                        <h1 class="h3 mb-4 text-gray-800" style="font-weight:600;">회원 관리</h1>		

                         <!-- 회원 관리 카드 row -> 회원 한명씩 추가될 때 마다 col 카드 추가 -->

                    <div class="row">

                        <div class="col-lg-6">
                            <div class="card mb-3 py-4 border-left-primary">
                                <div class="card-body"  style="display:flex;">
                                    <div style="margin-left:30px;">
                                        <div style="border-radius:50%; border:1px solid royalblue; width:150px; height:150px; overflow:hidden;">
                                            <img src="${ pageContext.request.contextPath }/resources/uploadFiles/manprofile.PNG" style="max-width:100%; max-height:100%; object-fit:cover;"/>
                                            
                                        </div>
                                    </div>
                                    <div style="margin-left:30px;">
                                        <a class = "traineeName" href="traineeDetail.me" style="cursor:pointer; text-decoration:none;">뫅두팔</a>
                                        <br/>
                                        <span>나이 : 30살</span> &nbsp;&nbsp;&nbsp;&nbsp; <span>성별: 남성</span> <br/>
                                        <span>키 : 175cm</span> &nbsp;&nbsp;&nbsp;&nbsp; <span>몸무게 : 100kg</span> <br/>
                                        <span>골격근량 : 2%</span> &nbsp;&nbsp;&nbsp;&nbsp; <span>BMI(체질량지수) : 88%</span> &nbsp;&nbsp;&nbsp;&nbsp; <span>체지방량 :85%</span> <br/>
                                        <span>운동 목표 : 개돼지에서 벗어나고 차은우로 다시태어나기</span> <br/>
                                    </div>
                                  </div>
                                </div>
                            </div>

                            <div class="col-lg-6">
                                <div class="card mb-3 py-4 border-left-primary">
                                    <div class="card-body"  style="display:flex;">
                                        <div style="margin-left:30px;">
                                            <div style="border-radius:50%; border:1px solid royalblue; width:150px; height:150px; overflow:hidden;">
                                            	<img src="${ pageContext.request.contextPath }/resources/uploadFiles/manprofile.PNG" style="max-width:100%; max-height:100%; object-fit:cover;"/>
                                            </div>
                                        </div>
                                        <div style="margin-left:30px;">
                                            <a class = "traineeName" href="traineeDetail.me" style="cursor:pointer; text-decoration:none;">강철혁</a>
                                            <br/>
                                            <span>나이 : 35살</span> &nbsp;&nbsp;&nbsp;&nbsp; <span>성별: 남성</span> <br/>
                                            <span>키 : 200cm</span> &nbsp;&nbsp;&nbsp;&nbsp; <span>몸무게 : 150kg</span> <br/>
                                            <span>골격근량 : 98%</span> &nbsp;&nbsp;&nbsp;&nbsp; <span>BMI(체질량지수) : 5%</span> &nbsp;&nbsp;&nbsp;&nbsp; <span>체지방량 : 2%</span> <br/>
                                            <span>운동 목표 : 더 개쩌는 근돼가 되기</span> <br/>
                                        </div>
                                      </div>
                                    </div>
                                </div>

<!--                                 
                                <div class="col-lg-6">
                                    <div class="card mb-3 py-4 border-left-primary">
                                        <div class="card-body"  style="display:flex;">
                                            <div style="margin-left:30px;">
                                                <div style="border-radius:50%; border:1px solid royalblue; width:150px; height:150px;"></div>
                                            </div>
                                            <div class="traineeName" style="margin-left:30px;">
                                                뫅두팔 <br/><br/>
                                                <span>나이 : 30살</span> &nbsp;&nbsp;&nbsp;&nbsp; <span>성별: 남성</span> <br/>
                                                <span>키 : 175cm</span> &nbsp;&nbsp;&nbsp;&nbsp; <span>몸무게 : 100kg</span> <br/>
                                                <span>골격근량 : 2%</span> &nbsp;&nbsp;&nbsp;&nbsp; <span>BMI(체질량지수) : 88%</span> &nbsp;&nbsp;&nbsp;&nbsp; <span>체지방량 :85%</span> <br/>
                                                <span>운동 목표 : 개돼지에서 벗어나고 차은우로 다시태어나기</span> <br/>
                                            </div>
                                          </div>
                                        </div>
                                    </div> -->
                                
                    </div>

                        <!-- 회원 관리 카드 끝 -->


                    </div>
             </div>
         </div>
        </div>
    </body>

</body>
</html>