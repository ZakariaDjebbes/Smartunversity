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
<title><fmt:message key="labels.home"></fmt:message> - NTIC</title>
<link rel="icon" href="assets/img/Logo/logo.png">
<link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat:400,400i,700,700i,600,600i">
<link rel="stylesheet" href="assets/fonts/font-awesome.min.css">
<link rel="stylesheet" href="assets/fonts/simple-line-icons.min.css">
<link rel="stylesheet" href="assets/css/style.css">
<link rel="stylesheet" href="assets/device-mockup/device-mockups.min.css">
</head>
<body>
	<jsp:include page="shared/header.jsp"></jsp:include>
	<main class="page landing-page">
	<section class="clean-block clean-info">
		<div class="container">
			<div class="block-heading">
				<h2 class="text-success"><fmt:message key="pages.index.faculty_name"></fmt:message> NTIC</h2>
				<p><fmt:message key="pages.index.subtitle"></fmt:message></p>
			</div>
			<div class="row align-items-center">
				<div class="col-md-6">
					<img class="img-thumbnail" src="assets/img/scenery/ntic_2.png">
				</div>
				<div class="col-md-6">
					<h3><fmt:message key="pages.index.app_presentation_title"></fmt:message></h3>
					<div class="getting-started-info">
						<p>
							<fmt:message key="pages.index.app_presentation_text"></fmt:message>
							<br>
						</p>
						<a class="btn btn-outline-success btn-lg" role="button" href="login.jsp"><fmt:message key="pages.index.btn_login"></fmt:message></a>
					</div>
				</div>
			</div>
		</div>
	</section>
	<section class="clean-block features dark">
		<div class="container">		
			<div class="block-heading">
				<h2 class="text-success"><fmt:message key="pages.index.app_features_title"></fmt:message></h2>
				<p><fmt:message key="pages.index.app_features_subtitle"></fmt:message></p>
			</div>
			<div class="row justify-content-center">
				<div class="col-md-5 feature-box">
					<i class="icon-note icon"></i>
					<h4><fmt:message key="pages.index.feature_01_title"></fmt:message></h4>
					<p><fmt:message key="pages.index.feature_01_description"></fmt:message></p>
				</div>
				<div class="col-md-5 feature-box">
					<i class="icon-pencil icon"></i>
					<h4><fmt:message key="pages.index.feature_02_title"></fmt:message></h4>
					<p><fmt:message key="pages.index.feature_02_description"></fmt:message></p>
				</div>
				<div class="col-md-5 feature-box">
					<i class="icon-list icon"></i>
					<h4><fmt:message key="pages.index.feature_03_title"></fmt:message></h4>
					<p><fmt:message key="pages.index.feature_03_description"></fmt:message></p>
				</div>
				<div class="col-md-5 feature-box">
					<i class="icon-screen-smartphone icon"></i>
					<h4><fmt:message key="pages.index.feature_04_title"></fmt:message></h4>
					<p><fmt:message key="pages.index.feature_04_description"></fmt:message></p>
				</div>
				<div class="col-md-5 feature-box">
					<i class="icon-chart icon"></i>
					<h4><fmt:message key="pages.index.feature_05_title"></fmt:message></h4>
					<p><fmt:message key="pages.index.feature_05_description"></fmt:message></p>
				</div>
			</div>
		</div>
	</section>
	<section id="mobile" class="clean-block clean-info">
		<div class="container">
			<div class="block-heading">
				<h2 class="text-success"><fmt:message key="pages.index.download_mobile_app_title"></fmt:message></h2>
				<p><fmt:message key="pages.index.download_mobile_app_subtitle"></fmt:message></p>
			</div>
			<div class="row">
				<div class="col">
					<div class="device-wrapper">
						<div class="device" data-device="galaxyS5" data-orientation="portrait" data-color="white">
							<div class="screen" style="background-image: url('assets/img/scenery/mobile_app_login.png')">
							</div>
						</div>
					</div>
				</div>
				<div class="col-12 col-md-8 mt-5">
					<h5>
						<i class="icon-exclamation icon text-success"></i> <fmt:message key="pages.index.download_mobile_app_feature_01"></fmt:message>
					</h5>
					<ul>
						<li><fmt:message key="pages.index.download_mobile_app_feature_01_description_01"></fmt:message></li>
						<li><fmt:message key="pages.index.download_mobile_app_feature_01_description_02"></fmt:message></li>
					</ul>
					<h5>
						<i class="icon-settings icon text-success"></i> <fmt:message key="pages.index.download_mobile_app_feature_02"></fmt:message>
					</h5>
					<p><fmt:message key="pages.index.download_mobile_app_feature_02_description"></fmt:message></p>
					<h5>
						<i class="icon-refresh icon text-success"></i> <fmt:message key="pages.index.download_mobile_app_feature_03"></fmt:message>
					</h5>
					<p><fmt:message key="pages.index.download_mobile_app_feature_02_description"></fmt:message></p>
					<h5>
						<i class="fa fa-language icon text-success"></i> <fmt:message key="pages.index.download_mobile_app_feature_04"></fmt:message>
					</h5>
					<p><fmt:message key="pages.index.download_mobile_app_feature_02_description"></fmt:message></p>
					<div class="text-center mt-5">
						<a class="btn btn-outline-success" href="#">
							<i class="fa fa-android"></i><fmt:message key="labels.download"></fmt:message>
						</a>
						<p>
							<small class="text-muted">*<fmt:message key="pages.index.download_mobile_app_requires"></fmt:message></small>
						</p>
					</div>
				</div>
			</div>
		</div>
	</section>
	</main>
	<jsp:include page="shared/footer.jsp"></jsp:include>
	<script src="assets/js/jquery.min.js"></script>
	<script src="assets/bootstrap/js/bootstrap.min.js"></script>
	<script src="assets/js/smoothproducts.min.js"></script>
	<script src="assets/js/theme.js"></script>
</body>
</html>