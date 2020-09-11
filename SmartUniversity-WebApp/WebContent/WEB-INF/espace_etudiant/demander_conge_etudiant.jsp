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
<title>Demande de congé académique - NTIC</title>
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
	<div class="clean-block clean-info dark">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="block-heading">
						<h2 class="text-success"><fmt:message key="pages.conge_etudiant.title"></fmt:message></h2>
						<p><fmt:message key="pages.conge_etudiant.subtitle"></fmt:message></p>
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
			<c:choose>
				<c:when test="${empty demandeConge}">
					<div class="row">
						<div class="col">
							<div role="alert" class="alert alert-danger">
								<h4 class="alert-heading">
									<i class="icon-exclamation"></i> <fmt:message key="pages.conge_etudiant.alert_header_01"></fmt:message>
								</h4>
								<hr>
								<span><fmt:message key="pages.conge_etudiant.alert_text_01"></fmt:message><br><fmt:message key="pages.conge_etudiant.alert_text_02"></fmt:message>
								</span>
							</div>
							<form  onsubmit="return (typeof submitted == 'undefined') ? (submitted = true) : !submitted"  method="post" action="${pageContext.request.contextPath}/User/DemanderCongeAcademique" enctype="multipart/form-data">
								<div class="form-group">
									<input type="hidden" name="id-etudiant" value="${utilisateur.getId_utilisateur()}">
									<label for="fichier-conge"><fmt:message key="pages.conge_etudiant.choose_file"></fmt:message>&nbsp;</label>
									<input type="file" accept="image/*" required name="fichier-congeAcademique" id="fichier-conge">
									<small class="d-block">*.png, *.jpg, *.jpeg <fmt:message key="labels.only"></fmt:message></small>
								</div>
								<div class="form-group">
									<button class="btn btn-outline-danger" type="submit"><fmt:message key="labels.send"></fmt:message></button>
								</div>
							</form>
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<div class="row">
						<div class="col">
							<div role="alert" class="alert alert-warning">
								<h4 class="alert-heading">
									<i class="icon-exclamation"></i> <fmt:message key="pages.conge_etudiant.alert_header_02"></fmt:message>
								</h4>
								<hr>
								<span><fmt:message key="pages.conge_etudiant.alert_text_03"></fmt:message><br><fmt:message key="pages.conge_etudiant.alert_text_04"></fmt:message><br> <b><fmt:message key="pages.conge_etudiant.alert_etat"></fmt:message> </b> <c:choose>
										<c:when test="${demandeConge.getEtat_demande() eq 'refuse'}">
											<span class="text-danger font-weight-bold"> ${demandeConge.getEtat_demande().getValue(cookie['lang'].value)} </span>
										</c:when>
										<c:otherwise>
											<span class="text-warning font-weight-bold"> ${demandeConge.getEtat_demande().getValue(cookie['lang'].value)} </span>
										</c:otherwise>
									</c:choose>
								</span>
								<hr>
								<span>
									<form  onsubmit="return (typeof submitted == 'undefined') ? (submitted = true) : !submitted"  class="form-normal" method="post" action="${pageContext.request.contextPath}/User/AnnulerCongeAcademique">
										<input type="hidden" name="numero-conge-academique" value="${demandeConge.getNumero_conge_academique()}">
										<button type="submit" class="btn btn-warning"><fmt:message key="labels.cancel"></fmt:message></button>
									</form>
								</span>
							</div>
						</div>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	</main>
	<jsp:include page="/WEB-INF/espace_etudiant/shared/footer_etudiant.jsp"></jsp:include>
	<script src="assets/js/jquery.min.js"></script>
	<script src="assets/bootstrap/js/bootstrap.min.js"></script>
	<script src="assets/js/smoothproducts.min.js"></script>
	<script src="assets/js/theme.js"></script>
</body>
</html>
