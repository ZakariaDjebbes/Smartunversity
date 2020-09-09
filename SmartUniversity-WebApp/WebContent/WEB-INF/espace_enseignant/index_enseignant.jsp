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
	<jsp:include page="/WEB-INF/espace_enseignant/shared/header_enseignant.jsp"></jsp:include>
	<main class="page landing-page">
	<section class="clean-block clean-info dark">
		<div class="container">
			<div class="row">
				<div class="col">
					<div class="block-heading">
						<h3 class="text-info">${utilisateur.getNom()} ${utilisateur.getPrenom()}</h3>
						<p>Bienvenue dans votre espace ${utilisateur.getUser_type().getValue(0)}</p>
					</div>
					<div>
						<div class="text-center">
						Vous êtes un enseignant dans le département <b>${utilisateur.getCode_departement().getValue(0)}-(${utilisateur.getCode_departement()})</b>.
						<br>
						<hr>
						Ce compte vous permet de gérer les absences de vos séances.
					</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<section class="clean-block features">
		<div class="container">
			<div class="block-heading">
				<h2 class="text-success">Les Fonctionalités Disponibles</h2>
				<p>Depuis votre espace enseignant vous disposez des opérations suivantes.</p>
			</div>
			<div class="row justify-content-center">
				<div class="col-md-5 feature-box">
					<i class="icon-settings icon"></i>
					<h4>Gérer les absences de vos groupes</h4>
					<p>Pour chaqu'un de vos groupes vous avez la possibilité de:</p>
					<ul class="text-muted">
						<li>Consulter les statistiques.</li>
						<li>Etablir la liste des étudiants exclus.</li>
						<li>Consulter les relvées d'absences.</li>
					</ul>
				</div>
				<div class="col-md-5 feature-box">
					<i class="icon-pencil icon"></i>
					<h4>Marquer la présence de vos étudiants</h4>
					<p>vous pouvez dynamiquement marquer la présence des étudiants présent dans votre séance.</p>
				</div>
				<div class="col-md-5 feature-box">
					<i class="fa fa-lg fa-refresh icon"></i>
					<h4>Demander des ajustements</h4>
					<p>Vous pourrez ici même faire vos demande au chef de votre département pour:</p>
					<ul class="text-muted">
						<li>Ajouter une séance supplémentaire.</li>
						<li>Modifier l'une de vos séances.</li>
					</ul>
				</div>
			</div>
		</div>
	</section>
	</main>
	<jsp:include page="/WEB-INF/espace_enseignant/shared/footer_enseignant.jsp"></jsp:include>
	<script src="assets/js/jquery.min.js"></script>
	<script src="assets/bootstrap/js/bootstrap.min.js"></script>
	<script src="assets/js/smoothproducts.min.js"></script>
	<script src="assets/js/theme.js"></script>
	<script src="assets/js/notifications_handler.js"></script>
</body>
</html>