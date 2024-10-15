<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Fit Guardians</title>
<!-- Custom fonts for this template-->
    <link
      href="./resources/templates/vendor/fontawesome-free/css/all.min.css"
      rel="stylesheet"
      type="text/css"
    />
    <link
      href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
      rel="stylesheet"
    />

    <!-- Custom styles for this template-->
    <link href="./resources/templates/css/sb-admin-2.css" rel="stylesheet" />

    <!-- Bootstrap core JavaScript-->
    <script src="./resources/templates/vendor/jquery/jquery.min.js"></script>
    <script src="./resources/templates/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script
      defer
      src="./resources/templates/vendor/jquery-easing/jquery.easing.min.js"
    ></script>

    <!-- Custom scripts for all pages-->
    <script defer src="./resources/templates/js/sb-admin-2.js"></script>

    <!-- Page level plugins -->
    <script src="./resources/templates/vendor/chart.js/Chart.min.js"></script>
    
    <style>
    img{
    width:100%;
    height:100%;
    cursor:pointer;
    }
    
    div
    
    </style>

</head>
<body>
Main

<jsp:include page="common/topBar.jsp" />

	<img src="./resources/images/main.gif" alt="메인화면" />
	
	<script>
	$("img").click(()=>{
		window.location.href="loginform.me";
	})
	</script>


</body>
</html>