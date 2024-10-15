<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Page</title>
<!-- Custom fonts for this template-->
<!-- <link href="resources/templates/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css"> -->
<!-- <link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet"> -->
<link rel="stylesheet" href="resources/css/sumoselect.css">

<!-- <script defer src="resources/templates/vendor/jquery/jquery.min.js"></script> -->
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
													<div class="h5 mb-0 font-weight-bold text-gray-800"
														id="enroll-date">${ loginUser.enrollDate}</div>
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

													<div class="h5 mb-0 font-weight-bold text-gray-800"
														id="d-day" data-enroll-date="${ loginUser.enrollDate }">+</div>
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
													<div class="h5 mb-0 font-weight-bold text-gray-800">0</div>
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
							<!-- 비밀번호변경 -->
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
										<input type="password" id="cChangePwd" class="form-control">
									</div>
									<div class="input-group mt-3" id="changePwdBox"	style="display: none">
										<label class="col-form-label mr-2">변경할 비밀번호</label> 
										<input type="password" id="newPwd" class="form-control mr-2">
										<label class="col-form-label mr-2">비밀번호확인</label> 
										<input type="password" id="newPwdC" class="form-control">
									</div>
									<button class="btn btn-primary mt-3" id="checkPwdBtn"
										onclick="checkPwd();">비밀번호 확인</button>
									<button class="btn btn-primary mt-3" id="changePwdBtn"
										onclick="changePwd();" style="display: none">비밀번호 변경</button>
								</div>
							</div>
							<c:choose>
								<c:when test="${ loginUser.userLevel == '2' }">
									<!-- 개인 인적사항 변경 -->
									<div class="card shadow mb-4">
										<div
											class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
											<h6 class="m-0 font-weight-bold text-primary">개인 인적사항 변경</h6>
											<div class="dropdown no-arrow">
												<a class="dropdown-toggle text-gray-500" href="#"
													role="button" id="dropdownMenuLink" data-toggle="dropdown"
													aria-haspopup="true" aria-expanded="false"> 블라인드해제 <i
													class="fas fa-ellipsis-v fa-sm fa-fw "></i>
												</a>
												<div
													class="dropdown-menu dropdown-menu-right shadow animated--fade-in"
													aria-labelledby="dropdownMenuLink">
													<div class="dropdown-header">블라인드 해제:</div>
													<button class="dropdown-item" onclick="offBlur();">해제</button>
													<button class="dropdown-item" onclick="onBlur();">활성화</button>
												</div>
											</div>
										</div>
										<div class="card-body" id="disease-card"
											style="filter: blur(5px)">
											<form action="">
												<div class="input-group mb-3">
													<input type="number" id="height" name="height"
														class="form-control" placeholder="키 (cm)"
														value="${ memberInfo.height }" required> <input
														type="number" id="weight" name="weight"
														class="form-control" placeholder="몸무게 (kg)"
														value="${ memberInfo.weight }" required>
												</div>
												<select id="disease" name="disease"
													class="mb-3 sumoselect_multiple" multiple="multiple">
													<option value="없음">없음</option>
													<option value="혈압조절장애"
														<c:if test="${memberInfo.disease.contains('혈압조절장애')}">selected</c:if>>혈압조절장애(고혈압,
														저혈압)</option>
													<option value="고지혈증"
														<c:if test="${memberInfo.disease.contains('고지혈증')}">selected</c:if>>고지혈증</option>
													<option value="당뇨"
														<c:if test="${memberInfo.disease.contains('당뇨')}">selected</c:if>>당뇨</option>
													<option value="대사증후군"
														<c:if test="${memberInfo.disease.contains('대사증후군')}">selected</c:if>>대사증후군</option>
													<option value="디스크(허리)"
														<c:if test="${memberInfo.disease.contains('디스크(허리)')}">selected</c:if>>디스크(허리)</option>
													<option value="천식"
														<c:if test="${memberInfo.disease.contains('천식')}">selected</c:if>>천식</option>
													<option value="심혈관질환"
														<c:if test="${memberInfo.disease.contains('심혈관 질환')}">selected</c:if>>심혈관
														질환</option>
													<option value="골다골증"
														<c:if test="${memberInfo.disease.contains('골다골증')}">selected</c:if>>골다골증</option>
													<option value="관절염"
														<c:if test="${memberInfo.disease.contains('관절염')}">selected</c:if>>관절염(류마티스
														등)</option>
													<option value="편두통혹은만성두통"
														<c:if test="${memberInfo.disease.contains('편두통혹은만성두통')}">selected</c:if>>편두통
														혹은 만성두통</option>
													<option value="갑상선장애"
														<c:if test="${memberInfo.disease.contains('갑상선장애')}">selected</c:if>>갑상선
														장애</option>
												</select> <select id="goal" name="goal" class="custom-select mb-2">
													<option value="없음">운동 목표</option>
													<option value="체중 감량"
														<c:if test="${memberInfo.goal.contains('체중 감량')}">selected</c:if>>체중
														감량</option>
													<option value="근력 증가"
														<c:if test="${memberInfo.goal.contains('근력 증가')}">selected</c:if>>근력
														증가</option>
													<option value="수술 후 재활"
														<c:if test="${memberInfo.goal.contains('수술 후 재활')}">selected</c:if>>수술
														후 재활</option>
													<option value="유연성 운동"
														<c:if test="${memberInfo.goal.contains('유연성 운동')}">selected</c:if>>유연성
														운동</option>
													<option value="균형 증가"
														<c:if test="${memberInfo.goal.contains('균형 증가')}">selected</c:if>>균형
														증가</option>
													<option value="심혈관 기능 증진"
														<c:if test="${memberInfo.goal.contains('심혈관 기능 증진')}">selected</c:if>>심혈관
														기능증진</option>
												</select>
	
												<button type="button" class="btn btn-primary"
													onclick="changeDisease();">변경하기</button>
											</form>
										</div>
									</div>
								</c:when>
								<c:otherwise>
									<div class="card shadow mb-4">
										<!-- 트레이너 경력사항 변경 -->
										<div
											class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
											<h6 class="m-0 font-weight-bold text-primary">트레이너 경력사항</h6>
		
										</div>
										<div class="card-body" id="change-email">
											<div class="input-group mt-3">
												<label class="col-form-label mr-4">경  력 </label> 
												<input type="text" class="form-control ml-4 col-1" id="trCareer" value="${trInfo.trCareer}">
												<label class="col-form-label">년</label>
											</div>
											<div class="input-group mt-3">
												<label class="col-form-label mr-3">자격 사항</label> 
												<input type="text" class="form-control" id="trCerti" placeholder=", 로 구분해서 작성해주세요" value="${trInfo.trCerti}">
											</div>
											<div class="input-group mt-3">
												<label class="col-form-label mr-3">간략 소개</label> 
												<textarea rows="5" class="form-control" id="trDescript" style="resize:none">${trInfo.trDescript}</textarea>
											</div>
											<div class="input-group mt-3">
												<label class="col-form-label mr-3" for="trProfile">프로필사진</label>
												<input type="file" class="form-control-file" id="trProfile" value="${trInfo.trProfile}">
												<c:if test="${not empty trInfo.trProfile}">
													<a href="${trInfo.trProfile}" target="_blank">기존 프로필 사진</a>
													<input type="hidden" id="originFile" name="trProfile" value="${trInfo.trProfile}">
												</c:if>
											</div>
											
											<button class="btn btn-primary mt-3" id="tcUpdateBtn" onclick="updateTc();">정보 변경</button>
										</div>
									</div>
								</c:otherwise>
							</c:choose>
						</div>
						<div class="col-lg-6">
							<div class="card shadow mb-4">
								<!-- emal 변경 -->
								<div
									class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
									<h6 class="m-0 font-weight-bold text-primary">이메일 변경</h6>

								</div>
								<div class="card-body" id="change-email">
									<div class='input-group'>
										<label class="col-form-label mr-3">비밀번호 입력</label> <input
											type="password" id="emailPwd" class="form-control">
										<button class="btn btn-primary ml-3" onclick="checkPwdE();">확인</button>
									</div>
									<div class="input-group mt-3">
										<label class="col-form-label mr-3">변경할 이메일</label> <input
											type="email" class="form-control mr-2" id="email">
										<button class="btn btn-primary" id="emailAuthBtn">인증번호</button>
									</div>
									<div class="input-group mt-3">
										<label class="col-form-label mr-3">인증번호 입력</label> <input
											type="number" class="form-control" id="checkEmail">
									</div>
									<button class="btn btn-primary mt-3" id="checkEmailAuth">인증번호
										확인</button>
									<button class="btn btn-primary mt-3" id="changeEmailBtn"
										style="display: none">이메일 변경</button>
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
											<label class="col-form-label mr-4">비밀번호 입력</label> <input
												type="password" class="form-control" id="checkPwdD">
										</div>

										<button class="btn btn-danger mt-3" onclick="deleteUser();">회원탈퇴</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<c:choose>
		<c:when test="${ loginUser.userLevel eq '2' }">
		<script>
			// 일반회원일때만 실행시킬 함수
			// 개인정보 블러 처리
				function onBlur(){
					$("#disease-card").css("filter", "blur(5px)")
				}
				
				// 블러 해제시 비밀번호확인
				function offBlur(){
					let userEncoPwd = "${loginUser.userPwd}";
					Swal.fire({
						icon:"info",
						title: "비밀번호 입력",
						showCancelButton: true,
						confirmButtonText: "확인",
						cancelButtonText: "취소",
						input:"password",
						inputPlaceholder: "비밀번호를 입력해주세요",
						preConfirm:((password)=>{
							return new Promise((resolve, reject) =>{
								$.ajax({
									url:"checkPwd.me",
									method:"POST",
									data:{
										"userPwd":password,
										"userEncoPwd":userEncoPwd,
									},
									success:(result)=>{
										if(result === "YYYP"){
											resolve();
										}else{
											reject("비밀번호가 일치하지 않습니다.")
										}
										
									},
									error:()=>{
										reject("오류가 발생했습니다.")
									},
								})
							});
							
						}),
					}).then(result=>{
						if(result.isConfirmed){
							$("#disease-card").css("filter", "none");
						}
							
						
					})
					
				}
				
				// multi select
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
		</c:when>
		<c:otherwise>
			<script> // 트레이너 일때만 실행시킬 함수
					function updateTc(){
						const trCareer = $("#trCareer").val();
						const trCerti =  $("#trCerti").val();
						const trDescript = $("#trDescript").val();
						const profileInput = $("#trProfile").get(0);
						const trProfile = profileInput.files;
						const originFile = $("#originFile").val();
						const userNo = ${loginUser.userNo};
						const formdata = new FormData();
						formdata.append("userNo", userNo);
						formdata.append("trCareer", trCareer);
						formdata.append("trCerti", trCerti);
						formdata.append("trDescript", trDescript);
						formdata.append("trProfile", originFile);
						formdata.append("upfiles", trProfile[0]);
						
						$.ajax({
							url:"updateInfo.tr",
							method:"POST",
							contentType:false,
							processData:false,
							data:formdata,
							success:(result)=>{
								if(result === "YYTR"){
									Swal.fire({
										icon:"success",
										title:"트레이너정보가 변경 되었습니다!"
									}).then(result=>{
										if(result.isConfirmed){
											location.href = "mypage.me";
										}
									})
								}else{
									Swal.fire({
										icon:"error",
										title:"트레이너정보 변경 실패"
									})
									
								}
							},
							error:()=>{
								console.log("update trainer info ajax failed");
							}
						})
					}
			</script>
		</c:otherwise>
	</c:choose>
	<script>
	// 공통 실행 함수		
			
			// 비밀번호 확인
			function checkPwd(){
				console.log("ASDAS")
				userPwd = $("#cChangePwd").val()
				userNo = ${loginUser.userNo};
				userEncoPwd = "${loginUser.userPwd}";
				if(userPwd == ""){
					Swal.fire({icon:"warning",title:"비밀번호를 입력해주세요"});
				}else{
					$.ajax({
						url:"checkPwd.me",
						method:"POST",
						data:{
							"userNo": userNo,
							"userPwd": userPwd,
							"userEncoPwd": userEncoPwd,
							},
						success:(result)=>{
							
							if(result==="YYYP"){
								Swal.fire({icon:"success",title:"비밀번호가 확인되었습니다!"})
								$("#cChangePwd").attr("readonly",true)
								$("#changePwdBtn").show();
								$("#checkPwdBtn").hide();
								$("#changePwdBox").show();
								
							}else{
								Swal.fire({icon:"warning",title:"비밀번호가 틀렸습니다 다시 입력해주세요"});
							}
						},
						error:()=>{
							console.log("checkPwd Ajax failed");
						}
					});
				}
			}
			
			// 비밀번호 변경
			function changePwd(){
				let newPwd = $("#newPwd").val();
				let userNo = "${loginUser.userNo}";
				$.ajax({
					url:"changePwd.me",
					method:"POST",
					data:{
						"userNo":userNo,
						"userPwd":newPwd,
					},
					success:(result)=>{
						if(result === "YYCP"){
							Swal.fire({icon:"success", title:"비밀번호가 변경되었습니다!"})
							$("#changePwdBox").hide();
							$("#changePwdBtn").hide();
							$("#checkPwdBtn").show();
							$("#newPwd").val("");
							$("#newPwdC").val("");
							$("#cChangePwd").val("");
							$("#cChangePwd").prop("readonly", false);
							
						}else{
							Swal.fire({icon:"warning", title:"비밀번호 변경 실패"})
						}
					},
					error:()=>{
						console.log("change pwd ajax failed");
					},
				})
			}
			
			// 비밀번호 유효성
			$("#newPwd").keyup(()=>{
				let pwd = $("#newPwd").val();
				let reg = /^(?=.*[0-9])(?=.*[a-z])(?=.*[!@#$%^&*(),.?":{}|<>])[A-Za-z0-9!@#$%^&*(),.?":{}|<>]{8,}$/;
		
		                 if(reg.test(pwd)){
		                     $("#changePwdBtn").text("비밀번호 확인");
		                 	$("#changePwdBtn").prop("disabled", false);
		                 }else{
		                 	$("#changePwdBtn").prop("disabled", true);
		                     $("#changePwdBtn").text("비밀번호는 8자 이상이어야 하며, 숫자/소문자/특수문자를 모두 포함해야 합니다.")
		                 }
		                 
			})
			
			// 비밀번호 일치 
		             $("#newPwdC").keyup(()=>{
		                 let pwd = $("#newPwd").val();
		                 let repeatPwd = $("#newPwdC").val();
		                 let changeBtn = $("#changePwdBtn")
		                 if(pwd === repeatPwd){
					changeBtn.text("비밀번호 변경")
					changeBtn.prop("disabled", false);
		                 }else{
		                 	changeBtn.text("비밀번호가 일치하지 않습니다.")
		                 	changeBtn.prop("disabled", true);
		                 }
		             })
			
			
			
			// email 변경
			function checkPwdE(){
				let userPwd = $("#emailPwd").val();
				let userEncoPwd = "${loginUser.userPwd}";
				
				$.ajax({
					url:"checkPwd.me",
					data:{
						"userPwd":userPwd,
						"userEncoPwd":userEncoPwd,
					},
					success:(result)=>{
						if(result==="YYYP"){
							Swal.fire({icon:"success",title:"비밀번호가 확인되었습니다!"})
							$("#emailPwd").prop("readonly",true);
						}else{
							Swal.fire({icon:"warning",title:"비밀번호가 틀렸습니다 다시 입력해주세요"});
							$("#emailPwd").prop("readonly", false);
						}
					},
					error:()=>{
						console.log("check emailPwd ajax failed");
					}
				})
				
			}
			
			// 이메일 인증번호 전송
			$("#emailAuthBtn").click(()=>{
				$.ajax({
					url:"auth.email",
					data:{
						email:$("#email").val()
					},
					success:(num)=>{
						setCookie("auth", num, 3);
						Swal.fire({
								icon: 'success',
								title: '이메일인증',
								text: "인증번호가 발송되었습니다. 이메일을 확인해 주세요",
							});
						timeoutTimer(new Date(Date.now() + 180000), 1000);
						
					},
					error:()=>{
						console.log("auth email ajax failed");
					}
				})
			})
			
			// 이메일로 전송된 번호와 입력된 번호 확인
			$("#checkEmailAuth").click(()=>{
				let val = getCookie("auth");
				let inputNum = $("#checkEmail").val();
				let btn1 = $("#checkEmailAuth");
				let btn2 = $("#changeEmailBtn");
				if(inputNum.length > 4){
					
					if(val === inputNum){
						Swal.fire({
								icon: 'success',
								title: '이메일인증',
								text: "인증이 완료 되었습니다.",
							});
							btn1.hide();
							btn2.show();
					}else{
						Swal.fire({
								icon: 'warning',
								title: '이메일인증',
								text: "인증번호가 다릅니다.",
							});
						btn1.show();
						btn2.hide();
						
					}
				}
			})
			
			$("#changeEmailBtn").click(()=>{
				let email = $("#email").val();
				let userNo = ${loginUser.userNo};
				$.ajax({
					url:"changeEmail.me",
					method:"POST",
					data:{
						"email":email,
						"userNo":userNo,
					},
					success:(result)=>{
						if(result === "YYYE"){
							Swal.fire({
								icon: 'success',
								title: '이메일이 변경되었습니다!',
							});
						}else{
							Swal.fire({
								icon: 'warning',
								title: '이메일 변경에 실패했습니다',
							});
						}
					},
					error:()=>{
						console.log("change email ajax failed");
					}
				})	
			});
			
			function deleteUser(){
				
				let userPwd = $("#checkPwdD").val();
				let userEncoPwd = "${loginUser.userPwd}";
				let userNo = ${loginUser.userNo};
				$.ajax({
					url:"checkPwd.me",
					data:{
						"userPwd":userPwd,
						"userEncoPwd":userEncoPwd,
					},
					success:(result)=>{
						if(result==="YYYP"){
							Swal.fire({
								icon:"info",
								title: "정말 탈퇴 하시겠습니까?",
								showCancelButton: true,
								confirmButtonText: "확인",
								cancelButtonText: "취소",
							}).then(result=>{
								if(result.isConfirmed){
									$.ajax({
										url:"delete.me",
										data:{"userNo":userNo},
										success:(result)=>{
											if(result === "YYYD"){
												Swal.fire({
													icon:"success",
													title:"이용해주셔서 감사합니다."
													
												}).then(result=>{
													if(result.isConfirmed){
														location.href = "main.co"
													}
												})
												
											}else{
												
											}
										},
										error:()=>{
											console.log("delete member ajax failed");
										},
									})
								}
							})
						}else{
							Swal.fire({icon:"warning",title:"비밀번호가 틀렸습니다 다시 입력해주세요"});
						}
					},
					error:()=>{
						console.log("check emailPwd ajax failed");
					}
				})
			}
									
			// 쿠키 생성 분으로
			function setCookie(name, value, time) {
				let date = new Date();
				date.setMinutes(date.getMinutes() + time);
				let cookie_value = escape(value) + ((time==null) ? '' : '; expires=' + date.toUTCString())
				document.cookie = name + "=" + cookie_value
			}
			// 쿠키네임의 쿠키value찾기
			function getCookie(cookie_name) {
					var x, y;
					var val = document.cookie.split(';');
		
					for (var i = 0; i < val.length; i++) {
					x = val[i].substr(0, val[i].indexOf('='));
					y = val[i].substr(val[i].indexOf('=') + 1);
					x = x.replace(/^\s+|\s+$/g, '');
					if (x == cookie_name) {
						return unescape(y);
					}
					}
				}
			
			// 타이머 생성
			function timeoutTimer(endTime, timeout){
				const now = Date.now();
				const end = endTime.getTime();
				const timeLeft = (end - now)/1000 ;
				const timeBtn = $("#emailAuthBtn");
				
				if(timeLeft <= 0){
					console.log('타이머 종료');
					return;
				}
				const minutes = Math.floor(timeLeft / 60);
				const seconds = Math.floor(timeLeft % 60);
				
				const minute = String(minutes).padStart(2, '0');
				const second = String(seconds).padStart(2, '0');
				
				
				timeBtn.text(`\${minute} : \${second}`);
				
				setTimeout(()=>{
					timeoutTimer(endTime, timeout);
				}, timeout);
			}
			
			// d-day 
			document.addEventListener("DOMContentLoaded", ()=>{
				const dDay = document.getElementById("d-day");
				const enrollDate = new Date(dDay.getAttribute('data-enroll-date'));
				const currentDate = new Date();
				
				const difTime = currentDate - enrollDate;
				
				const difDay = Math.ceil(difTime / (1000 * 60 * 60 * 24 ));
				
				if(difDay >= 0){
					dDay.textContent = "+" + difDay;
					
				}else{
					dDay.textContent = "미등록"
				}
				
				// 등록일 
				const enrollDay = "${loginUser.enrollDate}";
				const eDate = new Date(enrollDay); 
				// 날짜를 원하는 형식으로 포맷팅
			    const year = eDate.getFullYear();
			    const month = String(eDate.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 +1
			    const day = String(eDate.getDate()).padStart(2, '0');

			    const formattedDate = `\${year}년 \${month}월 \${day}일`;
			    
			    $("#enroll-date").text(formattedDate);
				
			})
	</script>
</body>

</html>