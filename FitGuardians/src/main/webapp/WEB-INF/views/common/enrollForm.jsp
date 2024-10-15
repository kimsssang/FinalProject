<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <link href="./resources/templates/css/sb-admin-2.css" rel="stylesheet" />
	<link rel="stylesheet" href="resources/css/sumoselect.css">
    <!-- Bootstrap core JavaScript-->
    <script src="./resources/templates/vendor/jquery/jquery.min.js"></script>
    <script src="./resources/templates/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script defer src="resources/js/jquery.sumoselect.js"></script>
    <!-- sweetalert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.14.1/dist/sweetalert2.all.min.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.14.1/dist/sweetalert2.min.css" rel="stylesheet">
	<!-- 우편번호 -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <link rel="stylesheet" href="resources/css/enrollForm.css">
</head>
    <body>
        <a class="topLogoContainer" href="main.co">
            <img src="resources/images/FitGuardians로고-001.png" alt="">
		</a>
        <div class="container">
            <!-- 상위 버튼 -->
            <ul class="links">
                <li>
                	<span id="signup">회원가입</span>
                </li>
                <li>
                    
                </li>
                <li>
                    <a href="#" id="reset">초기화</a>
                </li>
            </ul>

            <!-- 입력 폼 -->
            <form action="enroll.me" method="post">
            	<div class="form-check-inline mb-3 ml-4">
                    <label class="form-check-label" for="trainer">회원분류 : 트레이너
                        <input class="form-check-input" type="radio" name="userLevel" id="trainer" value="1"/>
                    </label>
                    <label class="form-check-label" for="trainee">일반회원
                        <input class="form-check-input" type="radio" name="userLevel" id="trainee" value="2">
                    </label>
                </div>
                <!-- 아이디 -->
                <div class="input-group mb-3 ml-4">
                    <input type="text" placeholder="영문으로 시작하는 6~20자리 아이디" class="form-control" id="userId" name="userId" required/>
                    <span id="idcheck" class="btn btn-sm ml-4" style="display:none"></span>
                </div>
                <!-- 이메일 -->
                <div class="input-group mb-3 ml-4">
                    <input type="email" placeholder="이메일" class="form-control" id="email" name="email" required/>
                    <button id="emailBtn" type="button" class="btn btn-sm ml-4" style="display:none">인증번호 발송</button>
                </div>
                <!-- 이메일 확인 -->
                <div class="input-group mb-3 ml-4">
                    <input type="text" placeholder="인증번호입력" class="form-control" id="checkEmail" name="checkEmail"/>
                </div>
                <!-- 비밀번호 -->
                <div class="input-group mb-3 ml-4">
                    <input type="password" placeholder="비밀번호" class="form-control" id="userPwd" name="userPwd" required/>
                </div>
                <!-- 비밀번호 확인 -->
                <div class="input-group mb-3 ml-4">
                    <input type="password" placeholder="비밀번호 확인" class="form-control repeat__password" id="repeat_password"/>
                    <span id="pwdCheck" class="btn btn-sm ml-4" style="display:none"></span>
                </div>
                <!-- 이름 -->
                <div class="input-group mb-3 ml-4">
                    <input type="text" placeholder="이름" class="form-control" id="userName" name="userName" required/>
                </div>
                <!-- 나이 -->
                <div class="input-group mb-3 ml-4">
                    <input type="number" placeholder="나이" class="form-control" id="age" name="age"/>
                </div>
                <!-- 성별 -->
                <div class="form-check-inline mb-3 ml-4">
                    <label class="form-check-label" for="Male">성별 : 남자
                        <input class="form-check-input" type="radio" name="gender" id="Male" value="M"/>
                    </label>
                    <label class="form-check-label" for="Female">여자
                        <input class="gender" type="radio" name="gender" id="Female" value="F">
                    </label>
                </div>
                <!-- 전화번호 -->
                <div class="input-group mb-3 ml-4">
                    <input type="text" placeholder="전화번호" class="form-control" id="phone" name="phone"/>
                </div>
                <!-- 전화번호 -->
                <div class="input-group mb-3 ml-4">
						<input type="text" placeholder="우편번호" class="form-control" id="postNum" name="address"/>
					<div class="input-group-prepend">
						<button type="button" class="btn btn-sm form-control" onclick="searchPost();">검색</button>
					</div>
                </div>
                
                <div class="input-group mb-3 ml-4">
                    <input type="text" placeholder="상세주소" class="form-control" id="address" name="address"/>
                </div>
                
                <!-- 추가회원 정보 모달 열기 -->
                <div class="input-group mb-3 ml-4">
                    <button type="button" onclick="javascript:void(0)" class="form-control" id="additionalInfoBtn" name="additionalInfoBtn" style="text-align: left;" >추가정보</button>
                </div>
				
                <!-- 추가회원정보에 대한 내용이 담겨있는 히든 인풋 태그 -->
				<input type="hidden" id="memberInfo" name="memberInfo">
				
                <!-- 회원가입 버튼 -->
                <button id="enrollBtn" class="btn-primary btn-block btn disabled mb-3 ml-4" disabled>회원가입</button>
            </form>
        </div>
        
        <script>
			let timeBtn = $("#emailBtn");
			$(()=>{
				// 회원분류 체크
				$("#trainee").prop("checked", true);
				
				$("input[name=userLevel]").change(()=>{
					var chekcedTrainer = $("#trainer").prop("checked");

					if(chekcedTrainer){
						$("#trainee").prop("checked", false);
						
					}						
					
				})
				


				let submit = $("#enrollBtn");
				// 아이디 유효성
				$("#userId").keyup(()=>{
					let id = $("#userId").val();
					const patter = /^[a-zA-Z][a-zA-Z0-9]{5,19}$/;
					
					if(patter.test(id)){
						
                        $.ajax({
							url:"checkId.me",
							data:{
								userId : $("#userId").val()
							},
							success:((result)=>{
								if(result === 'YYYI'){
									$("#idcheck").show();
									$("#idcheck").text("사용가능한 아이디입니다").css("color", "skyblue");
									submit.removeAttr("disabled");
                                    submit.removeClass("disabled");

								}else{
									$("#userId").focus();
									$("#idcheck").show();
									$("#idcheck").text("중복된 아이디입니다. 다시입력해주세요").css("color","red");
									submit.attr("disabled");
									submit.addClass("disabled");
								}
							}),
							error:(()=>{
								console.log("id check ajax failed");
							})
                        
                        })
					}else{
						$("#idcheck").show();
						$("#idcheck").text("영문으로 시작하는 6~20자리 아이디가 아닙니다 다시입력해주세요").css("color","red");
						submit.attr("disabled");
						submit.addClass("disabled");
					}
				})
				
				// 이메일 유효성
				$("#email").keyup(()=>{
					let email = $("#email").val()
					const pattern = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-za-z0-9\-]+/;
					
					if(pattern.test(email)){
						$("#emailBtn").show();
					}else{
						submit.attr("disabled");
						submit.addClass("disabled");
					}
				})

				// 비밀번호 유효성
				$("#userPwd").keyup(()=>{
					let pwd = $("#userPwd").val();
					let reg = /^(?=.*[0-9])(?=.*[a-z])(?=.*[!@#$%^&*(),.?":{}|<>])[A-Za-z0-9!@#$%^&*(),.?":{}|<>]{8,}$/;

                    if(reg.test(pwd)){
                        $("#repeat_password").attr("placeholder", "비밀번호 확인");
                    }else{
                        $("#repeat_password").attr("placeholder", "비밀번호는 8자 이상이어야 하며, 숫자/소문자/특수문자를 모두 포함해야 합니다.")
                    }
                    
				})
				
				// 비밀번호 일치 
                $("#repeat_password").keyup(()=>{
                    let pwd = $("#userPwd").val();
                    let repeatPwd = $("#repeat_password").val();
                    let pwdCheck = $("#pwdCheck");
                    if(pwd === repeatPwd){
                        submit.removeAttr("disabled");
                        submit.removeClass("disabled");
                        pwdCheck.show();
                        pwdCheck.text("비밀번호가 일치합니다.")
                        
                        $("#repeat_password").blur(()=>{
							pwdCheck.hide();
                        })
                        
                    }else{
						pwdCheck.hide();
						submit.attr("disabled");
						submit.addClass("disabled");
                    }
                })
                
			   //----------- reset ---------------------
                let reset  = $(".links").find("li").find("#reset")  ; 
				reset.on("click",function(e){
					e.preventDefault();
					$(this).parent().parent().siblings("form").find(".input").val("");
				})
				
			   // 이메일 인증
				$("#emailBtn").click(()=>{
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
				$("#checkEmail").keyup(()=>{
					let val = getCookie("auth");
					let inputNum = $("#checkEmail").val();
					if(inputNum.length > 4){
						
						if(val === inputNum){
							Swal.fire({
									icon: 'success',
									title: '이메일인증',
									text: "인증이 완료 되었습니다.",
								});
							$("#checkEmail").hide();
							timeBtn.hide();
						}else{
							Swal.fire({
									icon: 'warning',
									title: '이메일인증',
									text: "인증번호가 다릅니다.",
								});
							
						}
					}
				})
				
			})
			
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
			
			// 우편번호 검색
			function searchPost(){
				let post = $("#postNum")
				let detail = $("#address")
				new daum.Postcode({
					oncomplete: function(data) {
						const address = data.address;
						const building = data.buildingName;
						const postNum = data.zonecode;
						post.val(postNum);
						detail.val(address + " " + building);
					}
				}).open();
			}
			
			
			// 추가 정보 입력 모달
			$("#additionalInfoBtn").click(function() {
				var traineeCheck = $("#trainee").prop("checked");
				if(traineeCheck){
					console.log("aaa");
					
					Swal.fire({
					title: '추가 정보 입력',
					html: `
						<input type="number" id="height" name="height" class="swal2-input" placeholder="키 (cm)">
						<input type="number" id="weight" name="weight" class="swal2-input" placeholder="몸무게 (kg)">
						
						<select id="disease" name="disease" class="sumoselect_multiple mt-3" multiple=multiple>
							<option value="" hidden selected disabled>기저질환</option>
							<option value="없음">없음</option>
							<option value="혈압조절장애">혈압조절장애(고혈압, 저혈압)</option>
							<option value="고지혈증">고지혈증</option>
							<option value="당뇨">당뇨</option>
							<option value="대사증후군">대사증후군</option>
							<option value="디스크">디스크(목, 허리)</option>
							<option value="천식">천식</option>
							<option value="심혈관_질환">심혈관 질환</option>
							<option value="골다공증">골다공증</option>
							<option value="관절염">관절염(류마티스 등)</option>
							<option value="편두통_혹은_만성두통">편두통 혹은 만성두통</option>
							<option value="갑상선_장애">디스크(목, 허리)</option>
						</select>
						<select id="goal" class="custom-select">
							<option value="" hidden selected disabled>운동 목표</option>
							<option value="체중_감량">체중 감량</option>
							<option value="근력_증가">근력 증가</option>
							<option value="수술_후_재활">수술 후 재활</option>
							<option value="유연성_운동">유연성 운동</option>
							<option value="균형_증가">균형 증가</option>
							<option value="심혈관_기능증진">심혈관 기능증진</option>
						</select>
					`,
					confirmButtonText: '저장',
					customClass: {
						popup: 'custom-popup',    // 팝업 전체에 커스텀 스타일 적용
						content: 'custom-content' // 컨텐츠에 대한 스타일 적용
					},
					preConfirm: () => {
						return {
							height: $("#height").val(),
							weight: $("#weight").val(),
							disease: $("#disease").val(),
							goal: $("#goal").val(),
						}
					},
					showCancelButton: true,
					cancelButtonText: '취소',
				}).then((result) => {
					if (result.isConfirmed) {
						let info = result.value;
						if (info.height && info.weight && info.disease && info.goal) {
							$("#memberInfo").val(JSON.stringify(info));
							Swal.fire('저장되었습니다!', '', 'success');
						} else {
							Swal.fire('모든 정보를 입력해 주세요', '', 'error');
						}
					}
				});
				}else {
					Swal.fire({icon:"warning", title:"일반회원만 입력할수있습니다"})
				}

				$(".sumoselect_multiple").SumoSelect({
					placeholder: "Select options",
				});
			})
		</script>
		
        <footer>
            <p>
                <!-- 테스트 -->
            </p>
        </footer>
    </body>
</html>