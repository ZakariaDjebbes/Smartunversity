<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>Traitement de la demande pour ${demande.getModule().getNom()}</title>
<link rel="icon" href="assets/img/Logo/logo.png">
<base href="${pageContext.request.contextPath}/WebContent">
<link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="assets/data-tables/DataTables-1.10.20/css/dataTables.bootstrap4.min.css">
<link rel="stylesheet" href="assets/data-tables/custom-datatables.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat:400,400i,700,700i,600,600i">
<link rel="stylesheet" href="assets/fonts/font-awesome.min.css">
<link rel="stylesheet" href="assets/fonts/simple-line-icons.min.css">
<link rel="stylesheet" href="assets/css/style.css">

</head>

<body>
	<jsp:include page="/WEB-INF/espace_enseignant/shared/header_enseignant.jsp"></jsp:include>
	<main class="page landing-page">
	<div class="clean-block clean-info dark">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="block-heading">
						<c:choose>
							<c:when test="${typeDemande eq 'supp'}">
								<h2 class="text-success">Demande de séance supplémentaire</h2>
							</c:when>
							<c:otherwise>
								<h2 class="text-success">Demande de changement de séance</h2>
							</c:otherwise>
						</c:choose>
						<p>Acceptez ou refusez cette demande</p>
					</div>
				</div>
			</div>
			<c:if test="${not empty isDone && not empty message}">
				<c:choose>
					<c:when test="${isDone}">
						<div class="alert alert-success alert-dismissible fade show" role="alert">
							${message}
							<button type="button" class="close" data-dismiss="alert" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
					</c:when>
					<c:when test="${not isDone}">
						<div class="alert alert-danger alert-dismissible fade show" role="alert">
							${message}
							<button type="button" class="close" data-dismiss="alert" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
					</c:when>
				</c:choose>
				<c:remove var="isDone" />
				<c:remove var="message" />
			</c:if>
			<div class="row">
				<div class="col mt-3">
					<div class="text-left">
						<h4 style="display:inline-block" class="text-success">Séance d'origine</h4>
						<a href="${pageContext.request.contextPath}/User/ConsulterSeanceChefDepartement?code-seance=${demande.getSeance().getCode_seance()}" style="float: right" class="badge badge-info">Consulter</a>
					</div>
					<div class="table-responsive">
						<table class="table table-sm">
							<tbody>
								<tr>
									<th style="width: 30%">Module</th>
									<td>${demande.getModule().getNom()} (${demande.getModule().getCode_module()})</td>
								</tr>
								<tr>
									<th>Type</th>
									<td>${demande.getSeance().getType().getValue(0)}(${demande.getSeance().getType()})</td>
								</tr>
								<tr>
									<th>Année et spécialité</th>
									<td>${demande.getSeance().getAnnee().getValue(0)} (${demande.getSeance().getAnnee()}), ${demande.getSeance().getSpecialite().getValue(0)} (${demande.getSeance().getSpecialite()})</td>
								</tr>
								<tr>
									<th>Groupe</th>
									<td>${demande.getSeance().getGroupe()}</td>
								</tr>
								<tr>
									<th>Enseigner le:</th>
									<td>${demande.getSeance().getJour().getValue(0)} à ${demande.getSeance().getHeure()}</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<div class="col col-xs-12 col-md-12 col-lg-6 mt-3">
					<div class="table-responsive">
						<h4 class="text-success">Enseignant de la séance</h4>
						<table class="table table-sm">
							<tbody>
								<tr>
									<th style="width: 30%">Nom et prénom</th>
									<td>${demande.getEnseignant().getNom()} ${demande.getEnseignant().getPrenom()}</td>
								</tr>
								<tr>
									<th>Né le</th>
									<td>${demande.getEnseignant().getDate()}</td>
								</tr>
								<tr>
									<th>Adresse physique</th>
									<td>${demande.getEnseignant().getAdresse()}</td>
								</tr>
								<tr>
									<th>Contact</th>
									<td>
										<ul>
											<li>
												<b>Adresse mail</b>: ${demande.getEnseignant().getEmail()}
											</li>
											<li>
												<b>Téléphone</b>: ${demande.getEnseignant().getTelephone()}
											</li>
										</ul>
									</td>
								</tr>
								<tr>
									<th>Grade</th>
									<td>${demande.getEnseignant().getGrade()}</td>
								</tr>
								<tr>
									<th>Département actuel</th>
									<td>${demande.getEnseignant().getCode_departement()}</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<div class="text-center">
						<h4 class="text-success">Details de la demande</h4>
						<c:choose>
							<c:when test="${typeDemande eq 'supp'}">					
								<c:set var="etat" value="${demande.getSeanceSupp().getEtat_seance()}"></c:set>
								<p>
									Ajout d'une séance supplémentaire le <span class="font-weight-bold">${demande.getSeanceSupp().getJour().getValue(0)}</span>&nbsp;à <span class="font-weight-bold">${demande.getSeanceSupp().getHeure()}</span>.
								</p>
								<p>
									<span class="font-weight-bold">Etat actuel</span>&nbsp;: 
									<c:choose>
										<c:when test="${demande.getSeanceSupp().getEtat_seance() eq 'valide'}">
											<span class="text-success">${demande.getSeanceSupp().getEtat_seance().getValue(0)}</span>
										</c:when>
										<c:when test="${demande.getSeanceSupp().getEtat_seance() eq 'refuse'}">
											<span class="text-danger">${demande.getSeanceSupp().getEtat_seance().getValue(0)}</span>
										</c:when>
										<c:when test="${demande.getSeanceSupp().getEtat_seance() eq 'nonTraite'}">
											<span class="text-warning">${demande.getSeanceSupp().getEtat_seance().getValue(0)}</span>
										</c:when>
									</c:choose>
								</p>
							</c:when>
							<c:when test="${typeDemande eq 'changement'}">	
								<c:set var="etat" value="${demande.getChangementSeance().getEtat_seance()}"></c:set>			
								<p>
									Changer l'horaire de cette séance vers <span class="font-weight-bold">${demande.getChangementSeance().getNouveau_jour().getValue(0)}</span>&nbsp;à <span class="font-weight-bold">${demande.getChangementSeance().getHeure()}</span>.
								</p>
								<p>
									<span class="font-weight-bold">Etat actuel</span>&nbsp;: 
									<c:choose>
										<c:when test="${demande.getChangementSeance().getEtat_seance() eq 'valide'}">
											<span class="text-success">${demande.getChangementSeance().getEtat_seance().getValue(0)}</span>
										</c:when>
										<c:when test="${demande.getChangementSeance().getEtat_seance() eq 'refuse'}">
											<span class="text-danger">${demande.getChangementSeance().getEtat_seance().getValue(0)}</span>
										</c:when>
										<c:when test="${demande.getChangementSeance().getEtat_seance() eq 'nonTraite'}">
											<span class="text-warning">${demande.getChangementSeance().getEtat_seance().getValue(0)}</span>
										</c:when>
									</c:choose>
								</p>
							</c:when>
						</c:choose>
						<c:choose>
							<c:when test="${typeDemande eq 'supp'}">
								<form  onsubmit="return (typeof submitted == 'undefined') ? (submitted = true) : !submitted"  method="post">
									<div class="form-group text-center">
										<button class="btn btn-outline-success" formaction="${pageContext.request.contextPath}/User/ValiderDemande" type="submit">Accepter</button>
										<button class="btn btn-outline-danger ml-5" formaction="${pageContext.request.contextPath}/User/RefuserDemande" type="submit">Refuser</button>
									</div>
								</form>
							</c:when>
							<c:when test="${typeDemande eq 'changement' and demande.getChangementSeance().getEtat_seance() eq 'nonTraite'}">
								<form  onsubmit="return (typeof submitted == 'undefined') ? (submitted = true) : !submitted"  method="post">
									<div class="form-group text-center">
										<button class="btn btn-outline-success" formaction="${pageContext.request.contextPath}/User/ValiderDemande" type="submit">Accepter</button>
										<button class="btn btn-outline-danger ml-5" formaction="${pageContext.request.contextPath}/User/RefuserDemande" type="submit">Refuser</button>
									</div>
								</form>
							</c:when>
						</c:choose>
					</div>
				</div>
			</div>
			<!--<div class="row">
				<div class="col">
					<div>
						<h4 class="text-success">Autres demandes pour cette séance</h4>
						<div class="table-responsive-md">
							<table class="table table-striped">
								<thead>
									<tr class="table-success">
										<th>Type de demande</th>
										<th>Demande</th>
										<th>Traiter</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>Cell 1</td>
										<td>Manger du pain et de la viande</td>
										<td>Cell 2</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>-->
		</div>
	</div>
	</main>
	<jsp:include page="/WEB-INF/espace_enseignant/shared/footer_enseignant.jsp"></jsp:include>
	<script src="assets/js/jquery.min.js"></script>
	<script src="assets/bootstrap/js/bootstrap.min.js"></script>
	<script src="assets/js/smoothproducts.min.js"></script>
	<script src="assets/js/theme.js"></script>
	<script src="assets/js/keep-scroll.js"></script>
	<script src="assets/js/notifications_handler.js"></script>
</body>
</html>