<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<meta http-equiv="Cache-control" content="no-cache">
<title>Se Connecter - NTIC</title>
<link rel="icon" href="assets/img/Logo/logo.png">
<link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat:400,400i,700,700i,600,600i">
<link rel="stylesheet" href="assets/fonts/font-awesome.min.css">
<link rel="stylesheet" href="assets/fonts/simple-line-icons.min.css">
<link rel="stylesheet" href="assets/css/style.css">
</head>

<body>
	<jsp:include page="shared/header.jsp"></jsp:include>
	<main class="page login-page">
	<section class="clean-block clean-form dark">
		<div class="container">
			<div class="block-heading">
				<h2 class="text-success">Se Connecter</h2>
				<p>Connectez vous a votre compte NTIC afin d'acceder au fonctionalités du site.</p>
			</div>
			<form  onsubmit="return (typeof submitted == 'undefined') ? (submitted = true) : !submitted"  class="form-special" method="post" action="Login">
				<c:if test="${not empty message}">
					<div class="alert alert-danger alert-dismissible fade show" role="alert">
						${message}
						<button type="button" class="close" data-dismiss="alert" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<c:remove var="isDone" />
					<c:remove var="message" />
				</c:if>
				<div class="form-group">
					<label for="email">Nom d'utilisateur</label>
					<input class="form-control item" type="text" id="username" name="username">
				</div>
				<div class="form-group">
					<label for="password">Mot de passe</label>
					<input class="form-control" type="password" id="password" name="password">
				</div>
				<div class="form-group">
					<div class="form-check">
						<input class="form-check-input" type="checkbox" name="keepLogged" id="checkbox">
						<label class="form-check-label" for="checkbox">Rester connecter</label>
					</div>
				</div>
				<button class="btn btn-outline-success btn-block" type="submit">Se Connecter</button>
			</form>
		</div>
	</section>
	</main>
	<jsp:include page="shared/footer.jsp"></jsp:include>
	<script src="assets/js/jquery.min.js"></script>
	<script src="assets/bootstrap/js/bootstrap.min.js"></script>
	<script src="assets/js/smoothproducts.min.js"></script>
	<script src="assets/js/theme.js"></script>
</body>

</html>