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

</head>

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
                    여기다 본인의 컨텐츠 작성하면 됨!
    			</div>         
			</div>
		</div>
    </div>
</body>
</html>