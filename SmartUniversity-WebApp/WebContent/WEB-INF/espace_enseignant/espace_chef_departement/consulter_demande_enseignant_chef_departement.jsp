<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${cookie['lang'].value}"/>
<fmt:setBundle basename="resources.ApplicationResources"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>${demande.getModule().getNom()}</title>
<link rel="icon" href="assets/img/Logo/logo.png">
<base href="${pageContext.request.contextPath}/WebContent">
<link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="assets/Datatables/datatables.min.css">
<link rel="stylesheet" href="assets/Datatables/custom-datatables.css">
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
								<h2 class="text-success"><fmt:message key="pages.consulter_demande.demande_de"></fmt:message> <fmt:message key="pages.consulter_demandes.supp"></fmt:message></h2>
							</c:when>
							<c:otherwise>
								<h2 class="text-success"><fmt:message key="pages.consulter_demande.demande_de"></fmt:message> <fmt:message key="pages.consulter_demandes.changement"></fmt:message></h2>
							</c:otherwise>
						</c:choose>
						<p><fmt:message key="pages.consulter_demande.subtitle"></fmt:message></p>
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
						<h4 style="display:inline-block" class="text-success"><fmt:message key="pages.consulter_seance.detail_seance"></fmt:message></h4>
						<a href="${pageContext.request.contextPath}/User/ConsulterSeanceChefDepartement?code-seance=${demande.getSeance().getCode_seance()}" style="float: right" class="badge badge-info"><fmt:message key="labels.consult"></fmt:message></a>
					</div>
					<div class="table-responsive">
						<table class="table table-sm">
							<tbody>
								<tr>
									<th style="width: 30%"><fmt:message key="labels.module"></fmt:message></th>
									<td>${demande.getModule().getNom()} (${demande.getModule().getCode_module()})</td>
								</tr>
								<tr>
									<th><fmt:message key="labels.type"></fmt:message></th>
									<td>${demande.getSeance().getType().getValue(cookie['lang'].value)}(${demande.getSeance().getType()})</td>
								</tr>
								<tr>
									<th><fmt:message key="labels.annee"></fmt:message>, <fmt:message key="labels.specialite"></fmt:message></th>
									<td>${demande.getSeance().getAnnee().getValue(cookie['lang'].value)} (${demande.getSeance().getAnnee()}), ${demande.getSeance().getSpecialite().getValue(cookie['lang'].value)} (${demande.getSeance().getSpecialite()})</td>
								</tr>
								<tr>
									<th><fmt:message key="labels.group"></fmt:message></th>
									<td>${demande.getSeance().getGroupe()}</td>
								</tr>
								<tr>
									<th><fmt:message key="labels.enseigne_le"></fmt:message></th>
									<td>${demande.getSeance().getJour().getValue(cookie['lang'].value)} à ${demande.getSeance().getHeure()}</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<div class="col col-xs-12 col-md-12 col-lg-6 mt-3">
					<div class="table-responsive">
						<h4 class="text-success"><fmt:message key="pages.consulter_seance.detail_enseignant"></fmt:message></h4>
						<table class="table table-sm">
							<tbody>
								<tr>
									<th style="width: 30%"><fmt:message key="labels.nom"></fmt:message>, <fmt:message key="labels.prenom"></fmt:message></th>
									<td>${demande.getEnseignant().getNom()} ${demande.getEnseignant().getPrenom()}</td>
								</tr>
								<tr>
									<th><fmt:message key="labels.ne_le"></fmt:message></th>
									<td>${demande.getEnseignant().getDate()}</td>
								</tr>
								<tr>
									<th><fmt:message key="labels.adresse"></fmt:message></th>
									<td>${demande.getEnseignant().getAdresse()}</td>
								</tr>
								<tr>
									<th><fmt:message key="labels.contact"></fmt:message></th>
									<td>
										<ul>
											<li>
												<b><fmt:message key="labels.email"></fmt:message></b>: ${demande.getEnseignant().getEmail()}
											</li>
											<li>
												<b><fmt:message key="labels.telephone"></fmt:message></b>: ${demande.getEnseignant().getTelephone()}
											</li>
										</ul>
									</td>
								</tr>
								<tr>
									<th><fmt:message key="labels.grade"></fmt:message></th>
									<td>${demande.getEnseignant().getGrade()}</td>
								</tr>
								<tr>
									<th><fmt:message key="labels.departement"></fmt:message></th>
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
						<h4 class="text-success"><fmt:message key="pages.consulter_demande.detail_demande"></fmt:message></h4>
						<c:choose>
							<c:when test="${typeDemande eq 'supp'}">					
								<c:set var="etat" value="${demande.getSeanceSupp().getEtat_seance()}"></c:set>
								<p>
									<fmt:message key="pages.consulter_demande.supp"></fmt:message> <span class="font-weight-bold">${demande.getSeanceSupp().getJour().getValue(cookie['lang'].value)}</span>, <span class="font-weight-bold">${demande.getSeanceSupp().getHeure()}</span>.
								</p>
								<p>
									<span class="font-weight-bold"><fmt:message key="labels.etat"></fmt:message></span>&nbsp;: 
									<c:choose>
										<c:when test="${demande.getSeanceSupp().getEtat_seance() eq 'valide'}">
											<span class="text-success">${demande.getSeanceSupp().getEtat_seance().getValue(cookie['lang'].value)}</span>
										</c:when>
										<c:when test="${demande.getSeanceSupp().getEtat_seance() eq 'refuse'}">
											<span class="text-danger">${demande.getSeanceSupp().getEtat_seance().getValue(cookie['lang'].value)}</span>
										</c:when>
										<c:when test="${demande.getSeanceSupp().getEtat_seance() eq 'nonTraite'}">
											<span class="text-warning">${demande.getSeanceSupp().getEtat_seance().getValue(cookie['lang'].value)}</span>
										</c:when>
									</c:choose>
								</p>
							</c:when>
							<c:when test="${typeDemande eq 'changement'}">	
								<c:set var="etat" value="${demande.getChangementSeance().getEtat_seance()}"></c:set>			
								<p>
									<fmt:message key="pages.consulter_demande.changement"></fmt:message> <span class="font-weight-bold">${demande.getChangementSeance().getNouveau_jour().getValue(cookie['lang'].value)}</span>, <span class="font-weight-bold">${demande.getChangementSeance().getHeure()}</span>.
								</p>
								<p>
									<span class="font-weight-bold"><fmt:message key="labels.etat"></fmt:message></span>&nbsp;: 
									<c:choose>
										<c:when test="${demande.getChangementSeance().getEtat_seance() eq 'valide'}">
											<span class="text-success">${demande.getChangementSeance().getEtat_seance().getValue(cookie['lang'].value)}</span>
										</c:when>
										<c:when test="${demande.getChangementSeance().getEtat_seance() eq 'refuse'}">
											<span class="text-danger">${demande.getChangementSeance().getEtat_seance().getValue(cookie['lang'].value)}</span>
										</c:when>
										<c:when test="${demande.getChangementSeance().getEtat_seance() eq 'nonTraite'}">
											<span class="text-warning">${demande.getChangementSeance().getEtat_seance().getValue(cookie['lang'].value)}</span>
										</c:when>
									</c:choose>
								</p>
							</c:when>
						</c:choose>
						<c:choose>
							<c:when test="${typeDemande eq 'supp'}">
								<form  onsubmit="return (typeof submitted == 'undefined') ? (submitted = true) : !submitted"  method="post">
									<div class="form-group text-center">
										<button class="btn btn-outline-success" formaction="${pageContext.request.contextPath}/User/ValiderDemande" type="submit"><fmt:message key="labels.valide"></fmt:message></button>
										<button class="btn btn-outline-danger ml-5" formaction="${pageContext.request.contextPath}/User/RefuserDemande" type="submit"><fmt:message key="labels.refuse"></fmt:message></button>
									</div>
								</form>
							</c:when>
							<c:when test="${typeDemande eq 'changement' and demande.getChangementSeance().getEtat_seance() eq 'nonTraite'}">
								<form  onsubmit="return (typeof submitted == 'undefined') ? (submitted = true) : !submitted"  method="post">
									<div class="form-group text-center">
										<button class="btn btn-outline-success" formaction="${pageContext.request.contextPath}/User/ValiderDemande" type="submit"><fmt:message key="labels.valide"></fmt:message></button>
										<button class="btn btn-outline-danger ml-5" formaction="${pageContext.request.contextPath}/User/RefuserDemande" type="submit"><fmt:message key="labels.refuse"></fmt:message></button>
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