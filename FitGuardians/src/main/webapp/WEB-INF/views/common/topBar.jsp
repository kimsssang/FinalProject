<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Top Bar</title>
<!-- sweetalert2 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.14.1/dist/sweetalert2.all.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.14.1/dist/sweetalert2.min.css" rel="stylesheet">

</head>
<body>
<!-- Topbar -->
                <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

                    <!-- Sidebar Toggle (Topbar) -->
                    <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                        <i class="fa fa-bars"></i>
                    </button>

                    <!-- Topbar Navbar -->
                    <ul class="navbar-nav ml-auto">

						<c:choose>
							<c:when test="${ not empty loginUser }">
		                        <!-- Nav Item - Search Dropdown (Visible Only XS) -->
		                        <li class="nav-item dropdown no-arrow d-sm-none">
		                            <a class="nav-link dropdown-toggle" href="#" id="searchDropdown" role="button"
		                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		                                <i class="fas fa-search fa-fw"></i>
		                            </a>
		                            <!-- Dropdown - Messages -->
		                            <div class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in"
		                                aria-labelledby="searchDropdown">
		                                <form class="form-inline mr-auto w-100 navbar-search">
		                                    <div class="input-group">
		                                        <input type="text" class="form-control bg-light border-0 small"
		                                            placeholder="Search for..." aria-label="Search"
		                                            aria-describedby="basic-addon2">
		                                        <div class="input-group-append">
		                                            <button class="btn btn-primary" type="button">
		                                                <i class="fas fa-search fa-sm"></i>
		                                            </button>
		                                        </div>
		                                    </div>
		                                </form>
		                            </div>
		                        </li>
		
		                        <!-- Nav Item - Alerts -->
		                        <li class="nav-item dropdown no-arrow mx-1">
		                            <a class="nav-link dropdown-toggle" href="#" id="alertsDropdown" role="button"
		                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		                                <i class="fas fa-bell fa-fw"></i>
		                                <!-- Counter - Alerts -->
		                                <span class="badge badge-danger badge-counter">3+</span>
		                            </a>
		                            <!-- Dropdown - Alerts -->
		                            <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
		                                aria-labelledby="alertsDropdown">
		                                <h6 class="dropdown-header">
		                                    Alerts Center
		                                </h6>
		                                <a class="dropdown-item d-flex align-items-center" href="#">
		                                    <div class="mr-3">
		                                        <div class="icon-circle bg-primary">
		                                            <i class="fas fa-file-alt text-white"></i>
		                                        </div>
		                                    </div>
		                                    <div>
		                                        <div class="small text-gray-500">December 12, 2019</div>
		                                        <span class="font-weight-bold">A new monthly report is ready to download!</span>
		                                    </div>
		                                </a>
		                                <a class="dropdown-item d-flex align-items-center" href="#">
		                                    <div class="mr-3">
		                                        <div class="icon-circle bg-success">
		                                            <i class="fas fa-donate text-white"></i>
		                                        </div>
		                                    </div>
		                                    <div>
		                                        <div class="small text-gray-500">December 7, 2019</div>
		                                        $290.29 has been deposited into your account!
		                                    </div>
		                                </a>
		                                <a class="dropdown-item d-flex align-items-center" href="#">
		                                    <div class="mr-3">
		                                        <div class="icon-circle bg-warning">
		                                            <i class="fas fa-exclamation-triangle text-white"></i>
		                                        </div>
		                                    </div>
		                                    <div>
		                                        <div class="small text-gray-500">December 2, 2019</div>
		                                        Spending Alert: We've noticed unusually high spending for your account.
		                                    </div>
		                                </a>
		                                <a class="dropdown-item text-center small text-gray-500" href="#">Show All Alerts</a>
		                            </div>
		                        </li>
								
		                        <!-- 채팅 목록 -->
								<li class="nav-item dropdown no-arrow mx-1">
								    <a class="nav-link dropdown-toggle" href="#" id="messagesDropdown" role="button"
								       data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
								        <i class="fas fa-envelope fa-fw"></i>
								        <!-- Counter - Active Chats -->
								        <span class="badge badge-danger badge-counter" id="activeChatCount">${activeChatCount}</span> <!-- 현재 활성화 채팅 수 -->
								    </a>
								    <!-- Dropdown - Messages -->
								    <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
								         aria-labelledby="messagesDropdown">
								        <h6 class="dropdown-header">
								            Chat Center
								        </h6>
								        
								        <!-- AJAX로 가져온 활성화된 채팅 리스트가 여기에 동적으로 추가됩니다. -->
								        <div id="participantList">
								        
								        </div>
								
								        <a class="dropdown-item text-center small text-gray-500" href="#">View All Chats</a>
								    </div>
								</li>

							</c:when>
							<c:otherwise>
								
							</c:otherwise>
						</c:choose>

                        <!-- 채팅 모달 -->
						<div class="modal fade" id="chatModal" tabindex="-1" aria-labelledby="chatModalLabel" aria-hidden="true">
						    <div class="modal-dialog">
						        <div class="modal-content">
						            <div class="modal-header">
						                <!-- 동적으로 선택된 사용자 이름 렌더링 -->
						                <h5 class="modal-title" id="chatModalLabel">${chatPartnerName}님과의 채팅</h5>
						                <button type="button" class="btn-close" data-dismiss="modal" aria-label="Close"></button>
						            </div>
						            <div class="modal-body">
						                <!-- 채팅 메시지 영역 -->
						                <div id="chatMessages" style="height: 300px; overflow-y: auto; border: 1px solid #ddd; padding: 10px;">
						                    <!-- EL 표현식을 사용하여 채팅 메시지를 렌더링 -->
						                    <c:forEach var="message" items="${messages}">
						                        <div class="d-flex mb-3">
						                            <!-- 메시지 보낸 사람이 현재 로그인한 유저인지 확인 -->
						                            <c:choose>
						                                <c:when test="${message.senderId == currentUserId}">
						                                    <!-- 본인이 보낸 메시지 -->
						                                    <div class="bg-primary text-white p-2 rounded" style="max-width: 70%; margin-left: auto;">
						                                        <p class="mb-0">${message.content}</p>
						                                        <small class="text-muted">You · ${message.timestamp}</small>
						                                    </div>
						                                </c:when>
						                                <c:otherwise>
						                                    <!-- 상대방이 보낸 메시지 -->
						                                    <div class="d-flex mb-3">
						                                        <div class="mr-2">
						                                            <img class="rounded-circle" src="${message.profileImg}" alt="${message.senderName}" style="width: 40px;">
						                                        </div>
						                                        <div class="bg-light p-2 rounded" style="max-width: 70%;">
						                                            <p class="mb-0">${message.content}</p>
						                                            <small class="text-muted">${message.senderName} · ${message.timestamp}</small>
						                                        </div>
						                                    </div>
						                                </c:otherwise>
						                            </c:choose>
						                        </div>
						                    </c:forEach>
						                </div>
						                <!-- 입력 영역 -->
						                <div class="input-group mt-3">
						                    <input type="text" class="form-control" id="messageInput" placeholder="메시지를 입력하세요..." />
						                    <button id="sendMessageButton" class="btn btn-primary" type="button">Send</button>
						                </div>
						            </div>
						        </div>
						    </div>
						</div>




                        <div class="topbar-divider d-none d-sm-block"></div>

                        <!-- Nav Item - User Information -->
                        
                        <c:choose>
                        	<c:when test="${not empty loginUser}">
		                        <li class="nav-item dropdown no-arrow">
		                            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
		                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		                                <span class="mr-2 d-none d-lg-inline text-gray-600 small">${ loginUser.userName }</span>
		                                <img class="img-profile rounded-circle" src="${ loginUser.profilePic }" />
		                            </a>
		                            <!-- Dropdown - User Information -->
		                            <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
		                                aria-labelledby="userDropdown">
		                                <a class="dropdown-item" onclick="changePicture();">
		                                    <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
											profile
		                                </a>
		                                <a class="dropdown-item" href="mypage.me">
		                                    <i class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i>
		                                    My Page
		                                </a>
		                                <a class="dropdown-item" href="#">
		                                    <i class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i>
		                                    Activity Log
		                                </a>
		                                <div class="dropdown-divider"></div>
		                                <a class="dropdown-item" href="logout.me" data-toggle="modal" data-target="#logoutModal">
		                                    <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
		                                    Logout
		                                </a>
		                            </div>
		                        </li>
	                        </c:when>
	                        <c:otherwise>
	                        	 <li class="nav-item dropdown no-arrow">
		                            <a class="nav-link" href="loginform.me" id="userDropdown" role="button">
		                                <span class="mr-2 d-none d-lg-inline text-gray-600 small">로그인을 해주세요</span>
		                            </a>
		                        </li>
	                        </c:otherwise>
                        </c:choose>

                    </ul>

                </nav>
                <!-- End of Topbar -->
                
                 <!-- Logout Modal-->
			    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
			        aria-hidden="true">
			        <div class="modal-dialog" role="document">
			            <div class="modal-content">
			                <div class="modal-header">
			                    <h5 class="modal-title" id="exampleModalLabel">로그아웃 하시겠습니까?</h5>
			                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
			                        <span aria-hidden="true">×</span>
			                    </button>
			                </div>
			                <div class="modal-body">로그아웃을 하려면 로그아웃 버튼을 눌러주세요</div>
			                <div class="modal-footer">
			                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
			                    <a class="btn btn-primary" href="logout.me">Logout</a>
			                </div>
			            </div>
			        </div>
			    </div>
			    
			    <!-- 사진변경 모달 -->
			     <div class="modal fade" id="changePictureModal" tabindex="-1" role="dialog" aria-labelledby="changePictureModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="changePictureModalLabel">사진 변경</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <form id="changePictureForm" action="changePicture.me" method="post" enctype="multipart/form-data">
                                    <div id="productImages"></div>
                                    <div class='d-flex justify-content-center'>
	                                    <div class="btn-group">
		                                    <label class="btn btn-warning mb-0" for="input-files" >
		                                        사진 업로드
		                                    </label>
		                                    <input class="btn btn-info" type="file" id="input-files" name="upfile" accept="image/*" style="display: none;" required>
		                                    <input type="hidden" id="userNo" name="userNo" value="${loginUser.userNo}">
		                                    <input type="hidden" id="userId" name="userId" value="${loginUser.userId}">
		                                    <input type="hidden" id="profilePic" name="profilePic" value="${loginUser.profilePic}">
		                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		                                    <button type="submit" class="btn btn-primary">사진 변경</button>
	                                    </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
	<script>
	    // 현재 시간을 가져오는 함수
	    var getCurrentTime = function() {
		    var now = new Date();
		    var year = now.getFullYear();
		    var month = ('0' + (now.getMonth() + 1)).slice(-2); // 월은 0부터 시작하므로 +1
		    var day = ('0' + now.getDate()).slice(-2);
		    var hours = ('0' + now.getHours()).slice(-2);
		    var minutes = ('0' + now.getMinutes()).slice(-2);
		    
		    return year + '-' + month + '-' + day + ' ' + hours + ':' + minutes;
		};
		
	    
	 	// 변수 선언
	    var userNo = ${sessionScope.loginUser.userNo}; // 세션에서 가져온 사용자 번호
	    var userLevel = ${sessionScope.loginUser.userLevel}; // 세션에서 가져온 사용자 레벨
	    var currentUserNo = userNo; // 현재 로그인한 유저 NO
	    var selectedUserNo; // 상대방 유저 NO
	    var chNo; // 채팅방 번호
	    
	 	// 드롭다운 아이템 클릭 시 : 이거로 채팅창 내역을 긁어올 예정!
	    $(document).on('click', '.dropdown-item', function() {
	        selectedUserNo = $(this).data('user-no'); // 상대방 유저 NO
	        chNo = $(this).data('chat-room-no'); // 채팅방 NO
	        console.log("선택된 유저 NO:", selectedUserNo); // 디버깅용
	        console.log("선택된 채팅방 NO:", chNo); // 디버깅용
	        
	     // AJAX 요청
	        $.ajax({
	            url: '/fitguardians/chat/messages/' + chNo, // 메시지를 가져오는 API 엔드포인트
	            method: 'GET',
	            data: {
	                senderNo: currentUserNo, // 현재 로그인한 유저 NO
	                receiverNo: selectedUserNo, // 상대방 유저 NO
	            },
	            success: function(response) {
	                console.log("AJAX 응답:", response); // 응답 내용 확인
	                if (response && response.length > 0) {
	                    updateChatMessages(response); // 메시지 업데이트 함수 호출
	                } else {
	                    console.warn("응답이 비어 있습니다."); // 경고 메시지 출력
	                }
	            },
	            error: function(xhr, status, error) {
	                console.error("메시지 로드 오류:", error);
	            }
	        });
	        
	    });
	    
	 	
	    // 채팅 메시지를 업데이트하는 함수
	    function updateChatMessages(messages) {
	        var chatMessagesContainer = $('#chatMessages');
	        chatMessagesContainer.empty(); // 기존 메시지 삭제

	        // 메시지 렌더링
	        messages.forEach(function(message) {
	            var messageElement;
	         	// sendDate를 포맷팅
	            var formattedDate = message.sendDate;

	            if (message.senderNo == currentUserNo) {
	                // 본인이 보낸 메시지
	                messageElement = '<div class="d-flex mb-3">' +
	                                 '<div class="bg-primary text-white p-2 rounded" style="max-width: 70%; margin-left: auto;">' +
	                                 '<p class="mb-0">' + message.msgContent + '</p>' +
	                                 '<small class="text-muted">You · ' + formattedDate + '</small>' +
	                                 '</div></div>';
	            } else {
	                // 상대방이 보낸 메시지
	                messageElement = '<div class="d-flex mb-3">' +
	                                 '<div class="mr-2">' +
	                                 '<img class="rounded-circle" src="' + message.profileImg + '" alt="' + message.senderName + '" style="width: 40px;">' +
	                                 '</div>' +
	                                 '<div class="bg-light p-2 rounded" style="max-width: 70%;">' +
	                                 '<p class="mb-0">' + message.msgContent + '</p>' +
	                                 '<small class="text-muted">' + message.senderName + ' · ' + formattedDate + '</small>' +
	                                 '</div></div>';
	            }

	            chatMessagesContainer.append(messageElement); // 메시지를 컨테이너에 추가
	        });
	    }

	    
	    
	
	    // 메시지 전송 함수
	    function sendMessage() {
	    	
	    	console.log('sendMessage 함수 호출됨'); // 함수 호출 확인
	    	
	        // 입력 필드에서 메시지 가져오기
	        var messageContent = $('#messageInput').val();
	        console.log('입력된 메시지:', messageContent); // 로그 출력
	
	        // 메시지가 비어있지 않은 경우에만 진행
	        if (messageContent.trim() !== "") {
	        	
	        	// 전송할 데이터 확인을 위해 console.log 추가
	            var messageData = {
	                content: messageContent,
	                senderNo: currentUserNo,  // 현재 로그인한 유저 No
	                receiverNo: selectedUserNo,  // 상대방 유저 No
	                chNo: chNo  // 채팅방 번호
	            };
	            console.log('전송할 메시지 데이터:', JSON.stringify(messageData)); // 여기서 데이터 로그 출력
	        		        	
	            // 메시지 전송을 위한 AJAX 요청
	            $.ajax({
	                url: '/fitguardians/chat/send', // 메시지 전송 엔드포인트
	                method: 'POST',
	                contentType: 'application/json',
	                data: JSON.stringify({
	                	msgContent: messageContent,
	                    senderNo: currentUserNo,  // 현재 로그인한 유저 No
	                    receiverNo: selectedUserNo,  // 상대방 유저 No
	                    chNo: chNo  // 채팅방 번호
	                }),
	                success: function(response) {
	                    // 메시지 전송 성공 시, 메시지 추가
	                    var newMessage = '<div class="d-flex justify-content-end mb-3">' +
	                        '<div class="bg-primary text-white p-2 rounded" style="max-width: 70%;">' +
	                            '<p class="mb-0">' + messageContent + '</p>' +
	                            '<small class="text-muted">당신 ·' + getCurrentTime() + '</small>' +
	                        '</div>' +
	                    '</div>';
	                    $('#chatMessages').append(newMessage);
	                    // 입력 필드 비우기
	                    $('.input-group input[type="text"]').val('');
	                    // 스크롤을 가장 아래로 내리기
	                    $('#chatMessages').scrollTop($('#chatMessages')[0].scrollHeight);
	                },
	                error: function(xhr, status, error) {
	                    console.error('메시지를 전송하는 중 오류 발생:', error);
	                }
	            });
	        } else {
	            console.log('메시지를 입력하세요.'); // 메시지 비어있을 경우 콘솔에 로그 출력
	        }
	    }
	
	    $(function() {
	        
	
	        // 활성화 채팅 수 가져오기
	        $.ajax({
	            url: '/fitguardians/chat/activeChatCount/' + userNo,
	            type: 'GET',
	            success: function(activeChatCount) {
	                // 활성화 채팅 수 업데이트
	                $('#activeChatCount').text(activeChatCount);
	            },
	            error: function(xhr, status, error) {
	                console.error('활성화 채팅 수를 가져오는 중 오류 발생:', error);
	            }
	        });
	
	        if (userLevel === 2) { // 유저인 경우
	            // 활성화된 채팅 참가자 가져오기 (회원 기준)
	            $.ajax({
	                url: '/fitguardians/chat/activeParticipants/user/' + userNo,
	                type: 'GET',
	                success: function(activeParticipants) {
	                    console.log(activeParticipants); // AJAX로 받은 데이터 확인
	
	                    // 활성화된 참가자가 있는지 확인
	                    if (activeParticipants.length > 0) {
	                        console.log("첫 번째 참가자:", activeParticipants[0]);
	                    } else {
	                        console.log("활성화된 참가자가 없습니다."); // 데이터가 없을 경우 메시지 출력
	                        $('#participantList').append('<div class="dropdown-item text-center small text-gray-500">활성화된 채팅이 없습니다.</div>');
	                        return; // 더 이상 진행하지 않도록 return
	                    }
	
	                    var participantList = $('#participantList'); // 변수 이름 변경
	                    participantList.empty(); // 기존 내용 비우기
	
	                    let items = ''; // 초기화
	
	                    activeParticipants.forEach(participant => {
	                        console.log("참가자 이미지:", participant.participantImage);
	                        console.log("마지막 메시지:", participant.lastMessage);
	                        console.log("참가자 이름:", participant.participantName);
	                        console.log("마지막 활동:", participant.lastActive);
	                        console.log("상태:", participant.participantStatus);
	                        
	                        const image = participant.participantImage || 'default-image.png';
	                        const lastMessage = participant.lastMessage || '메시지가 없습니다.';
	                        const participantName = participant.participantName || '참가자 없음';
	                        const lastActive = participant.lastActive || '활동 없음';
	                        const statusClass = participant.participantStatus === 'Y' ? 'bg-success' : 'bg-danger';
	
	                        // 문자열 연결 방식으로 아이템 생성
	                        items += '<a class="dropdown-item d-flex align-items-center" href="#" data-toggle="modal" data-target="#chatModal" data-user-no="' + participant.participantNo + '" data-chat-room-no="' + participant.chatRoomNo + '">' +
	                                    '<div class="dropdown-list-image mr-3">' +
	                                        '<img class="rounded-circle" src="' + image + '" alt="...">' +
	                                        '<div class="status-indicator ' + statusClass + '"></div>' +
	                                    '</div>' +
	                                    '<div class="font-weight-bold">' +
	                                        '<div class="text-truncate">' + lastMessage + '</div>' +
	                                        '<div class="small text-gray-500">' + participantName + ' · ' + lastActive + '</div>' +
	                                    '</div>' +
	                                '</a>';
	                    });
	
	                    // 최종 items 확인
	                    console.log("최종 아이템 HTML:", items);
	                    participantList.append(items); // 요소 추가
	                },
	                error: function(xhr, status, error) {
	                    console.error('회원용 활성화된 참가자를 가져오는 중 오류 발생:', error); // 에러 메시지 출력
	                }
	            });
	        } else if (userLevel === 1) { // 트레이너인 경우
	            // 활성화된 채팅 참가자 가져오기 (트레이너 기준)
	            $.ajax({
	                url: '/fitguardians/chat/activeParticipants/trainer/' + userNo,
	                type: 'GET',
	                success: function(activeParticipants) {
	                    console.log(activeParticipants); // AJAX로 받은 데이터 확인
	
	                    // 활성화된 참가자가 있는지 확인
	                    if (activeParticipants.length > 0) {
	                        console.log("첫 번째 참가자:", activeParticipants[0]);
	                    } else {
	                        console.log("활성화된 참가자가 없습니다."); // 데이터가 없을 경우 메시지 출력
	                        $('#participantList').append('<div class="dropdown-item text-center small text-gray-500">활성화된 채팅이 없습니다.</div>');
	                        return; // 더 이상 진행하지 않도록 return
	                    }
	
	                    var participantList = $('#participantList'); // 변수 이름 변경
	                    participantList.empty(); // 기존 내용 비우기
	
	                    let items = ''; // 초기화
	
	                    activeParticipants.forEach(participant => {
	                        console.log("참가자 이미지:", participant.participantImage);
	                        console.log("마지막 메시지:", participant.lastMessage);
	                        console.log("참가자 이름:", participant.participantName);
	                        console.log("마지막 활동:", participant.lastActive);
	                        console.log("상태:", participant.participantStatus);
	                        
	                        const image = participant.participantImage || 'default-image.png';
	                        const lastMessage = participant.lastMessage || '메시지가 없습니다.';
	                        const participantName = participant.participantName || '참가자 없음';
	                        const lastActive = participant.lastActive || '활동 없음';
	                        const statusClass = participant.participantStatus === 'Y' ? 'bg-success' : 'bg-danger';
	
	                        // 문자열 연결 방식으로 아이템 생성
	                        items += '<a class="dropdown-item d-flex align-items-center" href="#" data-toggle="modal" data-target="#chatModal" data-user-no="' + participant.participantNo + '" data-chat-room-no="' + participant.chatRoomNo + '">' +
	                                    '<div class="dropdown-list-image mr-3">' +
	                                        '<img class="rounded-circle" src="' + image + '" alt="...">' +
	                                        '<div class="status-indicator ' + statusClass + '"></div>' +
	                                    '</div>' +
	                                    '<div class="font-weight-bold">' +
	                                        '<div class="text-truncate">' + lastMessage + '</div>' +
	                                        '<div class="small text-gray-500">' + participantName + ' · ' + lastActive + '</div>' +
	                                    '</div>' +
	                                '</a>';
	                    });
	
	                    // 최종 items 확인
	                    console.log("최종 아이템 HTML:", items);
	                    participantList.append(items); // 요소 추가
	                },
	                error: function(xhr, status, error) {
	                    console.error('트레이너용 활성화된 참가자를 가져오는 중 오류 발생:', error); // 에러 메시지 출력
	                }
	            });
	        }
	
	        	
	        // '전송' 버튼 클릭 시 메시지 전송
	        $('#sendMessageButton').on('click', function() {
	        	console.log('전송 버튼 클릭됨'); // 클릭 확인
	            sendMessage();
	        });
	
	        // Enter 키를 눌렀을 때 메시지 전송
	        $('.input-group input[type="text"]').on('keypress', function(event) {
	            if (event.which === 13) { // Enter 키 코드
	                sendMessage();
	                event.preventDefault(); // Enter 키로 인해 폼이 제출되는 것을 방지
	            }
	        });
	        
	        
	        
	    });
	    
	 	// 사진 변경
        function changePicture(){
            // 모달 띄우기
            $('#changePictureModal').modal('show');
		}
	 	
	 	$(function (){
	 	// 파일 미리보기
	 	    $("#input-file").change(function (event) {
	 	        var reader = new FileReader();

	 	        reader.onload = function (event) {
	 	            var img = $("#productImage img");

	 	            if(img.length === 0){
	 	                var img = $("<img>");
	 	                $("#productImage").append(img);
	 	            }
	 	            img.attr("src", event.target.result);
	 	        };
	 	        reader.readAsDataURL(event.target.files[0]);
	 	        console.log(event);
	 	    });

	 	    $("#input-files").change(function (event) {
	 	        var reader = new FileReader();

	 	        reader.onload = function (event) {
	 	            var img = $("#productImages img");

	 	            if(img.length === 0){
	 	                var img = $("<img>");
	 	                $("#productImages").append(img);
	 	            }
	 	            img.attr("src", event.target.result);
	 	        };
	 	        reader.readAsDataURL(event.target.files[0]);
	 	        console.log(event);
	 	    });
	 	    
	 	    // 태그가 추가되면 이벤트 발생
	 	    $("#tag").on('change', function() {
	 	        console.log(tagify.detail.value);
	 	    });

	 	    $(".openTag").click(function(){
	 	        $(".detailCategory").css("display", "block");
	 	        $(this).css("display", "none")
	 	    });

	 	})
	</script>


</body>
</html>