<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${cookie['lang'].value}"/>
<fmt:setBundle basename="resources.ApplicationResources"/>
<nav class="navbar navbar-light navbar-expand-xl fixed-top bg-white clean-navbar">
	<div class="container">
		<a class="navbar-brand logo" href="index.jsp">
			<img src="assets/img/Logo/logo.png" class="nav-brand-img" style="width: 50px;">
			<fmt:message key="headers.faculty"></fmt:message>&nbsp;<span class="text-success"><strong>NTIC</strong></span>&nbsp;
		</a>
		<button class="navbar-toggler" data-toggle="collapse" data-target="#navcol-1">
			<span class="sr-only">Toggle navigation</span><span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navcol-1">
			<ul class="nav navbar-nav ml-auto">
				<li class="nav-item">
					<a href="index.jsp" class="nav-link" role="button"><fmt:message key="headers.index"></fmt:message></a>
				</li>
				<li class="nav-item dropdown">
					<a class="dropdown-toggle nav-link" data-toggle="dropdown" aria-expanded="false" href="#"><fmt:message key="headers.gestion_absence"></fmt:message></a>
					<div class="dropdown-menu" role="menu">
						<a href="${pageContext.request.contextPath}/User/ConsulterReleverAbsencesEtudiant" class="text-center dropdown-item btn btn-link btn-nav" role="button"><fmt:message key="headers.releve"></fmt:message></a>
						<a href="${pageContext.request.contextPath}/User/ConsulterEmploiEtudiant" class="text-center dropdown-item btn btn-link btn-nav" role="button"><fmt:message key="headers.emploi"></fmt:message></a>
						<a href="${pageContext.request.contextPath}/User/ConsulterCongeAcademique" class="text-center dropdown-item btn btn-link btn-nav" role="button"><fmt:message key="headers.conge_academique"></fmt:message></a>
					</div>
				</li>
				<li class="nav-item dropdown">
					<a class="dropdown-toggle nav-link" data-toggle="dropdown" aria-expanded="false" href="#"><fmt:message key="headers.your_profil"></fmt:message></a>
					<div class="dropdown-menu" role="menu">
						<a  class="text-center dropdown-item btn btn-link btn-nav disabled" role="button">${utilisateur.getNom()} ${utilisateur.getPrenom()}</a>
						<div class="dropdown-divider"></div>
						<a href="${pageContext.request.contextPath}/User/ModifierProfil" class="text-center dropdown-item btn btn-link btn-nav" role="button"><fmt:message key="headers.update_profil"></fmt:message></a>
						<a href="${pageContext.request.contextPath}/User/Logout" class="text-center text-danger dropdown-item btn btn-link btn-nav" role="button"><fmt:message key="headers.logout"></fmt:message></a>
					</div>
				</li>
				<li class="nav-item dropdown">
					<a class="dropdown-toggle nav-link" data-toggle="dropdown" aria-expanded="false" href="#">
						<i class="icon-globe fa-lg"></i>
					</a>
					<div class="dropdown-menu" role="menu">
						<a class="dropdown-item" href="UpdateCookieLocale?cookieLocale=fr"><fmt:message key="headers.fr"></fmt:message></a>
						<a class="dropdown-item" href="UpdateCookieLocale?cookieLocale=en"><fmt:message key="headers.en"></fmt:message></a>
					</div>
				</li>
			</ul>
		</div>
	</div>
</nav>