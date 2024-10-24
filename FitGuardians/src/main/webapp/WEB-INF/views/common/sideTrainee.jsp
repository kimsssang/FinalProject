<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Trainee's SideBar</title>
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

    <!-- Page level custom scripts -->
    <script src="./resources/templates/js/demo/chart-area-demo.js"></script>
    <script src="./resources/templates/js/demo/chart-pie-demo.js"></script>

    <script
      type="text/javascript"
      src="//dapi.kakao.com/v2/maps/sdk.js?appkey=YOUR_APP_KEY&libraries=services,clusterer,drawing"
    ></script>
    <style>
      .mealpagea:hover {
        cursor: pointer;
        background-color: red;
      }
      .mealpage a {
        display: none;
      }
      .mealpage:hover{
      cursor: pointer;}

      .mealpagea {
        background-color: white;
      }
    </style>
  </head>
  <body id="page-top">
    <!-- Sidebar -->
    <ul
      class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion"
      id="accordionSidebar"
    >
      <!-- Sidebar - Brand -->
      <a
        class="sidebar-brand d-flex align-items-center justify-content-center"
        href="main.tn"
      >
        <div class="sidebar-brand-icon rotate-n-15">
          <i class="fas fa-laugh-wink"></i>
        </div>
        <div class="sidebar-brand-text mx-3">trainee</div>
      </a>

      <!-- Divider -->
      <hr class="sidebar-divider my-0" />

      <!-- Nav Item - Dashboard -->
      <li class="nav-item active">
        <a class="nav-link" href="main.tn">
          <i class="fas fa-fw fa-tachometer-alt"></i>
          <span>대시보드</span></a
        >
      </li>

      <!-- Divider -->
      <hr class="sidebar-divider" />

      <!-- Heading -->
      <div class="sidebar-heading">환경설정</div>

      <!-- Nav Item - Pages Collapse Menu -->
      <li class="nav-item">
        <a
          class="nav-link collapsed"
          href="trainermatching.bo"

        >
          <i class="fas  fa-user"></i>
          <span>트레이너 매칭</span>
        </a>

      </li>

      <!-- Nav Item - Utilities Collapse Menu -->

      <li class="nav-item">
        <a class="nav-link" href="mypage.me">
          <i class="fas fa-user"></i>
          <span>내정보 변경</span>
        </a>
      </li>

      <!-- Divider -->
      <hr class="sidebar-divider" />

      <!-- Heading -->
      <div class="sidebar-heading">내 기록</div>

      <!-- Nav Item - Pages Collapse Menu -->
      <li class="nav-item">
        <a
          class="nav-link collapsed"
          href="#"
          data-toggle="collapse"
          data-target="#collapsePages"
          aria-expanded="true"
          aria-controls="collapsePages"
        >
          <i class="fas fa-fw fa-folder"></i>
          <span>내 프로그램</span>
        </a>
        <div
          id="collapsePages"
          class="collapse"
          aria-labelledby="headingPages"
          data-parent="#accordionSidebar"
        >
          <div class="bg-white py-2 collapse-inner rounded">
            <a class="collapse-item" href="traineeExercisePlanner.tn"
              >운동 관리</a
            >
            <div class="collapse-item mealpage">
              식단관리
              <a
                class="collapse-item mealpagea"
               style="display: none;"
                href="traineesnedMealplan.bo"
                >식단 보내기</a
              >
              <a
                class="collapse-item mealpagea"
                 style="display: none;"
                href="traineesendMealPlanList.bo"
                >보낸 식단 확인</a
              >
              <a
                class="collapse-item mealpagea"
                style="display: none;"
                href="traineemealplan.bo"
                >받은 식단 확인</a
              >
            </div>
          </div>
        </div>
      </li>

      <!-- Nav Item - Utilities Collapse Menu -->
      <li class="nav-item">
        <a
          class="nav-link collapsed"
          href="#"
          data-toggle="collapse"
          data-target="#collapseUtilities"
          aria-expanded="true"
          aria-controls="collapseUtilities"
        >
        <i class="fas fa-user"></i> <span>스케줄러</span>
        </a>
        <div
          id="collapseUtilities"
          class="collapse"
          aria-labelledby="headingUtilities"
          data-parent="#accordionSidebar"
        >
          <div class="bg-white py-2 collapse-inner rounded">
            <a class="collapse-item" href="calendar.kt">내 스케줄 설정</a>
            <c:if test="${not empty loginUser.pt}">
            <a class="collapse-item" href="calendar.me">트레이너가 보내준 일정</a>
            </c:if>
          </div>
        </div>
      </li>

      <hr class="sidebar-divider" />
      <div class="sidebar-heading">헬스장</div>
      <li class="nav-item">
        <a class="nav-link" href="searchGym.ma">
          <i class="fas fa-map"></i>
          <span>헬스장 찾기</span></a
        >
      </li>

      <hr class="sidebar-divider" />

      <!-- Heading -->
      <div class="sidebar-heading">채팅</div>

      <!-- Nav Item - 1:1 Chat -->
      <li class="nav-item">
        <a class="nav-link" href="chatPage.cp">
          <i class="fas fa-comments"></i>
          <span>1:1 채팅</span>
        </a>
      </li>

      <!-- Divider -->
      <hr class="sidebar-divider d-none d-md-block" />

      <!-- Sidebar Toggler (Sidebar) -->
      <div class="text-center d-none d-md-inline">
        <button class="rounded-circle border-0" id="sidebarToggle"></button>
      </div>
    </ul>
    <script>
      $(".mealpage").on("click", function () {
        if ($(".mealpage a").css("display") === "block") {
          $(".mealpage a").slideUp();
        } else {
          $(".mealpage a").slideDown();
        }
      });
    </script>

    <!-- End of Sidebar -->
  </body>
</html>
