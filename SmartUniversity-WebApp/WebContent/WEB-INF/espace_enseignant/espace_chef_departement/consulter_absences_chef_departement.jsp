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
<title><fmt:message key="pages.consulter_absences.title"></fmt:message></title>
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
				<h2 class="text-success"><fmt:message key="pages.consulter_absences.title"></fmt:message></h2>
				<p><fmt:message key="pages.consulter_absences.subtitle"></fmt:message></p>
			</div>
			<div class="row">
				<div class="col-12 col-md-6 col-lg-3">
					<div class="dropdown">
						<a class="btn btn-outline-success dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						   <fmt:message key="pages.consulter_absences.by_justification"></fmt:message>
						</a>
						<div class="dropdown-menu w-100" style="min-width:280px;">
							<form  onsubmit="return (typeof submitted == 'undefined') ? (submitted = true) : !submitted"  class="px-1">
								<div class="custom-control custom-checkbox">
								  <input type="checkbox" class="custom-control-input" name="justification" value="Validé" id="cb-justification-valide">
								  <label class="custom-control-label" for="cb-justification-valide"><fmt:message key="pages.consulter_absences.valid"></fmt:message></label>
								</div>
								<div class="custom-control custom-checkbox">
								  <input type="checkbox" class="custom-control-input" name="justification" value="Refusé" id="cb-justification-refuse">
								  <label class="custom-control-label" for="cb-justification-refuse"><fmt:message key="pages.consulter_absences.denied"></fmt:message></label>
								</div>
								<div class="custom-control custom-checkbox">
								  <input type="checkbox" class="custom-control-input" name="justification" value="Non traité" id="cb-justification-non-traite">
								  <label class="custom-control-label" for="cb-justification-non-traite"><fmt:message key="pages.consulter_absences.untreated"></fmt:message></label>
								</div>
								<div class="custom-control custom-checkbox">
								  <input type="checkbox" class="custom-control-input" name="justification" value="Aucune justification" id="cb-justification-aucune">
								  <label class="custom-control-label" for="cb-justification-aucune"><fmt:message key="pages.consulter_absences.without"></fmt:message></label>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			<div id="data-table">
				<div class="table-responsive">
					<table class="table table-striped table-bordered text-center table-center" id="table-absences">
						<thead>
							<tr class="table-success">
								<th><fmt:message key="labels.etudiant"></fmt:message></th>
								<th><fmt:message key="labels.module"></fmt:message></th>
								<th>Justification</th>
								<th><fmt:message key="labels.date"></fmt:message></th>
								<th><fmt:message key="labels.hour"></fmt:message></th>
								<th><fmt:message key="labels.gestion"></fmt:message></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${absencesDepartement}" var="absence">
								<c:if test="${absence.getEtudiant().getEtat_etudiant() ne 'bloque'}">
									<tr>
										<td>${absence.getEtudiant().getNom()} ${absence.getEtudiant().getPrenom()}</td>
										<td>
											${absence.getModule().getNom()} - (<b>${absence.getModule().getCode_module()}</b>)
										</td>
										<c:choose>
											<c:when test="${absence.getLatestJustification().getEtat_justification() eq 'valide'}">
												<td class="text-success">${absence.getLatestJustification().getEtat_justification().getValue(cookie['lang'].value)}</td>
											</c:when>
											<c:when test="${absence.getLatestJustification().getEtat_justification() eq 'refuse'}">
												<td class="text-danger">${absence.getLatestJustification().getEtat_justification().getValue(cookie['lang'].value)}</td>
											</c:when>
											<c:when test="${absence.getLatestJustification().getEtat_justification() eq 'nonTraite'}">
												<td class="text-warning">${absence.getLatestJustification().getEtat_justification().getValue(cookie['lang'].value)}</td>
											</c:when>
											<c:otherwise>
												<td>
													<fmt:message key="labels.no_justification"></fmt:message>
												</td>
											</c:otherwise>
										</c:choose>
										<td>${absence.getAbsence().getDate_absence()}</td>
										<td>${absence.getSeance().getHeure()}</td>
										<td>
											<a 
												href="${pageContext.request.contextPath}/User/ConsulterAbsence?numero-absence=${absence.getAbsence().getNumero_absence()}"
												class="btn btn-outline-success" role="button"><fmt:message key="labels.consult"></fmt:message></a>
										</td>
									</tr>
								</c:if>
							</c:forEach>
						</tbody>
					</table>
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
	<script src="assets/js/consulter-absences-chef-departement.js"></script>
	<script src="assets/js/notifications_handler.js"></script>
</body>
</html>