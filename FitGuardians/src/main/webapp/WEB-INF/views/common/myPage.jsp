<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Page</title>
<!-- Custom fonts for this template-->
<link href="resources/templates/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">
<link rel="stylesheet" href="resources/css/sumoselect.css">

<script defer src="resources/templates/vendor/jquery/jquery.min.js"></script>
<script defer src="resources/js/jquery.sumoselect.js"></script>
</head>

<body id="page-top">
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
				<jsp:include page="../common/topBar.jsp" />
				<!-- Begin Page Content -->
				<div class="container-fluid">
					<!-- Page Heading -->
					<h1 class="h3 mb-4 text-gray-800">my Page</h1>
					<!-- 트레이너 간략통계 -->
					<c:choose>
						<c:when test="${ loginUser.userLevel == '1'}">
							<div class="row">
								<!-- Earnings (Monthly) Card Example -->
								<div class="col-xl-3 col-md-6 mb-4">
									<div class="card border-left-primary shadow h-100 py-2">
										<div class="card-body">
											<div class="row no-gutters align-items-center">
												<div class="col mr-2">
													<div
														class="text-xs font-weight-bold text-primary text-uppercase mb-1">
														회원수 (개인)</div>
													<div class="h5 mb-0 font-weight-bold text-gray-800">40명</div>
												</div>
												<div class="col-auto">
													<i class="fas fa-user fa-2x text-gray-300"></i>
												</div>
											</div>
										</div>
									</div>
								</div>
		
								<!-- Earnings (Annual) Card Example -->
								<div class="col-xl-3 col-md-6 mb-4">
									<div class="card border-left-success shadow h-100 py-2">
										<div class="card-body">
											<div class="row no-gutters align-items-center">
												<div class="col mr-2">
													<div
														class="text-xs font-weight-bold text-success text-uppercase mb-1">
														회원수 (전체)</div>
													<div class="h5 mb-0 font-weight-bold text-gray-800">215</div>
												</div>
												<div class="col-auto">
													<i class="fas fa-users fa-2x text-gray-300"></i>
												</div>
											</div>
										</div>
									</div>
								</div>
		
								<!-- Tasks Card Example -->
								<div class="col-xl-3 col-md-6 mb-4">
									<div class="card border-left-info shadow h-100 py-2">
										<div class="card-body">
											<div class="row no-gutters align-items-center">
												<div class="col mr-2">
													<div
														class="text-xs font-weight-bold text-info text-uppercase mb-1">오늘
														수업</div>
													<div class="row no-gutters align-items-center">
														<div class="col-auto">
															<div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">50%</div>
														</div>
														<div class="col">
															<div class="progress progress-sm mr-2">
																<div class="progress-bar bg-info" role="progressbar"
																	style="width: 50%" aria-valuenow="50" aria-valuemin="0"
																	aria-valuemax="100"></div>
															</div>
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
													<div
														class="text-xs font-weight-bold text-warning text-uppercase mb-1">
														회원 문의</div>
													<div class="h5 mb-0 font-weight-bold text-gray-800">18</div>
												</div>
												<div class="col-auto">
													<i class="fas fa-comments fa-2x text-gray-300"></i>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</c:when>
						<c:otherwise>
							<!-- 회원 일때 -->
							<div class="row">
								
								<div class="col-xl-3 col-md-6 mb-4">
									<div class="card border-left-primary shadow h-100 py-2">
										<div class="card-body">
											<div class="row no-gutters align-items-center">
												<div class="col mr-2">
													<div
														class="text-xs font-weight-bold text-primary text-uppercase mb-1">
														등록일</div>
													<div class="h5 mb-0 font-weight-bold text-gray-800">${ loginUser.enrollDate}</div>
												</div>
												<div class="col-auto">
													<i class="fas fa-calendar fa-2x text-gray-300"></i>
												</div>
											</div>
										</div>
									</div>
								</div>
		
								<!-- Earnings (Annual) Card Example -->
								<div class="col-xl-3 col-md-6 mb-4">
									<div class="card border-left-success shadow h-100 py-2">
										<div class="card-body">
											<div class="row no-gutters align-items-center">
												<div class="col mr-2">
													<div
														class="text-xs font-weight-bold text-success text-uppercase mb-1">
														D-Day</div>
																
													<div class="h5 mb-0 font-weight-bold text-gray-800">+${ loginUser.enrollDate }</div>
												</div>
												<div class="col-auto">
													<i class="fas fa-plus fa-2x text-gray-300"></i>
												</div>
											</div>
										</div>
									</div>
								</div>
		
								<!-- Tasks Card Example -->
								<div class="col-xl-3 col-md-6 mb-4">
									<div class="card border-left-info shadow h-100 py-2">
										<div class="card-body">
											<div class="row no-gutters align-items-center">
												<div class="col mr-2">
													<div
														class="text-xs font-weight-bold text-info text-uppercase mb-1">이번달
														수업 참여</div>
													<div class="row no-gutters align-items-center">
														<div class="col-auto">
															<div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">50%</div>
														</div>
														<div class="col">
															<div class="progress progress-sm mr-2">
																<div class="progress-bar bg-info" role="progressbar"
																	style="width: 50%" aria-valuenow="50" aria-valuemin="0"
																	aria-valuemax="100"></div>
															</div>
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
													<div
														class="text-xs font-weight-bold text-warning text-uppercase mb-1">
														받은 문자</div>
													<div class="h5 mb-0 font-weight-bold text-gray-800">18</div>
												</div>
												<div class="col-auto">
													<i class="fas fa-comments fa-2x text-gray-300"></i>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</c:otherwise>
					</c:choose>
					<!-- 개인정보 변경 -->
					<h1 class="h3 mb-4 text-gray-800">개인정보 변경</h1>
					<div class="row">
						<div class="col-lg-6">
							<!-- Dropdown Card Example -->
							<div class="card shadow mb-4">
								<!-- Card Header - Dropdown -->
								<div
									class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
									<h6 class="m-0 font-weight-bold text-primary">비밀번호 변경</h6>
									
								</div>
								<!-- Card Body -->
								<div class="card-body" id="change-pwd">
									<div class='input-group'>
										<label class="col-form-label mr-4">현재 비밀번호</label>
											<input type="password" class="form-control">
									</div>
									<div class="input-group mt-3">
										<label class="col-form-label mr-2">변경할 비밀번호</label>
										<input type="password" class="form-control mr-2">
										<label class="col-form-label mr-2">비밀번호확인</label>
										<input type="password" class="form-control">
									</div>
									<button class="btn btn-primary mt-3">비밀번호 변경</button>
								</div>
							</div>

							<c:if test="${ loginUser.userLevel == '2' }">
								<div class="card shadow mb-4">
									<div
										class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
										<h6 class="m-0 font-weight-bold text-primary">개인 인적사항 변경</h6>
										<div class="dropdown no-arrow">
											<a class="dropdown-toggle" href="#" role="button"
												id="dropdownMenuLink" data-toggle="dropdown"
												aria-haspopup="true" aria-expanded="false"> <i
												class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
											</a>
											<div
												class="dropdown-menu dropdown-menu-right shadow animated--fade-in"
												aria-labelledby="dropdownMenuLink">
												<div class="dropdown-header">Dropdown Header:</div>
												<a class="dropdown-item" href="#">Action</a> <a
													class="dropdown-item" href="#">Another action</a>
												<div class="dropdown-divider"></div>
												<a class="dropdown-item" href="#">Something else here</a>
											</div>
										</div>
									</div>
									<div class="card-body" id="disease-card">
									<form action="">
										<div class="input-group mb-3">
											<input type="number" id="height" name="height" class="form-control" placeholder="키 (cm)" value="${ memberInfo.height }" required>
			            					<input type="number" id="weight" name="weight" class="form-control" placeholder="몸무게 (kg)" value="${ memberInfo.weight }" required>
										</div>
										<select id="disease" name="disease" class="mb-3 sumoselect_multiple" multiple="multiple">
											<option value="없음">없음</option>
											<option value="혈압조절장애" <c:if test="${memberInfo.disease.contains('혈압조절장애(고혈압, 저혈압)')}">selected</c:if>>혈압조절장애(고혈압, 저혈압)</option>
											<option value="고지혈증" <c:if test="${memberInfo.disease.contains('고지혈증')}">selected</c:if>>고지혈증</option>
											<option value="당뇨" <c:if test="${memberInfo.disease.contains('당뇨')}">selected</c:if>>당뇨</option>
											<option value="대사증후군" <c:if test="${memberInfo.disease.contains('대사증후군')}">selected</c:if>>대사증후군</option>
											<option value="디스크(허리)" <c:if test="${memberInfo.disease.contains('디스크(허리)')}">selected</c:if>>디스크(허리)</option>
											<option value="천식" <c:if test="${memberInfo.disease.contains('천식')}">selected</c:if>>천식</option>
											<option value="심혈관 질환" <c:if test="${memberInfo.disease.contains('심혈관 질환')}">selected</c:if>>심혈관 질환</option>
											<option value="골다골증" <c:if test="${memberInfo.disease.contains('골다골증')}">selected</c:if>>골다골증</option>
											<option value="관절염" <c:if test="${memberInfo.disease.contains('관절염')}">selected</c:if>>관절염(류마티스 등)</option>
											<option value="편두통 혹은 만성두통" <c:if test="${memberInfo.disease.contains('편두통 혹은 만성두통')}">selected</c:if>>편두통 혹은 만성두통</option>
											<option value="갑상선장애" <c:if test="${memberInfo.disease.contains('갑상선장애')}">selected</c:if>>갑상선 장애</option>
										</select>
										<select id="goal" name="goal" class="custom-select mb-2" >
											<option value="없음">운동 목표</option>
											<option value="체중 감량" <c:if test="${memberInfo.goal.contains('체중 감량')}">selected</c:if>>체중 감량</option>
											<option value="근력 증가" <c:if test="${memberInfo.goal.contains('근력 증가')}">selected</c:if>>근력 증가</option>
											<option value="수술 후 재활" <c:if test="${memberInfo.goal.contains('수술 후 재활')}">selected</c:if>>수술 후 재활</option>
											<option value="유연성 운동" <c:if test="${memberInfo.goal.contains('유연성 운동')}">selected</c:if>>유연성 운동</option>
											<option value="균형 증가" <c:if test="${memberInfo.goal.contains('균형 증가')}">selected</c:if>>균형 증가</option>
											<option value="심혈관 기능 증진" <c:if test="${memberInfo.goal.contains('심혈관 기능 증진')}">selected</c:if>>심혈관 기능증진</option>
										</select>
										
										<button type="button" class="btn btn-primary" onclick="changeDisease();">변경하기</button>
										</form>
									</div>
								</div>
							</c:if>
							<script>
									$(()=>{
										$(".sumoselect_multiple").SumoSelect({
											placeholder: "기저질환",
										});
										
										 // 초기 선택 값 설정
									    const initialValues = $("#disease").val(); // 초기 선택된 값 가져오기
									    if (initialValues) {
									        initialValues.forEach(value => {
									            $(".sumoselect_multiple")[0].sumo.selectItem(value);
									        });
									    }

										$("#disease").on("change",()=>{
											let disease = $("#disease").val();
											const none = disease.includes('없음');
											
											
											// for(d of disease){if(d === '없음'){$(".sumoselect_multiple")[0].sumo.unSelectItem(2);}}
											if(none){
												$(".sumoselect_multiple option").each(function(){
													if($(this).val() !== '없음'){
														$(this).prop('disabled', true);
													}
												});
												
												$(".sumoselect_multiple")[0].sumo.reload();
											}else{
												$(".sumoselect_multiple option").each(function () {
													$(this).prop('disabled', false);
												});
												$(".sumoselect_multiple")[0].sumo.unSelectItem(0);
												$(".sumoselect_multiple")[0].sumo.reload();
										
											}

										});
										
									});

									function changeDisease(){
										let height = $("input[name=height]").val();
										let weight = $("input[name=weight]").val();
										var disease = $("select[name=disease]").val();
										var goal = $("select[name=goal]").val();
										let mHeight = ${memberInfo.height};
										let mWeight = ${memberInfo.weight};
										let mDisease = ${disease};
										let mGoal = "${memberInfo.goal}";
										
										if(parseInt(height) === mHeight && parseInt(weight) === mWeight && 
												   JSON.stringify(disease) === JSON.stringify(mDisease) && goal === mGoal){
											Swal.fire({ icon:'warning',	title: '바뀐 정보가 없습니다.' })
										}else{
											$.ajax({
												url:"changeDisease.me",
												method:"POST",
												data:{
													"userNo": ${loginUser.userNo},
													"height": height,
													"weight": weight,
													"disease": disease,
													"goal": goal,
												},
												success:(result)=>{
													if(result === 'DDDY'){
														Swal.fire({ icon:'success',	title: '변경 성공!' })
													}else{
														Swal.fire({ icon:'warning',	title: '정보변경에 실패 했습니다.' })
													}
												},
												error:()=>{
													console.log("disease change ajax failed");
													
												},
											})
										}
										
									}
							</script>
						</div>
						<div class="col-lg-6">
							<div class="card shadow mb-4">
								<!-- Card Header - Dropdown -->
								<div
									class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
									<h6 class="m-0 font-weight-bold text-primary">이메일 변경</h6>
									
								</div>
								<!-- Card Body -->
								<div class="card-body" id="change-email">
									<div class='input-group'>
										<label class="col-form-label mr-3">비밀번호 입력</label>
										<input type="password" class="form-control">
										<button class="btn btn-primary ml-3">확인</button>
									</div>
									<div class="input-group mt-3">
										<label class="col-form-label mr-3">변경할 이메일</label>
										<input type="email" class="form-control mr-2">
										<button class="btn btn-primary">인증번호</button>
									</div>
									<div class="input-group mt-3">
										<label class="col-form-label mr-3">인증번호 입력</label>
										<input type="number" class="form-control">
									</div>
									<button class="btn btn-primary mt-3">이메일 변경</button>
								</div>
							</div>

							<c:if test="${ loginUser.userLevel == '2' }">
								<div class="card shadow mb-4">
									<!-- Card Header - Dropdown -->
									<div
										class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
										<h6 class="m-0 font-weight-bold text-primary">트레이너 변경</h6>
										<div class="dropdown no-arrow">
											<a class="dropdown-toggle" href="#" role="button"
												id="dropdownMenuLink" data-toggle="dropdown"
												aria-haspopup="true" aria-expanded="false"> <i
												class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
											</a>
									
										</div>
									</div>
									<!-- Card Body -->
									<div class="card-body">개인회원만 보임</div>
								</div>
							</c:if>
							

							<div class="card shadow mb-4">
								<!-- Card Header - Dropdown -->
								<div
									class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
									<h6 class="m-0 font-weight-bold text-danger">회원 탈퇴</h6>
								</div>
								<!-- Card Body -->
								<div class="card-body">
									<div class="card-body" id="member-cancle">
									<div class='input-group'>
										<label class="col-form-label mr-4">비밀번호 입력</label>
											<input type="password" class="form-control">
									</div>
									
									<button class="btn btn-danger mt-3">회원탈퇴</button>
								</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
</body>

</html>