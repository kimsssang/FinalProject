<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chat Page</title>
    <!-- Bootstrap CSS 추가 -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/5.3.0/css/bootstrap.min.css">
    <style>
        .trainer {
            cursor: pointer; /* 클릭 가능하다는 느낌을 줌 */
            transition: background-color 0.3s; /* 부드러운 배경색 변화 */
        }

        .trainer:hover {
            background-color: #f8f9fa; /* 마우스 오버 시 배경색 변경 */
        }
    </style>
</head>
<body id="page-top">
    <div id="wrapper">
        <jsp:include page="../common/sideTrainee.jsp"/>
        <div id="content-wrapper" class="d-flex flex-column">
            <div id="content">
                <jsp:include page="../common/topBar.jsp"/>
                <div class="container-fluid">
                    <c:choose>
                        <c:when test="${not empty sessionScope.loginUser.userNo}">
                            <div class="card mb-4">
                                <div class="card-header py-3">
                                    <h6 class="m-0 font-weight-bold text-primary">트레이너 검색</h6>
                                </div>
                                <div class="card-body">
                                    <div class="input-group">
                                        <input type="text" id="trainerSearchInput" class="form-control" placeholder="트레이너 이름을 입력하세요." style="margin-right:10px">
                                        <button type="button" class="btn btn-primary ms-2" id="trainerSearchBtn">검색</button>
                                    </div>
                                    <div id="trainersContainer" style="display: flex; flex-wrap: wrap; gap: 10px; margin-top: 20px;"></div>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="alert alert-warning">로그인 후에 이용 가능합니다.</div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>

    <!-- 채팅 모달 -->
	<div class="modal fade" id="chatModal1" tabindex="-1" aria-labelledby="chatModalLabel1" aria-hidden="true">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h5 class="modal-title" id="chatModalLabel1">채팅</h5>
	                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	            </div>
	            <div class="modal-body">
	                <!-- 채팅 메시지 영역 -->
	                <div id="chatMessages" style="height: 300px; overflow-y: auto; border: 1px solid #ddd; padding: 10px;">
	                    <!-- 더미 채팅 메시지 -->
	                </div>
	                <!-- 입력 영역 -->
	                <div class="input-group mt-3">
	                    <input type="text" id="messageInput" class="form-control" placeholder="메시지를 입력하세요." />
	                    <button class="btn btn-primary" type="button" id="sendMessageBtn">전송</button>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>
    <script>
	    $(document).ready(function() {
	        $('#trainerSearchBtn').on('click', function() {
	            var keyword = $('#trainerSearchInput').val().trim(); // 검색어 가져오기
	
	            if (keyword) {
	                $.ajax({
	                    type: 'POST',
	                    url: '/fitguardians/searchTrainers', // 기존 URL 유지
	                    data: { keyword: keyword },
	                    dataType: 'json',
	                    success: function(response) {
	                        $('#trainersContainer').empty(); // 이전 검색 결과 삭제
	                        console.log(response);
	
	                        var trainersList = "";
	                        response.forEach(function(trainer) {
	                            trainersList += '<div class="trainer" data-userno="' + trainer.userNo + '" style="flex: 1 1 calc(25% - 10px); box-sizing: border-box;">' +
	                                            '<p>User No: ' + trainer.userNo + '</p>' +
	                                            '<p>User ID: ' + trainer.userId + '</p>' +
	                                            '<p>Name: ' + trainer.userName + '</p>' +
	                                            '<p>Email: ' + trainer.email + '</p>' +
	                                            '<p>Phone: ' + trainer.phone + '</p>' +
	                                            '<img src="' + trainer.profilePic + '" alt="' + trainer.userName + '" style="width: 100px; height: 100px;"/>' +
	                                            '</div>';
	                        });
	                        $("#trainersContainer").html(trainersList);
	                        
	                        // AJAX 요청이 성공한 후에 클릭 이벤트 바인딩
	                        $('#trainersContainer').on('click', '.trainer', function() {
	                            var userNo = $(this).data('userno');
	                            var trainerName = $(this).find('p').eq(2).text().split(': ')[1]; // 이름 가져오기
	                            openChatModal(userNo, trainerName); // openChatModal 호출
	                        });
	                    },
	                    error: function(xhr, status, error) {
	                        console.error("검색 요청 실패:", error);
	                    }
	                });
	            } else {
	                alert("검색어를 입력하세요.");
	            }
	        });
	
	        // openChatModal 함수 정의
	        function openChatModal(userNo, trainerName) {
	            // 모달을 표시합니다
	            $('#chatModal1').modal('show'); // 모달을 보여주도록 설정
	
	            // 트레이너의 이름을 설정
	            $('#chatModalLabel1').text('채팅 - ' + trainerName);
	            
	            // 모달을 열 때 채팅 기록을 지우는 옵션 (선택 사항)
	            $('#chatMessages').empty();
	        }
	
	        

	
	        function sendMessageToTrainer(message) {
	            // 메시지를 전송하기 위한 AJAX 요청 (추가 구현 필요)
	            console.log("트레이너에게 전송된 메시지:", message);
	            // 채팅 기록에 전송한 메시지를 추가합니다
	            $('#chatMessages').append('<div class="chat-message"><strong>나:</strong> ' + message + '</div>');
	        }
	    });

    </script>
</body>
</html>
