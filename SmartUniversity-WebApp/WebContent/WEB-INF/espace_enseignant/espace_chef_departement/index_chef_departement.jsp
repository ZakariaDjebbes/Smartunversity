<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${cookie['lang'].value}"/>
<fmt:setBundle basename="resources.ApplicationResources"/>

<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<base href="${pageContext.request.contextPath}/WebContent">
<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title><fmt:message key="headers.index"></fmt:message> - NTIC</title>
<link rel="icon" href="assets/img/Logo/logo.png">
<link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
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
			<div class="row">
				<div class="col col-7">
					<div class="block-heading">
						<h3 class="text-success"><fmt:message key="pages.index_chef.taches"></fmt:message></h3>
						<c:if test="${not empty seancesSansEnseignant and seancesSansEnseignant ne 0}">
							<div class="alert alert-danger" role="alert">
								<span><strong><fmt:message key="pages.index_chef.alert_seances_01"></fmt:message> ${seancesSansEnseignant} <fmt:message key="pages.index_chef.alert_seances_02"></fmt:message></strong></span>
							</div>
						</c:if>
						<c:if test="${not empty demandesNonTraite and demandesNonTraite ne 0}">
							<div class="alert alert-warning" role="alert">
								<span><strong><fmt:message key="pages.index_chef.alert_demandes_01"></fmt:message> ${demandesNonTraite} <fmt:message key="pages.index_chef.alert_demandes_02"></fmt:message></strong></span>
							</div>
						</c:if>
						<c:if test="${(empty demandesNonTraite or demandesNonTraite eq 0) and (empty seancesSansEnseignant or seancesSansEnseignant eq 0)}">
							<div class="alert alert-success" role="alert">
								<h4 class="alert-heading">
									<fmt:message key="pages.index_chef.alert_nothing_01"></fmt:message>
									<br>
								</h4>
								<span><strong><fmt:message key="pages.index_chef.alert_nothing_02"></fmt:message></strong> <br></span>
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
						<fmt:message key="pages.index_chef.chef"></fmt:message> <b>${utilisateur.getCode_departement().getValue(cookie['lang'].value)}-(${utilisateur.getCode_departement()})</b>.
						<br>
						<hr>
						<fmt:message key="pages.index_chef.compte"></fmt:message>
					</div>
				</div>
			</div>
		</div>
	</section>
	<section class="clean-block features">
		<div class="container">
			<div class="block-heading">
				<h2 class="text-success"><fmt:message key="pages.index_enseignant.features_title"></fmt:message></h2>
				<p><fmt:message key="pages.index_chef.features_subtitle"></fmt:message></p>
			</div>
			<div class="row justify-content-center">
				<div class="col-md-5 feature-box">
					<i class="icon-settings icon"></i>
					<h4><fmt:message key="pages.index_enseignant.feature_01_title"></fmt:message></h4>
					<fmt:message key="pages.index_enseignant.feature_01_subtitle"></fmt:message>
				</div>
				<div class="col-md-5 feature-box">
					<i class="icon-pencil icon"></i>
					<h4><fmt:message key="pages.index_enseignant.feature_02_title"></fmt:message></h4>
					<p><fmt:message key="pages.index_enseignant.feature_02_subtitle"></fmt:message></p>
				</div>
				<div class="col-md-5 feature-box">
					<i class="fa fa-lg fa-refresh icon"></i>
					<h4><fmt:message key="pages.index_enseignant.feature_03_title"></fmt:message></h4>
					<fmt:message key="pages.index_enseignant.feature_03_subtitle"></fmt:message>
				</div>
				<div class="col-md-5 feature-box">
					<i class="icon-settings icon"></i>
					<h4><fmt:message key="pages.index_chef.feature_01_title"></fmt:message></h4>
					<fmt:message key="pages.index_chef.feature_01_subtitle"></fmt:message>
				</div>
			</div>
		</div>
	</section>
	</main>
	<jsp:include page="/WEB-INF/espace_enseignant/shared/footer_enseignant.jsp"></jsp:include>
	<script src="assets/js/jquery.min.js"></script>
	<script src="assets/bootstrap/js/bootstrap.min.js"></script>
	<script src="assets/js/smoothproducts.min.js"></script>
	<script src="assets/js/theme.js"></script>
	<script src="assets/js/notifications_handler.js"></script>
</body>
</html>