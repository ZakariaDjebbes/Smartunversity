<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<nav class="navbar navbar-light navbar-expand-xl fixed-top bg-white clean-navbar">
	<div class="container">
		<a class="navbar-brand logo" href="index.jsp">
			<img src="assets/img/Logo/logo.png" class="nav-brand-img" style="width: 50px;">
			Faculté&nbsp;<span class="text-success"><strong>NTIC</strong></span>&nbsp;
		</a>
		<button class="navbar-toggler" data-toggle="collapse" data-target="#navcol-1">
			<span class="sr-only">Toggle navigation</span><span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navcol-1">
			<ul class="nav navbar-nav ml-auto">
				<li class="nav-item">
					<a href="index.jsp" class="nav-link" role="button">Accueil</a>
				</li>
				<li class="nav-item dropdown">
					<a class="dropdown-toggle nav-link" data-toggle="dropdown" aria-expanded="false" href="#">Gestion des absences</a>
					<div class="dropdown-menu" role="menu">
						<a href="${pageContext.request.contextPath}/User/ConsulterReleverAbsencesEtudiant" class="text-center dropdown-item btn btn-link btn-nav" role="button">Consulter votre relevé d'absences</a>
						<a href="${pageContext.request.contextPath}/User/ConsulterEmploiEtudiant" class="text-center dropdown-item btn btn-link btn-nav" role="button">Consulter votre emploi du temps</a>
						<a href="${pageContext.request.contextPath}/User/ConsulterCongeAcademique" class="text-center dropdown-item btn btn-link btn-nav" role="button">Demander un congé académique</a>
					</div>
				</li>
				<li class="nav-item dropdown">
					<a class="dropdown-toggle nav-link" data-toggle="dropdown" aria-expanded="false" href="#">Votre profil</a>
					<div class="dropdown-menu" role="menu">
						<a  class="text-center dropdown-item btn btn-link btn-nav disabled" role="button">${utilisateur.getNom()} ${utilisateur.getPrenom()}</a>
						<div class="dropdown-divider"></div>
						<a href="${pageContext.request.contextPath}/User/ModifierProfil" class="text-center dropdown-item btn btn-link btn-nav" role="button">Modifier votre compte</a>
						<a href="${pageContext.request.contextPath}/User/Logout" class="text-center text-danger dropdown-item btn btn-link btn-nav" role="button">Se déconnecter</a>
					</div>
				</li>
				<li class="nav-item dropdown">
					<a class="dropdown-toggle nav-link" data-toggle="dropdown" aria-expanded="false" href="#">
						<i class="icon-globe fa-lg"></i>
					</a>
					<div class="dropdown-menu" role="menu">
						<a class="text-center dropdown-item" href="#">Français</a>
						<a class="text-center dropdown-item" href="#">English</a>
						<a class="text-center dropdown-item" href="#">العربية</a>
					</div>
				</li>
			</ul>
		</div>
	</div>
</nav>