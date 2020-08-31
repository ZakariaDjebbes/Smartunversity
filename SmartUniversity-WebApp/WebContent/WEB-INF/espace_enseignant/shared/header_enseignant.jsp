<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link href="assets/css/notifications-dropdown.css" type="text/css" rel="stylesheet" />
<nav class="navbar navbar-light navbar-expand-lg fixed-top bg-white clean-navbar">
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
					<a href="index.jsp" class="dropdown-item btn btn-link btn-nav" role="button">Accueil</a>
				</li>
				<c:if test="${utilisateur.getUser_type() eq 'chefDepartement'}">
					<li class="nav-item dropdown">
						<a class="dropdown-toggle nav-link" data-toggle="dropdown" aria-expanded="false" href="#">Votre Département</a>
						<div class="dropdown-menu" role="menu">
							<a href="${pageContext.request.contextPath}/User/ConsulterSeancesChefDepartement" class="text-center dropdown-item btn btn-link btn-nav" role="button">Consulter les séances</a>
							<a href="${pageContext.request.contextPath}/User/ConsulterAbsencesChefDepartement" class="text-center dropdown-item btn btn-link btn-nav" role="button">Consulter les absences</a>
							<a href="${pageContext.request.contextPath}/User/ConsulterDemandesChefDepartement" class="text-center dropdown-item btn btn-link btn-nav" role="button">Consulter les demandes</a>
						</div>
					</li>
				</c:if>
				<li class="nav-item dropdown">
					<a class="dropdown-toggle nav-link" data-toggle="dropdown" aria-expanded="false" href="#">Vos séances</a>
					<div class="dropdown-menu" role="menu">
						<a href="${pageContext.request.contextPath}/User/ConsulterSeancesEnseignant" class="text-center dropdown-item btn btn-link btn-nav" role="button">Consulter vos séances</a>
						<a href="${pageContext.request.contextPath}/User/ConsulterStatistiquesEnseignant" class="text-center dropdown-item btn btn-link btn-nav" role="button">Consulter les statistiques de vos groupes</a>
						<c:if test="${utilisateur.getUser_type() eq 'responsableFormation'}">
							<a href="" class="text-center dropdown-item btn btn-link btn-nav" role="button">Consulter les statistiques de votre formation</a>
						</c:if>
					</div>
				</li>
				<li class="nav-item dropdown">
					<a class="dropdown-toggle nav-link" data-toggle="dropdown" aria-expanded="false" href="#">Votre profil</a>
					<div class="dropdown-menu" role="menu">
						<a class="text-center dropdown-item btn btn-link btn-nav disabled" role="button">${utilisateur.getNom()} ${utilisateur.getPrenom()}</a>
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
				<li class="nav-item dropdown">
					<div id="div-dropdown-notifications" class="dropdown nav-button notifications-button hidden-sm-down">
						<a class="dropdown-toggle nav-link dropdown-toggle" id="notifications-dropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" href="#">
							<i id="notificationsIcon" class="fa fa-bell-o fa-lg" aria-hidden="true"></i> <span id="notificationsBadge" class="badge badge-danger">2</span>
						</a>
						<div class="dropdown-menu dropdown-menu-right notification-dropdown-menu" aria-labelledby="notifications-dropdown">
							<h5 class="dropdown-header">Vos notifications</h5>
							<!--
							<a id="notificationsLoader" class="dropdown-item dropdown-notification" href="#">
								<p class="notification-solo text-center">
									<i id="notificationsIcon" class="fa fa-spinner fa-pulse fa-fw" aria-hidden="true"></i> Chargement des dernières notifications...
								</p>
							</a>
							 -->
							<div id="append-notifications">
							
							</div>
							<div id="notificationsContainer" class="notifications-container"></div>
							<!-- 
							<a id="notificationAucune" class="dropdown-item dropdown-notification" href="#">
								<p class="notification-solo text-center">Aucune nouvelle notification</p>
							</a>
							 -->
							<!-- TOUTES
							<a class="dropdown-item dropdown-notification-all" href="#"> Voir toutes les notifications </a> -->
						</div>
					</div>
				</li>
			</ul>
		</div>
	</div>
</nav>
<!-- 
    <a class="dropdown-item dropdown-notification" href="{{href}}">
      <div class="notification-read">
        <i class="fa fa-times" aria-hidden="true"></i>
      </div>
      <img class="notification-img" src="https://placehold.it/48x48" alt="Icone Notification" />
      <div class="notifications-body">
        <p class="notification-texte">{{texte}}</p>
        <p class="notification-date text-muted">
          <i class="fa fa-clock-o" aria-hidden="true"></i> {{date}}
        </p>
      </div>
    </a>
 -->