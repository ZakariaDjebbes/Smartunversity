<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>Acceuil - NTIC</title>
<link rel="icon" href="assets/img/Logo/logo.png">
<link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat:400,400i,700,700i,600,600i">
<link rel="stylesheet" href="assets/fonts/font-awesome.min.css">
<link rel="stylesheet" href="assets/fonts/simple-line-icons.min.css">
<link rel="stylesheet" href="assets/css/style.css">
<link rel="stylesheet" href="assets/device-mockup/device-mockups.min.css">
</head>

<body>
	<jsp:include page="shared/header.jsp"></jsp:include>
	<main class="page landing-page">
	<section class="clean-block clean-info">
		<div class="container">
			<div class="block-heading">
				<h2 class="text-success">Faculté des nouvelles technologies NTIC</h2>
				<p>Application de gestion d'absences</p>
			</div>
			<div class="row align-items-center">
				<div class="col-md-6">
					<img class="img-thumbnail" src="assets/img/scenery/ntic_2.png">
				</div>
				<div class="col-md-6">
					<h3>Présentation de l'application</h3>
					<div class="getting-started-info">
						<p>
							Ce site web est mit a la dispostion des étudiants et enseigants de la faculté des nouvelles technologies afin de les aider dans leurs gestion des absences, emplois du temps et des demandes de
							leurs departement.
							<br>
						</p>
						<a class="btn btn-outline-success btn-lg" role="button" href="login.jsp">Connectez-vous</a>
					</div>
				</div>
			</div>
		</div>
	</section>
	<section class="clean-block features dark">
		<div class="container">
			<div class="block-heading">
				<h2 class="text-success">Fonctionnalités de l'application</h2>
				<p>Différentes fonctionnalités proposer par cette application</p>
			</div>
			<div class="row justify-content-center">
				<div class="col-md-5 feature-box">
					<i class="icon-note icon"></i>
					<h4>Gestion des absences</h4>
					<p>Gère les absences et les justificatifs d'absences de chaque departement de la faculté.</p>
				</div>
				<div class="col-md-5 feature-box">
					<i class="icon-pencil icon"></i>
					<h4>Gestion des demandes</h4>
					<p>Gère les demandes des utilisateurs de l'application (Congé académique, séances supplémentaires...) de chaque département.</p>
				</div>
				<div class="col-md-5 feature-box">
					<i class="icon-list icon"></i>
					<h4>Gestion des séances</h4>
					<p>Gestion des séances de chaque département de la faculté.</p>
				</div>
				<div class="col-md-5 feature-box">
					<i class="icon-screen-smartphone icon"></i>
					<h4>Disponible sur mobile</h4>
					<p>L'application est également disponible sur mobile. (uniquement pour enseignants et etudiants).</p>
				</div>
				<div class="col-md-5 feature-box">
					<i class="icon-chart icon"></i>
					<h4>Calcul des statistiques</h4>
					<p>Affiche les statistiques des absences des différents departements, groupes, années et spécialités.</p>
				</div>
			</div>
		</div>
	</section>
	<section id="mobile" class="clean-block clean-info">
		<div class="container">
			<div class="block-heading">
				<h2 class="text-success">Téléchargez l'application mobile</h2>
				<p>Toutes les fonctionalités égalment sur mobile!</p>
			</div>
			<div class="row">
				<div class="col">
					<div class="device-wrapper">
						<div class="device" data-device="galaxyS5" data-orientation="portrait" data-color="white">
							<div class="screen" style="background-image: url('assets/img/scenery/mobile_app_login.png')">
							</div>
						</div>
					</div>
				</div>
				<div class="col-12 col-md-8 mt-5">
					<h5>
						<i class="icon-exclamation icon text-success"></i> L'application mobile est uniquement disponible pour:
					</h5>
					<ul>
						<li>Les enseignants</li>
						<li>Les etudiants</li>
					</ul>
					<h5>
						<i class="icon-settings icon text-success"></i> Toutes les fonctionalités sont disponibles:
					</h5>
					<p>Les fonctionalités disponible sur l'application web sont équivalentes a celles de l'application mobile!</p>
					<h5>
						<i class="icon-refresh icon text-success"></i> Synchronisation entre application web et mobile:
					</h5>
					<p>Les données sont totalement synchroniser entre mobile et web!.</p>
					<h5>
						<i class="fa fa-language icon text-success"></i> Disponible en Arabe
					</h5>
					<p>En plus du français et de l'anglais l'application mobile est également disponible en Arabe.</p>
					<div class="text-center mt-5">
						<a class="btn btn-outline-success" href="#">
							<i class="fa fa-android"></i>Télécharger
						</a>
						<p>
							<small class="text-muted">*Requiert android 6.0 ou plus</small>
						</p>
					</div>
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