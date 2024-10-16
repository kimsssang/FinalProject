<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>FitGuardians</title>
        <link rel="stylesheet" href="resources/css/loginForm.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	    <!-- sweetalert2 -->
	    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.14.1/dist/sweetalert2.all.min.js"></script>
		<link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.14.1/dist/sweetalert2.min.css" rel="stylesheet">
    </head>
    <body>
    	<c:if test="${ not empty errorMsg }">
    		<script>
		   		 Swal.fire({
				      icon: 'warning',
				      title: '실패',
				      text: "${errorMsg}",
				    });
    		</script>
    		<c:remove var="errorMsg" scope="session"/>
    	</c:if>
    
        <div class="topLogoContainer">
            <img
                src="resources/images/FitGuardians로고-001.png"
                alt="">
        </div>
        <div class="container">
            <!-- 상위 버튼 -->
            <ul class="links">
                <li>
                    <a href="javascript:void(0)" id="signin">로그인</a>
                </li>
                <li>
                    <a href="enrollForm.me" id="signup">회원가입</a>
                </li>
                <li>
                    <a href="javascript:void(0)" id="reset">초기화</a>
                </li>
            </ul>

            <!-- 입력 폼 -->
            <form action="login.me" method="post">
                <!-- 아이디 -->
                <div class="first-input input__block first-input__block">
                    <input type="text" placeholder="아이디" class="input" id="userId" name="userId" />
                </div>
                <!-- 비밀번호 -->
                <div class="input__block">
                    <input type="password" placeholder="비밀번호" class="input" id="userPwd" name="userPwd" />
                </div>
                <!-- 로그인 버튼 -->
                <button class="signin__btn">
                    로그인
                </button>
            </form>
            <!-- 구분선 -->
            <div class="separator">
                <p>OR</p>
            </div>
            <!-- 카카오 소셜 로그인 -->
            <button class="socialLogin__btn kakao__btn" value="kakao">
                카카오로 로그인하기
            </button>
            <!-- 네이버 소셜 로그인 -->
            <button class="socialLogin__btn naver__btn" value="naver">
                네이버로 로그인하기
            </button>
            <!-- 구글 소셜 로그인 -->
            <button class="socialLogin__btn google__btn" value="google">
                <!-- <img src="../resources/svg/web_neutral_rd_na.svg" alt=""/> -->
                구글로 로그인하기
            </button>
        </div>
		<script>
            $(function(){
                //----------- 초기화 버튼 ---------------------
                let reset = $(".links").find("li").find("#reset"); 
                reset.on("click",function(e){
                    e.preventDefault();
                    $(this).parent().parent().siblings("form")
                    .find(".input__block").find(".input").val("");
                })

                // 와우! 버튼에도 value값을 설정할 수 있었다니!
                //----------- 소셜 로그인 버튼 ---------------------
                $(".socialLogin__btn").click(function(){

                    let btnValue = $(this).val()
					
                    $.ajax({
                        url: 'socialLogin.me',
                        data: { social: btnValue },
                        success:function(data){
                        	window.location.href = data;  // 서버에서 대시보드로 리다이렉트하는 URL을 반환받아 이동
                        },
                        error:function(){
                            console.log("소셜 로그인 실패")
                        },
                    })
                    
                });
            });
        </script>
    </body>
</html>