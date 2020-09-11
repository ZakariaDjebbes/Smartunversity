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
<title><fmt:message key="headers.index"></fmt:message> - NTIC</title>
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
	<section class="clean-block clean-info dark">
		<div class="container">
			<div class="row">
				<div class="col col-7">
					<div class="block-heading">
						<h4 class="text-success pb-3"><fmt:message key="pages.index_etudiant.taches_title"></fmt:message></h4>
						<c:if test="${not empty absencesNonJustifier and absencesNonJustifier ne 0}">
							<div class="alert alert-danger" role="alert">
								<span><strong><fmt:message key="pages.index_etudiant.alert_absences_01"></fmt:message> ${absencesNonJustifier} <fmt:message key="pages.index_etudiant.alert_absences_02"></fmt:message></strong></span>
							</div>
						</c:if>
						<c:if test="${not empty absencesNonTraite and absencesNonTraite ne 0}">
							<div class="alert alert-info" role="alert">
								<span><strong><fmt:message key="pages.index_etudiant.alert_justifications_01"></fmt:message> ${absencesNonTraite} <fmt:message key="pages.index_etudiant.alert_justifications_02"></fmt:message></strong></span>
							</div>
						</c:if>
						<c:if test="${not empty HasCongeAcademique and HasCongeAcademique}">
							<div class="alert alert-warning" role="alert">
								<span><strong><fmt:message key="pages.index_etudiant.alert_conge"></fmt:message></strong></span>
							</div>
						</c:if>
						<c:if test="${(empty absencesNonJustifier or absencesNonJustifier eq 0) and (empty HasCongeAcademique or (not HasCongeAcademique))}">
							<div class="alert alert-success" role="alert">
								<h4 class="alert-heading">
									<fmt:message key="pages.index_etudiant.alert_nothing_01"></fmt:message>
									<br>
								</h4>
								<span><strong><fmt:message key="pages.index_etudiant.alert_nothing_02"></fmt:message></strong>
								<br></span>
							</div>
						</c:if>
					</div>
				</div>
				<div class="col">
					<div class="block-heading">
						<h3 class="text-info">${utilisateur.getNom()} ${utilisateur.getPrenom()}</h3>
						<p><fmt:message key="pages.welcome"></fmt:message> ${utilisateur.getUser_type().getValue(cookie['lang'].value)}</p>
					</div>
					<div class="text-center">
						<fmt:message key="pages.index_etudiant.etudiant_text"></fmt:message> <b>${utilisateur.getCode_departement().getValue(cookie['lang'].value)}-(${utilisateur.getCode_departement()})</b> <fmt:message key="labels.en"></fmt:message> <b>${utilisateur.getAnnee()}-${utilisateur.getSpecialite()}</b> <b>groupe ${utilisateur.getGroupe()}</b>.
						<br>
						<hr>
						<fmt:message key="pages.index_etudiant.compte"></fmt:message>
					</div>
				</div>
			</div>
		</div>
	</section>
	<section class="clean-block features">
		<div class="container">
			<div class="block-heading">
				<h2 class="text-success"><fmt:message key="pages.index_etudiant.features_title"></fmt:message></h2>
				<p><fmt:message key="pages.index_etudiant.features_subtitle"></fmt:message></p>
			</div>
			<div class="row justify-content-center">
				<div class="col-md-5 feature-box">
					<i class="fa fa-calendar icon"></i>
					<h4><fmt:message key="pages.index_etudiant.feature_01_title"></fmt:message></h4>
					<p><fmt:message key="pages.index_etudiant.feature_01_text"></fmt:message></p>
				</div>
				<div class="col-md-5 feature-box">
					<i class="icon-eye icon"></i>
					<h4><fmt:message key="pages.index_etudiant.feature_02_title"></fmt:message></h4>
					<p><fmt:message key="pages.index_etudiant.feature_02_text"></fmt:message></p>
				</div>
				<div class="col-md-5 feature-box">
					<i class="icon-question icon"></i>
					<h4><fmt:message key="pages.index_etudiant.feature_03_title"></fmt:message></h4>
					<p><fmt:message key="pages.index_etudiant.feature_03_text"></fmt:message></p>
				</div>
				<div class="col-md-5 feature-box">
					<i class="icon-screen-smartphone icon"></i>
					<h4><fmt:message key="pages.index_etudiant.feature_04_title"></fmt:message></h4>
					<p><fmt:message key="pages.index_etudiant.feature_04_text"></fmt:message></p>
				</div>
			</div>
		</div>
	</section>
	</main>
	<jsp:include page="/WEB-INF/espace_etudiant/shared/footer_etudiant.jsp"></jsp:include>
	<script src="assets/js/jquery.min.js"></script>
	<script src="assets/bootstrap/js/bootstrap.min.js"></script>
	<script src="assets/js/smoothproducts.min.js"></script>
	<script src="assets/js/theme.js"></script>
</body>
</html>