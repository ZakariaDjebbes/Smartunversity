<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>Nous Contacter - NTIC</title>
<link rel="icon" href="assets/img/Logo/logo.png">
<link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat:400,400i,700,700i,600,600i">
<link rel="stylesheet" href="assets/fonts/font-awesome.min.css">
<link rel="stylesheet" href="assets/fonts/simple-line-icons.min.css">
<link rel="stylesheet" href="assets/css/style.css">
</head>

<body>
	<jsp:include page="shared/header.jsp"></jsp:include>
	<main class="page">
	<section class="clean-block clean-form dark">
		<div class="container">
			<div class="block-heading">
				<h1 class="text-success">Nous Contacter</h1>
			</div>
			<div class="row">
				<div class="col-12 col-md-6">
					<p class="text-center text-secondary">Formulaire de contact</p>
					<form  onsubmit="return (typeof submitted == 'undefined') ? (submitted = true) : !submitted" method="get" action="NousContacter" class="form-special">
						<c:if test="${not empty isDone}">	
							<c:if test="${isDone }">
							<div class="alert alert-success alert-dismissible fade show" role="alert">
								Votre message a été correctement envoyer.
							  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
							    <span aria-hidden="true">&times;</span>
							  </button>
							</div>
							</c:if>
							<c:if test="${not isDone }">
								<div class="alert alert-danger alert-dismissible fade show" role="alert">
								  Une erreur est survenue, le message n'a pas été envoyer.
								  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
								    <span aria-hidden="true">&times;</span>
								  </button>
								</div>
							</c:if>
							<c:remove var="isDone" />
						</c:if>
						<div class="form-group">
							<label>Nom</label>
							<input class="form-control" required name="nom" type="text" placeholder="Votre nom">
						</div>
						<div class="form-group">
							<label>Email</label>
							<input class="form-control" required name="email" type="text" placeholder="exmple@exemple.exp">
						</div>
						<div class="form-group">
							<label>Sujet</label>
							<input class="form-control" required name="sujet" type="text" placeholder="Le sujet de votre contact">
						</div>
						<div class="form-group">
							<label>Message</label>
							<textarea class="form-control" required name="message" placeholder="Donnez plus d'informations..."></textarea>
						</div>
						<div class="form-group">
							<button class="btn btn-outline-success btn-block" type="submit">Envoyer</button>
						</div>
					</form>
				</div>
				<div class="col-12 col-md-6 col-border-left col-border-top-sm">
					<p class="text-center text-secondary">Retrouvez nous sur goole Maps</p>
					<iframe allowfullscreen="" frameborder="0" width="100%" height="400"
						src="https://www.google.com/maps/embed/v1/place?key=AIzaSyBDYzmh4BZ7H_FLAYlfA0mTCnyoGOArtQk&amp;q=Universite+Constantine+2+Abdelhamid+Mehri&amp;zoom=14"></iframe>
					<ul class="list-unstyled text-secondary">
						<li class="text-left">
							<i class="fa fa-location-arrow fa-lg map-icon text-success"></i><span class="ml-2">Nouvelle Ville, Constantine, Algérie.</span>
						</li>
						<li>
							<i class="fa fa-phone fa-lg map-icon text-success"></i><span class="ml-2">0526653212</span>
						</li>
						<li>
							<i class="fa fa-envelope-o fa-lg map-icon text-success"></i><span class="ml-1">Zakaria.Djebbes@gmail.com</span>
						</li>
					</ul>
				</div>
			</div>
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