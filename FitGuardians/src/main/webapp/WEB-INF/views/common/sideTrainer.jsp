 <%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Trainer's SideBar</title>
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
    <style>
      .mealpage:hover {
        cursor: pointer;
      }

      .mealpagediv {
        display: none;
        background-color: white;
        width: 185px;
        height: 105px;
        border-radius: 10px;
        padding-top: 10px;
        margin-top: 5px;
      }

      .astylediv {
        width: 150px;
        height: 30px;
        margin-left: 20px;
        border-radius: 3px;
      }
      .astylediv:hover {
        background-color: rgb(221, 221, 221);
      }
      .astylediv a {
        text-decoration: none;
        color: rgb(58, 59, 69);
        font-size: 13.6px;
        padding-left: 10px;
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
        href="traineeList.me"
      >
        <div class="sidebar-brand-icon rotate-n-15">
          <i class="fas fa-laugh-wink"></i>
        </div>
        <div class="sidebar-brand-text mx-3">trainer</div>
      </a>

      <!-- Divider -->
      <hr class="sidebar-divider my-0" />

      <!-- Nav Item - Dashboard -->
      <li class="nav-item active">
        <a class="nav-link" href="qrForm.me">
          <i class="fas fa-fw fa-tachometer-alt"></i> <span>출석체크</span>
        </a>
      </li>

      <!-- Divider -->
      <hr class="sidebar-divider" />

      <!-- Heading -->
      <div class="sidebar-heading">회원관리</div>

      <!-- Nav Item - Pages Collapse Menu -->
      <li class="nav-item">
        <a
          class="nav-link collapsed"
          href="traineeList.me"
          aria-expanded="true"
          aria-controls="collapseTwo"
        >
          <i class="fas fa-fw fa-cog"></i>
          <span>내 회원 정보</span>
        </a>
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
            <a class="collapse-item" href="calendar.tr">내 스케줄 설정</a>
            <a class="collapse-item" href="calendar.pt">회원 스케줄 설정</a>
          </div>
        </div>
      </li>

      <!-- Divider -->
      <hr class="sidebar-divider" />

      <!-- Heading -->
      <div class="sidebar-heading">프로그램 관리</div>

      <!-- Nav Item - Charts -->
      <li class="nav-item">
        <a class="nav-link" href="exercise.bo">
          <i class="fas fa-fw fa-chart-area"></i> <span>운동 프로그램</span>
        </a>
      </li>

      <!-- Nav Item - Tables -->
      <li class="nav-item">
        <div class="nav-link">
          <i class="fas fa-fw fa-table mealpage"></i>
          <span class="mealpage">식단 프로그램</span>
          <div class="collapse-item mealpagediv">
            <div class="astylediv">
              <a class="collapse-item" href="trainermealplan.bo">식단 보내기</a>
            </div>
            <div class="astylediv">
              <a class="collapse-item" href="trainerMealPlanList.bo"
                >보낸 식단 확인</a
              >
            </div>
            <div class="astylediv">
              <a class="collapse-item" href="trainergetMealPlanList.bo"
                >받은 식단 확인</a
              >
            </div>
          </div>
        </div>
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
        if ($(".mealpagediv").css("display") === "block") {
          $(".mealpagediv").slideUp();
        } else {
          $(".mealpagediv").slideDown();
        }
      });
    </script>
    <!-- End of Sidebar -->
  </body>
</html>
