<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="shared/keepLogged.jsp"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>Se Connecter - NTIC</title>
<link rel="icon" href="assets/img/Logo/logo.png">
<link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat:400,400i,700,700i,600,600i">
<link rel="stylesheet" href="assets/fonts/font-awesome.min.css">
<link rel="stylesheet" href="assets/css/Data-Table.css">
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.15/css/dataTables.bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/baguettebox.js/1.10.0/baguetteBox.min.css">
<link rel="stylesheet" href="assets/css/Pretty-Search-Form.css">
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
			<form class="form-special" method="post" action="Login">
				<%
					if (session.getAttribute("message") != null)
					{
				%>
				<div class="alert alert-danger" role="alert">${message}</div>
				<%
					}
					session.removeAttribute("message");
				%>
				<div class="form-group">
					<label for="email">Nom d'utilisateur</label>
					<input class="form-control item" type="text" id="email" name="user">
				</div>
				<div class="form-group">
					<label for="password">Mot de passe</label>
					<input class="form-control" type="password" id="password" name="pass">
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
	<script src="https://cdn.datatables.net/1.10.15/js/jquery.dataTables.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/baguettebox.js/1.10.0/baguetteBox.min.js"></script>
	<script src="https://cdn.datatables.net/1.10.15/js/dataTables.bootstrap.min.js"></script>
	<script src="assets/js/smoothproducts.min.js"></script>
	<script src="assets/js/theme.js"></script>
	<script src="assets/js/Table-With-Search.js"></script>
</body>

</html>