<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>Relevé d'absences - ${utilisateur.getNom()} ${utilisateur.getPrenom()}</title>
<base href="${pageContext.request.contextPath}/WebContent">
<link rel="icon" href="assets/img/Logo/logo.png">
<link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="assets/Datatables/datatables.min.css">
<link rel="stylesheet" href="assets/Datatables/custom-datatables.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat:400,400i,700,700i,600,600i">
<link rel="stylesheet" href="assets/fonts/font-awesome.min.css">
<link rel="stylesheet" href="assets/fonts/simple-line-icons.min.css">
<link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
	<jsp:include page="/WEB-INF/espace_etudiant/shared/header_etudiant.jsp"></jsp:include>
	<main class="page">
	<div class="clean-block clean-info dark">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="block-heading">
						<h2 class="text-success">Consulter une séance</h2>
						<p>Détails de la séance en plus du votre relevé d'absences pour cette séance.</p>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<div class="table-responsive">
						<h4 class="text-success">Détails de la séance</h4>
						<table class="table table-sm">
							<tbody>
								<tr>
									<th style="width: 30%">Module</th>
									<td>${seanceEtudiant.getModule().getNom()}-(${seanceEtudiant.getModule().getCode_module()})</td>
								</tr>
								<tr>
									<th>Type</th>
									<td>${seanceEtudiant.getSeance().getType().getValue(0)}-(${seanceEtudiant.getSeance().getType()})</td>
								</tr>
								<tr>
									<th>Année et spécialité</th>
									<td>${seanceEtudiant.getSeance().getAnnee().getValue(0)}-(${seanceEtudiant.getSeance().getAnnee()}),${seanceEtudiant.getSeance().getSpecialite().getValue(0)}-
										(${seanceEtudiant.getSeance().getSpecialite()})</td>
								</tr>
								<tr>
									<th>Groupe</th>
									<td>${seanceEtudiant.getSeance().getGroupe()}</td>
								</tr>
								<tr>
									<th>Enseigner le:</th>
									<td>${seanceEtudiant.getSeance().getJour().getValue(0)}à${seanceEtudiant.getSeance().getHeure()}</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<h4 class="text-success">Enseignant chargé de la séance</h4>
					<c:choose>
						<c:when test="${not empty enseignant}">
							<div id="e-exists">
								<div class="table-responsive">
									<table class="table table-sm">
										<tbody>
											<tr>
												<th style="width: 30%">Nom et prénom</th>
												<td>${enseignant.getNom()}&nbsp;${enseignant.getPrenom()}</td>
											</tr>
											<tr>
												<th>Né le</th>
												<td>${enseignant.getDate()}</td>
											</tr>
											<tr>
												<th>Adresse physique</th>
												<td>${enseignant.getAdresse()}</td>
											</tr>
											<tr>
												<th>Contact</th>
												<td>
													<ul>
														<li>
															<b>Adresse mail</b>: ${enseignant.getEmail()}
														</li>
														<li>
															<b>Téléphone</b>: ${enseignant.getTelephone()}
														</li>
													</ul>
												</td>
											</tr>
											<tr>
												<th>Grade</th>
												<td>${enseignant.getGrade()}</td>
											</tr>
											<tr>
												<th>Département actuel</th>
												<td>${enseignant.getCode_departement().getValue(0)}-(${enseignant.getCode_departement()})</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</c:when>
						<c:otherwise>
							<div id="e-not-exists">
								<div class="alert alert-warning" role="alert">
									<h4 class="alert-heading">
										<i class="icon-exclamation fa-lg"></i>&nbsp;Aucun enseignant n'est affecté a cette séance
									</h4>
									<span>Vous pourrez voir les détails de votre enseignant une fois assigné par le chef de département.<br></span>
								</div>
							</div>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</div>
	</main>
	<jsp:include page="/WEB-INF/espace_etudiant/shared/footer_etudiant.jsp"></jsp:include>
	<script src="assets/js/jquery.min.js"></script>
	<script src="assets/bootstrap/js/bootstrap.min.js"></script>
	<script src="assets/js/smoothproducts.min.js"></script>
	<script src="assets/js/theme.js"></script>
	<script src="assets/js/keep-scroll.js"></script>
	<script src="assets/js/consulter-relever-absences-etudiant.js"></script>
</body>
</html>