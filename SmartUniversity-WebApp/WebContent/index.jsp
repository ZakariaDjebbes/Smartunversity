<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="shared/keepLogged.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>Home - Brand</title>
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
	<main class="page landing-page">
	<section class="clean-block clean-info dark">
		<div class="container">
			<div class="block-heading">
				<h2 class="text-success">Faculté des nouvelles téchnologies de l'information et de la communication</h2>
				<p>Gestionnaire d'absences destiné aux enseingants et aux etudiants.</p>
			</div>
			<div class="row align-items-center">
				<div class="col-md-6">
					<img class="img-thumbnail" src="assets/img/scenery/ntic_2.png">
				</div>
				<div class="col-md-6">
					<h3>Présentation de la faculté</h3>
					<div class="getting-started-info">
						<p>
							La Faculté des Nouvelles Technologies de l'Information et de la Communication (NTIC) a été crée par le Décret exécutif N° 11-401 du 3 Moharram 1433 correspondant au 28 novembre 2011 portant
							création de l'université de CONSTANTINE 2..<br>
						</p>
					</div>
					<a class="btn btn-outline-success btn-lg" role="button" href="login.jsp">Se connecter</a>
				</div>
			</div>
		</div>
	</section>
	<section class="clean-block about-us">
		<div class="container">
			<div class="block-heading">
				<h2 class="text-success">Nos Départements</h2>
				<p>La faculté NTIC regroupe trois départements</p>
			</div>
			<div class="row justify-content-center">
				<div class="col-sm-6 col-lg-4">
					<div class="card clean-card text-center">
						<div class="card-body info">
							<h4 class="card-title">Tronc Commun Mathématique et informatique (MI)</h4>
							<p class="card-text">
								<br>L’objectif du Tronc Commun Mathématiques/Informatique (MI) est de donner une formation de base commune pour toutes les Branches (formation du 2e cycle) qui sont: Systèmes
								d’Information (SI), Génie Logiciel (GL), Technologies de l’Information (TI), et Sciences de l’Informatique (SCI) et ne prépare pas spécifiquement à l’une d’elles. Pour cette raison, il lui a
								été donné le nom de Tronc Commun.
						</div>
					</div>
				</div>
				<div class="col-sm-6 col-lg-4">
					<div class="card clean-card text-center">
						<div class="card-body info">
							<h4 class="card-title">Informatique Fondamentale et ses Applications (IFA)</h4>
							<p class="card-text">
								<br>Le département d’Informatique Fondamentale et ses Applications (IFA) recouvre deux parcours (Licence/Master). Hormis, les deux années tronc commun qui sont gérés par le Département
								Mathématiques/Informatique (MI), le département IFA assure deux types de licences: licence SCience de l’Informatique (SCI) et licence Technologies de l’Information (TI). Il assure aussi e deux
								types de Master : Réseaux et Systèmes Distribués (RSD) et Sciences et Technologies de l’Information et de la Communication (STIC).
						</div>
					</div>
				</div>
				<div class="col-sm-6 col-lg-4">
					<div class="card clean-card text-center">
						<div class="card-body info">
							<h4 class="card-title">Technologies des Logiciels et des Systèmes d'information (TLSI)</h4>
							<p class="card-text">
								<br>Le département Technologies des Logiciels et des Systèmes d’Information (TLSI) recouvre deux parcours (Licence/Master). Hormis, les deux années tronc commun qui correspond au
								Mathématiques/Informatique (MI), nous avons deux types de licences, à savoir licence Génie Logiciel (GL), Systèmes d’Information et Technologies Web (SITW) et pour le master deux types aussi,
								à savoir master Génie Logiciel (GL) et master Systèmes d’Information et Technologies Web (SITW) (recherche et professionnel ). <br> <br> <br>
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<section class="clean-block slider dark">
		<div class="container">
			<div class="block-heading">
				<h2 class="text-success">La Faculté en Images</h2>
			</div>
			<div class="carousel slide" data-ride="carousel" data-interval="2500" id="carousel-1">
				<div class="carousel-inner" role="listbox">
					<div class="carousel-item active">
						<img class="w-100 d-block" src="assets/img/scenery/ntic_1.jpg" alt="Slide Image">
					</div>
					<div class="carousel-item">
						<img class="w-100 d-block" src="assets/img/scenery/ntic_3.png" alt="Slide Image">
					</div>
					<div class="carousel-item">
						<img class="w-100 d-block" src="assets/img/scenery/ntic_4.png" alt="Slide Image">
					</div>
				</div>
				<div>
					<a class="carousel-control-prev" href="#carousel-1" role="button" data-slide="prev"><span class="carousel-control-prev-icon"></span><span class="sr-only">Previous</span></a><a
						class="carousel-control-next" href="#carousel-1" role="button" data-slide="next"><span class="carousel-control-next-icon"></span><span class="sr-only">Next</span></a>
				</div>
				<ol class="carousel-indicators">
					<li data-target="#carousel-1" data-slide-to="0" class="active"></li>
					<li data-target="#carousel-1" data-slide-to="1"></li>
					<li data-target="#carousel-1" data-slide-to="2"></li>
				</ol>
			</div>
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