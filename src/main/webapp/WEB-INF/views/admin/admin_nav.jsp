<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="/docs/4.1/assets/img/favicons/favicon.ico">

    <title>airTnT admin</title>

    <link rel="canonical" href="https://getbootstrap.com/docs/4.1/examples/dashboard/">

    <!-- Bootstrap core CSS -->
    <link href="../resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="../resources/css/bootstrap.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="../resources/css/dashboard.css" rel="stylesheet">
  </head>

  <body>
  	<c:set var="isLogin" value="false"/>
	<c:if test="${not empty member_id && not empty member_name}"><c:set var="isLogin" value="true"/></c:if>
	
    <nav class="navbar navbar-dark fixed-top bg-dark flex-md-nowrap p-0 shadow">
      <a class="navbar-brand col-sm-3 col-md-2 mr-0" href="/admin/dashboard">airTnT ADMIN</a>
      <ul class="navbar-nav px-3">
        <li class="nav-item text-nowrap">
        	<a class="nav-link" href="">logout</a>
        </li>
      </ul>
    </nav>
    <br><br>

    <div class="container-fluid">
      <div class="row">
        <nav class="col-md-2 d-none d-md-block bg-light sidebar">
          <div class="sidebar-sticky">
            <ul class="nav flex-column">
              <li class="nav-item">
                <a class="nav-link active" href="/admin/dashboard">
                  <span data-feather="home"></span>
                  Dashboard
                </a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="/admin/member">
                  <span data-feather="users"></span>
                  Member
                </a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="#">
                  <span data-feather="bar-chart-2"></span>
                  Reports
                </a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="/admin/filter">
                  <span data-feather="filter"></span>
                  Room Filter
                </a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="/wishList">
                  <span data-feather="star"></span>
                  Wish-List
                </a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="/admin/guidelist">
                  <span data-feather="info"></span>
                  Guide Board
                </a>
              </li>
              <div style="position: fixed; bottom: 15; left: 15;">
                  	접속계정 : ${member_name}<br>
                  	접속 IP : ${member_ip}
              </div>
            </ul>
          </div>
        </nav>

      </div>
    </div>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script>window.jQuery || document.write('<script src="../../assets/js/vendor/jquery-slim.min.js"><\/script>')</script>
    <script src="../../assets/js/vendor/popper.min.js"></script>
    <script src="../../dist/js/bootstrap.min.js"></script>

    <!-- Icons -->
    <script src="https://unpkg.com/feather-icons/dist/feather.min.js"></script>
    <script>
      feather.replace()
    </script>

  </body>
</html>