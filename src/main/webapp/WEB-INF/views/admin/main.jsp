<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>AirTnT ADMIN PAGE</title>

    <link rel="canonical" href="https://getbootstrap.com/docs/4.0/examples/sign-in/">

    <!-- Bootstrap core CSS -->
    <link href="../resources/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="../resources/css/signin.css" rel="stylesheet">
</head>
<body class="text-center">
    <form class="form-signin" name="f" action="admin/loginCheck" method="post">
      <img class="mb-4" src="https://getbootstrap.com/docs/4.0/assets/brand/bootstrap-solid.svg" alt="" width="72" height="72">
      <h1 class="h3 mb-3 font-weight-normal">AirTnT ADMIN PAGE</h1>
      <label for="inputEmail" class="sr-only">ID</label>
      <input type="text" id="id" name="id" class="form-control" placeholder="Id" autofocus required>
      <label for="inputPassword" class="sr-only">Password</label>
      <input type="password" id="passwd" name="passwd" class="form-control" placeholder="Password" required>
      <div class="checkbox mb-3">
      </div>
      <button class="btn btn-lg btn-primary btn-block" type="submit">Login</button>
      <p class="mt-5 mb-3 text-muted">&copy; 2021-07</p>
    </form>
</body>
</html>