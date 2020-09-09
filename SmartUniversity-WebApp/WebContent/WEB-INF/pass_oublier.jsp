<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<meta http-equiv="Cache-control" content="no-cache">
<title>Réinisialitation du mot de passe - NTIC</title>
<link rel="icon" href="assets/img/Logo/logo.png">
<link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat:400,400i,700,700i,600,600i">
<link rel="stylesheet" href="assets/fonts/font-awesome.min.css">
<link rel="stylesheet" href="assets/fonts/simple-line-icons.min.css">
<link rel="stylesheet" href="assets/css/style.css">
</head>

<body>
	<jsp:include page="../shared/header.jsp"></jsp:include>
	<main class="page login-page">
	<section class="clean-block clean-form dark">
		<div class="container">
			<div class="block-heading">
				<h2 class="text-success">Réinisialisation du mot de passe</h2>
				<p>Vous avez oublier votre mot de passe, suivez ces étapes pour la réinisialisation de votre mot de passe</p>
			</div>
			<div class="row">
				<div class="col">
					<form onsubmit="return (typeof submitted == 'undefined') ? (submitted = true) : !submitted" method="post" class="form-special">
						<div class="alert alert-danger" id="error-alert" role="alert"></div>
						<div class="alert alert-info" id="result-alert" role="alert"></div>					
						<div id="email-group">
							<div class="form-group">
								<div class="form-group text-center">
									<h6>Entrez l'addresse email de votre compte</h6>
								</div>
								<label for="email">Votre adresse email</label>
								<input class="form-control item" required type="email" id="email" name="email">
							</div>
							<button class="btn btn-outline-success btn-block request-btn" id="email-submit" type="button">
								<i class="fa fa-spinner fa-pulse" style="display:none"></i>
								Envoyer
							</button>
						</div>
						<div id="code-group">
							<div class="form-group text-center">
								<h6>Un code a été envoyer a cette addresse email</h6>
								<small>Le code ne sera plus valide si vous quittez cette page</small>
							</div>
							<div class="form-group">
								<label for="code">Code</label>
								<input class="form-control item" type="text" id="code" name="code">
							</div>
							<button class="btn btn-outline-success btn-block request-btn" id="code-submit" type="button">
								<i class="fa fa-spinner fa-pulse" style="display:none"></i>							
								Envoyer
							</button>
						</div>
						<div id="pass-group">
							<div class="form-group text-center">
								<h6>Entrez votre nouveau mot de passe</h6>
								<small>L'opération ne sera plus valide si vous quittez cette page</small>
							</div>
							<div class="form-group">
								<label for="pass">Mot de passe</label>
								<input class="form-control item" type="password" id="pass" name="pass">
							</div>
							<button class="btn btn-outline-success btn-block request-btn" id="pass-submit" type="button">
								<i class="fa fa-spinner fa-pulse" style="display:none"></i>
								Envoyer
							</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</section>
	</main>
	<jsp:include page="../shared/footer.jsp"></jsp:include>
	<script src="assets/js/jquery.min.js"></script>
	<script src="assets/bootstrap/js/bootstrap.min.js"></script>
	<script src="assets/js/smoothproducts.min.js"></script>
	<script src="assets/js/theme.js"></script>
	<script src="assets/js/pass-oublier.js"></script>
</body>

</html>