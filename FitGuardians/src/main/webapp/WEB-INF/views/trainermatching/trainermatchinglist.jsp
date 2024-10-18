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
 .test div{

 }
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
    left: 500px; /* 왼쪽에서부터 50px 떨어짐 */
    width: 50%;
    height: 50%;
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
 	border: 1px solid black;
 }
 .membershiplistdiv{
     display: flex; /* 플렉스 레이아웃 적용 */
    flex-direction: row;
 width:100%;
 height: 80%;

 }
 .membershiplistdiv div{
 width: 25%;
 height: 100%;
 }
 .buydiv{
 height: 20%
 }
 .selected {
    background-color: rgb(230,230,230);
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
			         		<div class="3pt ptcheck">pt3회권</div>
			         		<div class="5pt ptcheck">pt5회권</div>
			         		<div class="10p ptcheck">pt10회권</div>
			         		<div class="20p ptcheck">pt20회권</div>
		         		</div>
		         		<div class="buydiv">구매버튼 예정</div>
		         	</div>
		         	<script >
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
		         $('.buydiv').on('click', function() {
		             if (isSelected) {
		               
		                 window.open('shop.do', '_blank', 'width=800,height=600');
		             } else {
		                 alert("회원권을 선택해주세요");
		             }
		         });

		         	</script>
				        
				    
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
				             			<div style="width: 12%; height: 100%"> 

				             			<button class="ptchosebtn">회원권(pt)신청</button>
				             			
				           		
				             			</div>
				                		</div>			             		
				             		</div>
				             		</div>
				             	
				               </c:forEach>
				               
				               	
            <div id="pagingArea">
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