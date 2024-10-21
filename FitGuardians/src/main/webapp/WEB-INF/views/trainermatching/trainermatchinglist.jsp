<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
 <style >

 .imgjon img{
 	width: 100%;
 	height: 100%
 }
 .datajon div{
 margin-right: 5px}
 .nulljon{
 	width: 3.3%;
 }
.topdiv{
    position: absolute; /* 절대 위치 설정 */
    top: 200px; /* 위에서부터 50px 내려옴 */
    left: 500px; 
    width: 50%;
    height: 180px;
    background-color: rgba(255, 255, 255, 1); 
    z-index: 4; /* z-index 설정 */
    display: none;
    }
 .backdiv{
  position: absolute; 
 	background-color: rgba(0,0,0,0.5);
 	width : 100%;
 	height: 100%;
 	z-index: 3;
 	display: none;
 	
 }
 .topdiv div{
 	
 }
 .membershiplistdiv{
     display: flex; /* 플렉스 레이아웃 적용 */
    flex-direction: row;
 width:100%;
 height: 100px;

    align-items: center;  /* 수직 중앙 정렬 */
      justify-content: space-between;

 }
 .membershiplistdiv div{
 border-radius: 10px;
 width: 20%;
 height: 80%;
 margin-left: 10px;
 margin-right: 10px;
border : 1px solid black;

     text-align: center;
     vertical-align: middle;
 }
 .buydiv{
 height: 20%;
     display: flex;
    align-items: center;  /* 수직 중앙 정렬 */
    justify-content: center;
    margin-top: 20px;
 }
 .selected {
    background-color: skyblue;
}

.btncssdiv{
    display: flex;
    align-items: center;  /* 수직 중앙 정렬 */
    justify-content: center; 
    margin-top: 20px;
}


 </style>
</head>
<body>
 <body id="page-top">
  <div id="wrapper">
					<div class="backdiv"></div>
        <jsp:include page="../common/sideTrainee.jsp" />
        <div id="content-wrapper" class="d-flex flex-column">
            <!-- Main Content -->
            <div id="content" >
                <jsp:include page="../common/topBar.jsp" />
	                <div class="card-header py-3">
		                <h6 class="m-0 font-weight-bold text-primary">
		               	트레이너 매칭
		                </h6>
	                
                	</div>
                	<!-- 
		                <div class="searchdiv" style="display: flex; justify-content: flex-end; align-items: center;">
		  				  검색 : <input type="text" class="searchinput form-control form-control-sm" style="width: 200px; height: 35px; margin-left: 10px; margin-right: 60px;" />
							<button type="button" class="searchbtn" >검색하기</button>
						</div>
                	 -->
                  <div class="row container-fluid">
              
		         	<div class="topdiv">
		         		<div class="membershiplistdiv">
			         		<div class="3pt ptcheck border-left-primary">pt3회권 <br> 15만원
			         			<input class="ptval" type="hidden" value="3"> 
			         		</div> 
			         		<div class="5pt ptcheck border-left-primary">pt5회권 <br> 20만원
			         		<input class="ptval" type="hidden" value="5"> </div>
			         		<div  class="10p ptcheck border-left-primary">pt10회권 <br> 35만원
			         		<input class="ptval" type="hidden" value="10"> </div>
			         		<div class="20p ptcheck border-left-primary">pt20회권 <br> 60만원
			         		<input class="ptval" type="hidden" value="20"> </div>
		         		</div>
		         		<div class="buydiv "> <button  class="buybtn  btn btn-primary btn-icon-split btn-lg" type="button">구매하기</button></div>
		         	</div>
		         	<script >
		         	
		         	function onReceivePaymentData(paymentData) {
		     
		         	    console.log("결제 완료 데이터:", paymentData);
		         		if(paymentData == "결제성공"){
		         		
		         			success();
		         		
		         		}else{
		         			fail();
		         		}
		         	    // 이곳에서 결제 데이터를 처리합니다.
		         	
		         	}
		         	function success(){
		         		successupdateajax();
		         	   $('topdiv').css('display','none');
		         		alert("결제가 성공적으로 완료되었습니다");
		         		location.reload();
		         	}
		         	function fail(){
			         	   $('topdiv').css('display','none');
			         		alert("결제가 실패했습니다 다시 시도해주세요");
			         		location.reload();
			         	}
		         	function successupdateajax(){
						console.log($('.newtrainerid').val());//선택 트레이너 아이디
						console.log($('.selected .ptval').val()); //선택한 pt 횟수
						$.ajax({
							url : 'membershippt.bo' ,
							  data: { pttime: $('.selected .ptval').val() , pt : $('.newtrainerid').val() },
							  success : function(date){
								 
							  },
							  error : function(date){
								  alert(date)
							  }
						})
		         	}
		         	let isSelected = false;

		         // .ptcheck 클릭 시 클래스 추가/제거로 선택 상태 업데이트
		         $('.ptcheck').on('click', function() {
		             // 모든 ptcheck 요소의 선택 클래스를 제거
		             $('.ptcheck').removeClass('selected');
		             
		             // 클릭된 요소에만 선택 클래스 추가
		             $(this).addClass('selected');
		          
		             // isSelected 상태 업데이트
		             isSelected = false; // 초기화
		             $('.ptcheck').each(function() {
		                 if ($(this).hasClass('selected')) {
		                     isSelected = true; // 하나라도 선택된 경우
		                 }
		             });
		         });
				
		         // .buydiv 클릭 시 동작
		         var loginUserid = "${loginUser.userId}"
		        	 if (loginUserid === "" || loginUserid === "null")
			  		 {}else{
			  			 
			  		 }
		         
		         
		         
		         $('.buybtn').on('click', function() {
		        	if(${ empty loginUser.userId})
		        		 var loginUserid = "${loginUser.userId}"
		        			 if (loginUserid === "" || loginUserid === "null"){
		        				 alert("로그인이 필요한 서비스입니다")
		        			 }else{
		        				 
		             if (isSelected) {
		               let num = ($('.selected .ptval').val());
		                 window.open('shop.do?orderpt='+ num, '_blank', 'width=800,height=600');
		                 
		             } else {
		                 alert("회원권을 선택해주세요");
		             }
		        			 }
		         });

		         	</script>
				        <div style="width: 100%">
				    		<h2 class="trname">비회원입니다</h2>
				    		<h2 class="pttime"></h2>
				    		<input type="hidden" class="pId">
				    		<br>
				        </div>
				             <c:forEach var="t" items="${list}" > 
				             <div class="col-lg-6">
				             <div class="card mb-4 py-3 border-left-primary test" style="height: 200px;   margin-top: 20px;">
				             		<div class="namecard" style="display: flex; width: 100%; height: 100%">
				             			<div  class="nulljon"></div>
				             			<div style="width: 18% ; height: 100%" class="imgjon" > 
				             				<c:choose>
				             				<c:when test="${ empty t.trProfile }">
				             				<img  alt="" src="resources/trProfilePic/defaultimg.PNG">
				             				</c:when>
				             				<c:otherwise>
				             				<img  alt="" src="resources/trProfilePic/${ t.trProfile }">
				             				</c:otherwise>
				             				</c:choose>
				             			 </div> 
				             			<div  class="nulljon"></div>
				             			<div style="width: 60%; height: 100%">
				             				<div class="namenone"><h5>${ t.userName }트레이너</h5></div>
				             				<div style="display: flex;" class="datajon">	
					             				<div class="agejon">나이 : ${ t.age }</div>
					                			<div class="genjon">성별 : <c:if test="${ t.gender == 'M' }">남자</c:if> <c:if test="${ t.gender == 'F' }">여자</c:if> </div>
					                			<div class="Careerjon">경력 : ${ t.trCareer }년 </div>
				             				</div>
				             				<c:choose>
				             					<c:when test="${ empty t.trCerti }"></c:when>
				             					<c:otherwise> <div>보유 자격증 : ${ t.trCerti }</div> </c:otherwise>
				             				</c:choose>
				             				<div><h4>트레이너의 한마디</h4></div>
				             				<div>
				             				<c:choose>
				             					<c:when test="${ empty t.trDescript }">트레이너의 한마디가 작성되지 않았습니다</c:when>
				             					<c:otherwise> <div> ${ t.trDescript }</div> </c:otherwise>
				             				</c:choose>
				             				</div>
				             			
				                		</div>
				             			<div class="btncssdiv" style="width: 12%; height: 100%"> 
											<input class="newtrainerid" type="hidden" value="${ t.userId }">
				             			<button style="" class="ptchosebtn btn btn-primary btn-icon-split btn-lg">회원권(pt)신청</button>
				             			
				           		
				             			</div>
				                		</div>			             		
				             		</div>
				             		</div>
				             	
				               </c:forEach>
				               
				               	
            <div id="pagingArea" style="width: 100%">
                <ul class="pagination">
                	
                	
	                    
	                    <c:choose>
	                    <c:when test="${pi.currentPage eq pi.startPage }">
	                    <li class="page-item disabled"><a class="page-link" href="">이전</a></li>
	                    </c:when>
	                      <c:otherwise>
					 <li class="page-item "><a class="page-link" href="trainermatching.bo?cpage=${ pi.currentPage -1 }">이전</a></li>
                    	</c:otherwise> 
                    	</c:choose>
                    	
                    	<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
                    	<li class="page-item"><a class="page-link" href="trainermatching.bo?cpage=${ p }">${ p }</a></li>
                    	</c:forEach>
               
	                    
	                     <c:choose>
	                    <c:when test="${pi.currentPage eq pi.maxPage }">
	                    <li class="page-item disabled"><a class="page-link" href="">다음</a></li>
	                 
	                      </c:when>
	                    
	                    <c:otherwise>
	                    <li class="page-item"><a class="page-link" href="trainermatching.bo?cpage=${ pi.currentPage +1}">다음</a></li>
	                    </c:otherwise>
	                    
	                    
	                    </c:choose>
                </ul>
            </div>

				       
			            
           		 	</div>
                
                
            </div>
                
        </div>
  </div>
  
				  		<script>
				  	  let loginUser = "${loginUser.userId}"

				  		 if (loginUser === "" || loginUser === "null")
				  		 {}else{
				  			
				  					//트레이너명과 pt횟수 표기
				  					$.ajax({
				  						url : 'trainermatchingsearch.bo',
				  					
				  						success : function(date){
				  						
				  								$('.tid').text(date.userId)
				  								$('.trname').text('현재 트레이너 '+date.pt)
				  								$('.pttime').text('남은 PT 횟수 : '+date.ptTime)
				  					
				  						},
				  						error : function(){
				  							console.log("실패?")
				  						}
				  					})
				  		
				  		}
				  		
				  		
							  		//pt신청 버튼 클릭시
							$('.ptchosebtn').on('click', function() {
							    $('.topdiv').fadeIn(500); // 0.5초 동안 천천히 나타남
							    $('.backdiv').fadeIn(500);
							    $('topdiv').css('display','flex');
							});
							
							$('.backdiv').on('click', function() {
							    $('.topdiv').fadeOut(500); // 0.5초 동안 천천히 사라짐
							    $('.backdiv').fadeOut(500);
							});
							  		//만약 검색기능까지 할 짬이 날 경우 사용할 예정
							  	/*	$('.searchbtn').on('click', function() {
							  		    $('.page-item a').each(function() {
							  		        console.log($(this).attr('href')); // 각 <a> 태그의 href 속성을 가져와 출력
							  		    });
							  		}); */
				  		</script>

</body>
</html>