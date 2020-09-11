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
<title><fmt:message key="labels.releve"></fmt:message> - ${utilisateur.getNom()} ${utilisateur.getPrenom()}</title>
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
						<h2 class="text-success"><fmt:message key="labels.releve"></fmt:message></h2>
						<p><fmt:message key="pages.releve_etudiant.subtitle"></fmt:message></p>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12">
					<div>
						<c:choose>
							<c:when test="${releverAbsences.isEmpty()}">
								<div class="alert alert-success" role="alert">
								  <h4 class="alert-heading"><fmt:message key="pages.releve_etudiant.alert_no_absences_01"></fmt:message></h4>
								  <p><fmt:message key="pages.releve_etudiant.alert_no_absences_02"></fmt:message></p>
								  <hr>
								  <p class="mb-0"><fmt:message key="pages.releve_etudiant.alert_no_absences_03"></fmt:message></p>
								</div>
							</c:when>
							<c:otherwise>
								<div class="table-responsive">
									<table id="table-relever" class="table table-sm table-borderless">
										<tbody>
											<c:forEach var="relever" items="${releverAbsences.getRelever()}" varStatus="status">
												<c:set var="absences" value="${relever.value}"></c:set>
												<tr>
													<th class="text-left" style="width: 50%">${absences.get(0).getModule().getNom()}
														<a href="${pageContext.request.contextPath}/User/ConsulterSeanceEtudiant?code-seance=${absences.get(0).getSeance().getCode_seance()}">
															<span class="badge badge-info"><fmt:message key="labels.consult"></fmt:message></span>
														</a>
													</th>
													<th>${absences.size()} Absences</th>
													<c:choose>
														<c:when test="${releverAbsences.isExcluFrom(absences.get(0).getSeance().getCode_seance())}">
															<th class="text-danger text-right"><fmt:message key="labels.exclu"></fmt:message></th>
														</c:when>
														<c:otherwise>
															<th class="text-success text-right"><fmt:message key="labels.not_exclu"></fmt:message></th>
														</c:otherwise>
													</c:choose>
												</tr>
												<c:forEach var="absence" items="${absences}">
													<tr>
														<td>Le ${absence.getAbsence().getDate_absence()}</td>
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
																<td><fmt:message key="labels.no_justification"></fmt:message></td>
															</c:otherwise>
														</c:choose>
														<td class="noExport text-right">
															<a href='${pageContext.request.contextPath}/User/ConsulterAbsence?numero-absence=${absence.getAbsence().getNumero_absence()}' class='btn btn-outline-info' data-toggle='tooltip'
																data-placement='top' title='Consulter cette absence'>
																<fmt:message key="labels.consult"></fmt:message> <i class="fa fa-search"></i>
															</a>

														</td>
													</tr>
												</c:forEach>
											</c:forEach>
										</tbody>
									</table>
								</div>
								<div class="text-center mt-5">
									<div class="dropdown">
										<button class="btn btn-outline-dark dropdown-toggle" data-toggle="dropdown" aria-expanded="false" type="button"><fmt:message key="labels.download"></fmt:message></button>
										<div class="dropdown-menu" role="menu">
											<a class="dropdown-item" role="presentation" id="btn-download-excel">
												Excel&nbsp;<i class="fa fa-file-excel-o float-right fa-lg text-success"></i>
											</a>
											<a class="dropdown-item" role="presentation" id="btn-download-csv">
												CSV&nbsp;<i class="fa fa-table float-right fa-lg"></i>
											</a>
										</div>
									</div>
								</div>
							</c:otherwise>
						</c:choose>
					</div>
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
	<script src="assets/js/table2csv.min.js"></script>
	<script src="assets/js/jquery.table2excel.min.js"></script>
	<script src="assets/js/keep-scroll.js"></script>
	<script src="assets/js/consulter-relever-absences-etudiant.js"></script>
</body>
</html>