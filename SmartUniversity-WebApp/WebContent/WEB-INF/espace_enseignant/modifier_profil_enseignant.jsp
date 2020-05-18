<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>Modifier votre Profil - NTIC</title>
<link rel="icon" href="assets/img/Logo/logo.png">
<link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat:400,400i,700,700i,600,600i">
<link rel="stylesheet" href="assets/fonts/font-awesome.min.css">
<link rel="stylesheet" href="assets/fonts/simple-line-icons.min.css">
<link rel="stylesheet" href="assets/css/Data-Table.css">
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.15/css/dataTables.bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/baguettebox.js/1.10.0/baguetteBox.min.css">
<link rel="stylesheet" href="assets/css/Pretty-Search-Form.css">
<link rel="stylesheet" href="assets/css/style.css">
</head>

<body>
	<jsp:include page="/WEB-INF/espace_enseignant/shared/header_enseignant.jsp"></jsp:include>
	<main class="page faq-page">
	<section class="clean-block clean-faq dark">
		<div class="container">
			<div class="row">
				<div class="col-12 col-lg-7">
					<div class="block-heading">
						<h2 class="text-success">
							<i class="fa fa-pencil"></i>Modification de votre profil
						</h2>
					</div>
					<form id="form_profil_enseignant" method="post" action="ModifierProfil">
						<c:if test="${not empty isDone && not empty message}">
							<c:choose>
								<c:when test="${isDone}">
									<div class="alert alert-success" role="alert">${message}</div>
								</c:when>
								<c:when test="${not isDone}">
									<div class="alert alert-danger" role="alert">${message}</div>
								</c:when>
							</c:choose>
							<c:remove var="isDone" />
							<c:remove var="message" />
						</c:if>
						<h3 class="text-success">Identifiants de connexion</h3>
						<div class="form-group">
							<label for="user">Nom d'utilisateur</label>
							<div class="input-group mb-3">
								<input id="user" name="user" type="text" class="form-control" readonly required value="${utilisateur.getUser()}">
								<div class="input-group-append">
									<button class="btn btn-outline-success" type="button" id="button-user">
										<i class="fa fa-pencil"></i>
									</button>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label for="pass">Mot de passe</label>
							<div class="input-group mb-3">
								<input id="pass" name="pass" type="password" class="form-control" readonly required value="${utilisateur.getPass()}">
								<div class="input-group-append">
									<button class="btn btn-outline-success" type="button" id="button-pass">
										<i class="fa fa-pencil"></i>
									</button>
								</div>
							</div>
						</div>
						<h3 class="text-success">Informations personnelles</h3>
						<div class="form-group">
							<label for="nom">Nom</label>
							<div class="input-group mb-3">
								<input id="nom" type="text" name="nom" class="form-control" readonly required value="${utilisateur.getNom()}">
								<div class="input-group-append">
									<button class="btn btn-outline-success" type="button" id="button-nom">
										<i class="fa fa-pencil"></i>
									</button>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label for="prenom">Prénom</label>
							<div class="input-group mb-3">
								<input id="prenom" type="text" name="prenom" class="form-control" readonly required value="${utilisateur.getPrenom()}">
								<div class="input-group-append">
									<button class="btn btn-outline-success" type="button" id="button-prenom">
										<i class="fa fa-pencil"></i>
									</button>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label for="adresse">Adresse</label>
							<div class="input-group mb-3">
								<input id="adresse" name="adresse" type="text" class="form-control" readonly required value="${utilisateur.getAdresse()}">
								<div class="input-group-append">
									<button class="btn btn-outline-success" type="button" id="button-adresse">
										<i class="fa fa-pencil"></i>
									</button>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label for="date_n">Date de naissance</label>
							<div class="input-group mb-3">
								<input id="date_n" name="date_n" type="Date" class="form-control" readonly required value="${utilisateur.getDate()}">
								<div class="input-group-append">
									<button class="btn btn-outline-success" type="button" id="button-date_n">
										<i class="fa fa-pencil"></i>
									</button>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label for="email">Email</label>
							<div class="input-group mb-3">
								<input id="email" name="email" type="email" class="form-control" readonly required value="${utilisateur.getEmail()}">
								<div class="input-group-append">
									<button class="btn btn-outline-success" type="button" id="button-email">
										<i class="fa fa-pencil"></i>
									</button>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label for="telephone">Numéro de téléphone</label>
							<div class="input-group mb-3">
								<input id="telephone" name="telephone" type="tel" class="form-control" readonly required value="${utilisateur.getTelephone()}">
								<div class="input-group-append">
									<button class="btn btn-outline-success" type="button" id="button-telephone">
										<i class="fa fa-pencil"></i>
									</button>
								</div>
							</div>
						</div>
						<h3 class="text-success">Autres</h3>
						<div class="form-group">
							<label for="departement">Département actuel</label>
							<div class="input-group mb-3">
								<input id="departement" type="text" class="form-control" readonly required value="${utilisateur.getCode_departement()}">
							</div>
						</div>
						<div class="form-group">
							<label for="grade">Votre grade</label>
							<div class="input-group mb-3">
								<input id="grade" type="text" class="form-control" readonly required value="${utilisateur.getGrade()}">
							</div>
						</div>
						<div class="form-group text-center">
							<input type="submit" class="btn btn-outline-success" value="Enregistrer les modifications">
						</div>
					</form>
				</div>
				<div class="col-12 col-lg-5">
					<div class="block-heading">
						<h2 class="text-success">
							<span class="text-danger"><i class="fa fa-close"></i>Supprimer</span>&nbsp;votre profil
						</h2>
					</div>
					<form class="text-center" action="SupprimerProfil" method="get">
						<h2>Êtes-vous sur de vouloir supprimer votre profil?</h2>
						<small class="d-block">La suppression du profil est <span class="text-danger">définitive</span>.&nbsp;
						</small>
						<button class="btn btn-outline-danger text-center" type="submit" style="margin: 30px 0px; padding: 6px 20px;">Supprimer mon profil</button>
					</form>
				</div>
			</div>
		</div>
	</section>
	</main>
	<jsp:include page="/WEB-INF/espace_enseignant/shared/footer_enseignant.jsp"></jsp:include>
	<script src="assets/js/jquery.min.js"></script>
	<script src="assets/bootstrap/js/bootstrap.min.js"></script>
	<script src="https://cdn.datatables.net/1.10.15/js/jquery.dataTables.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/baguettebox.js/1.10.0/baguetteBox.min.js"></script>
	<script src="https://cdn.datatables.net/1.10.15/js/dataTables.bootstrap.min.js"></script>
	<script src="assets/js/smoothproducts.min.js"></script>
	<script src="assets/js/theme.js"></script>
	<script src="assets/js/modifier_profil_buttonHandler.js"></script>
	<script src="assets/js/Table-With-Search.js"></script>
</body>

</html>