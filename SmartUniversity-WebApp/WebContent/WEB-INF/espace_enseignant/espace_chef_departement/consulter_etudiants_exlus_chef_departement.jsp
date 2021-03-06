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
<title><fmt:message key="pages.etudiants_exclus.title"></fmt:message></title>
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
	<section class="clean-block clean-info dark">
		<div class="container">
			<div class="block-heading">
				<h2 class="text-success"><fmt:message key="pages.etudiants_exclus.title"></fmt:message></h2>
				<p><fmt:message key="pages.index.subtitle"></fmt:message></p>
			</div>
			<div class="row">
				<div class="col">
					<div id="data-table">
						<div class="table-responsive">
							<table class="table table-striped table-bordered text-center table-center" id="table-etudiants-exclus">
								<thead>
									<tr class="table-success">
										<th style="width: 35%;"><fmt:message key="labels.etudiant"></fmt:message></th>
										<th><fmt:message key="labels.module"></fmt:message></th>
										<th><fmt:message key="labels.nombre_absence"></fmt:message></th>
										<th><fmt:message key="labels.nombre_justifier"></fmt:message></th>
										<th><fmt:message key="labels.nombre_non_justifier"></fmt:message></th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="seance" items="${seancesDepartement}">
										<c:forEach var="etudiant" items="${seance.getEtudiants()}">
											<c:if test="${etudiant.isExclus()}">
												<tr>
													<td>${etudiant.getEtudiant().getNom()} ${etudiant.getEtudiant().getPrenom()} <c:if test="${etudiant.getEtudiant().getEtat_etudiant() eq 'bloque'}"><span class="float-right badge badge-warning">${etudiant.getEtudiant().getEtat_etudiant().getValue(cookie['lang'].value)}</span></c:if></td>
													<td>${seance.getModule().getNom()}-(${seance.getModule().getCode_module()})</td>
													<td>${etudiant.getNombreAbsences()}</td>
													<td>${etudiant.getAbsencesJusifiter()}</td>
													<td>${etudiant.getAbsencesNonJustifier()}</td>
												</tr>
											</c:if>
										</c:forEach>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	</main>
	<jsp:include page="/WEB-INF/espace_enseignant/shared/footer_enseignant.jsp"></jsp:include>
	<script src="assets/js/jquery.min.js"></script>
	<script src="assets/bootstrap/js/bootstrap.min.js"></script>
	<script src="assets/Datatables/datatables.min.js"></script>
	<script src="assets/js/smoothproducts.min.js"></script>
	<script src="assets/js/theme.js"></script>
	<script src="assets/js/consulter-etudiant-exclus-chef-departement.js"></script>
	<script src="assets/js/notifications_handler.js"></script>
</body>
</html>