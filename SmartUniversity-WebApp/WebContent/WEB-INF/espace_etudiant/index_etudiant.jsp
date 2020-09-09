<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>Acceuil - NTIC</title>
<base href="${pageContext.request.contextPath}/WebContent">
<link rel="icon" href="assets/img/Logo/logo.png">
<link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat:400,400i,700,700i,600,600i">
<link rel="stylesheet" href="assets/fonts/font-awesome.min.css">
<link rel="stylesheet" href="assets/fonts/simple-line-icons.min.css">
<link rel="stylesheet" href="assets/css/style.css">
</head>

<body>
	<jsp:include page="/WEB-INF/espace_etudiant/shared/header_etudiant.jsp"></jsp:include>
	<main class="page landing-page">
	<section class="clean-block clean-info dark">
		<div class="container">
			<div class="row">
				<div class="col">
					<div class="block-heading mb-5">
						<h3 class="text-info">${utilisateur.getNom()} ${utilisateur.getPrenom()}</h3>
						<p>Bienvenue dans votre espace ${utilisateur.getUser_type().getValue(0)}</p>
					</div>
					<div>
						<h4 class="text-success pb-3">Tâches en cours de traitement:</h4>
						<div class="alert alert-danger" role="alert">
							<span><strong>Vous avez 3 absences non justifié</strong></span>
						</div>
						<div class="alert alert-warning" role="alert">
							<span><strong>Une demande de congé académique est en attente.</strong></span>
						</div>
						<div class="alert alert-warning" role="alert">
							<span><strong>Vous avez 3 absences avec un justificatif non traiter</strong></span>
						</div>
						<div class="alert alert-success" role="alert">
							<h4 class="alert-heading">
								Rien a signlé!
								<br>
							</h4>
							<span><strong>Tout semble en ordre pour le moment!</strong>
							<br></span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<section class="clean-block features">
		<div class="container">
			<div class="block-heading">
				<h2 class="text-success">Fonctionalités disponibles</h2>
				<p>Depuis votre espace enseignant vous disposez des opérations suivantes.</p>
			</div>
			<div class="row justify-content-center">
				<div class="col-md-5 feature-box">
					<i class="fa fa-calendar icon"></i>
					<h4>Consulter votre emploi du temps</h4>
					<p>Consultez votre emploi du temps a tout moment!</p>
				</div>
				<div class="col-md-5 feature-box">
					<i class="icon-eye icon"></i>
					<h4>Gérer vos absences</h4>
					<p>Consultez vos absences a tout moment, justifiez les et suivez leurs traitement.</p>
				</div>
				<div class="col-md-5 feature-box">
					<i class="icon-question icon"></i>
					<h4>Demander un congé académique</h4>
					<p>Demandez un congé académique pour l'année universitaire ici même.</p>
				</div>
				<div class="col-md-5 feature-box">
					<i class="icon-screen-smartphone icon"></i>
					<h4>Disponible sur mobile</h4>
					<p>Faites toutes vos opérations sur votre téléphone mobile!</p>
				</div>
			</div>
		</div>
	</section>
	</main>
	<jsp:include page="/WEB-INF/espace_etudiant/shared/footer_etudiant.jsp"></jsp:include>
	<script src="assets/js/jquery.min.js"></script>
	<script src="assets/bootstrap/js/bootstrap.min.js"></script>
	<script src="assets/js/smoothproducts.min.js"></script>
	<script src="assets/js/theme.js"></script>
</body>
</html>