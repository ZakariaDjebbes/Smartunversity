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
<title>${seanceEtudiant.getModule().getNom()}-(${seanceEtudiant.getModule().getCode_module()})</title>
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
						<h2 class="text-success"><fmt:message key="pages.consulter_seance.title"></fmt:message></h2>
						<p><fmt:message key="pages.consulter_seance.subtitle"></fmt:message></p>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<div class="table-responsive">
						<h4 class="text-success"><fmt:message key="pages.consulter_seance.detail_seance"></fmt:message></h4>
						<table class="table table-sm">
							<tbody>
								<tr>
									<th style="width: 30%"><fmt:message key="labels.module"></fmt:message></th>
									<td>${seanceEtudiant.getModule().getNom()}-(${seanceEtudiant.getModule().getCode_module()})</td>
								</tr>
								<tr>
									<th><fmt:message key="labels.type"></fmt:message></th>
									<td>${seanceEtudiant.getSeance().getType().getValue(cookie['lang'].value)}-(${seanceEtudiant.getSeance().getType()})</td>
								</tr>
								<tr>
									<th><fmt:message key="labels.annee"></fmt:message>, <fmt:message key="labels.specialite"></fmt:message></th>
									<td>${seanceEtudiant.getSeance().getAnnee().getValue(cookie['lang'].value)}-(${seanceEtudiant.getSeance().getAnnee()}), ${seanceEtudiant.getSeance().getSpecialite().getValue(cookie['lang'].value)}-(${seanceEtudiant.getSeance().getSpecialite()})</td>
								</tr>
								<tr>
									<th><fmt:message key="labels.group"></fmt:message></th>
									<td>${seanceEtudiant.getSeance().getGroupe()}</td>
								</tr>
								<tr>
									<th><fmt:message key="labels.enseigne_le"></fmt:message></th>
									<td>${seanceEtudiant.getSeance().getJour().getValue(cookie['lang'].value)}, ${seanceEtudiant.getSeance().getHeure()}</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<h4 class="text-success"><fmt:message key="pages.consulter_seance.enseignant"></fmt:message></h4>
					<c:choose>
						<c:when test="${not empty enseignant}">
							<div id="e-exists">
								<div class="table-responsive">
									<table class="table table-sm">
										<tbody>
											<tr>
												<th style="width: 30%"><fmt:message key="labels.nom"></fmt:message>, <fmt:message key="labels.prenom"></fmt:message></th>
												<td>${enseignant.getNom()}&nbsp;${enseignant.getPrenom()}</td>
											</tr>
											<tr>
												<th><fmt:message key="labels.ne_le"></fmt:message></th>
												<td>${enseignant.getDate()}</td>
											</tr>
											<tr>
												<th><fmt:message key="labels.adresse"></fmt:message></th>
												<td>${enseignant.getAdresse()}</td>
											</tr>
											<tr>
												<th><fmt:message key="labels.contact"></fmt:message></th>
												<td>
													<ul>
														<li>
															<b><fmt:message key="labels.email"></fmt:message></b>: ${enseignant.getEmail()}
														</li>
														<li>
															<b><fmt:message key="labels.telephone"></fmt:message></b>: ${enseignant.getTelephone()}
														</li>
													</ul>
												</td>
											</tr>
											<tr>
												<th><fmt:message key="labels.grade"></fmt:message></th>
												<td>${enseignant.getGrade()}</td>
											</tr>
											<tr>
												<th><fmt:message key="labels.departement"></fmt:message></th>
												<td>${enseignant.getCode_departement().getValue(cookie['lang'].value)}-(${enseignant.getCode_departement()})</td>
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
										<i class="icon-exclamation fa-lg"></i>&nbsp;<fmt:message key="pages.consulter_seance.alert_no_teacher_01"></fmt:message>
									</h4>
									<span><fmt:message key="pages.consulter_seance.alert_no_teacher_02"></fmt:message><br></span>
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