<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${cookie['lang'].value}"/>
<fmt:setBundle basename="resources.ApplicationResources"/>
<ul class="navbar-nav bg-gradient-success sidebar sidebar-dark accordion" id="accordionSidebar">
	<a class="sidebar-brand d-flex align-items-center justify-content-center" href="index.jsp">
		<div class="sidebar-brand-icon">
			<img src="assets/img/Logo/logo_dark.png" style="width: 50px; height:50px">
		</div>
		<div class="sidebar-brand-text mx-3"><fmt:message key="headers.faculty"></fmt:message> NTIC</div>
	</a>
	<hr class="sidebar-divider my-0">
	<li class="nav-item">
		<a class="nav-link" href="index.jsp">
			<i class="fas fa-fw fa-home"></i> <span><fmt:message key="headers.index"></fmt:message></span>
		</a>
	</li>
	<hr class="sidebar-divider">
	<div class="sidebar-heading"><fmt:message key="headers.system"></fmt:message></div>
	<li class="nav-item">
		<a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseEtudiants" aria-expanded="true" aria-controls="collapseEtudiants">
			<i class="fas fa-fw fa-copy"></i> <span><fmt:message key="headers.gestion_etudiants"></fmt:message></span>
		</a>
		<div id="collapseEtudiants" class="collapse" aria-labelledby="headingEtudiants" data-parent="#accordionSidebar">
			<div class="bg-white py-2 collapse-inner rounded">
				<a class="collapse-item" href="${pageContext.request.contextPath}/User/AjouterEtudiantAdmin">
					<i class="fas fa-fw fa-user-plus text-success"></i> <fmt:message key="headers.ajouter_etudiant"></fmt:message>
				</a>
				<a class="collapse-item" href="${pageContext.request.contextPath}/User/ConsulterListeEtudiantsAdmin">
					<i class="fas fa-fw fa-table text-success"></i> <fmt:message key="headers.consulter_etudiants"></fmt:message>
				</a>
			</div>
		</div>
	</li>
	<li class="nav-item">
		<a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseEnseignants" aria-expanded="true" aria-controls="collapseEnseignants">
			<i class="fas fa-fw fa-copy"></i> <span><fmt:message key="headers.gestion_enseignants"></fmt:message></span>
		</a>
		<div id="collapseEnseignants" class="collapse" aria-labelledby="headingEnseignants" data-parent="#accordionSidebar">
			<div class="bg-white py-2 collapse-inner rounded">
				<a class="collapse-item" href="${pageContext.request.contextPath}/User/AjouterEnseignantAdmin">
					<i class="fas fa-fw fa-user-plus text-success"></i> <fmt:message key="headers.ajouter_enseignant"></fmt:message>
				</a>
				<a class="collapse-item" href="${pageContext.request.contextPath}/User/ConsulterListeEnseignantsAdmin">
					<i class="fas fa-fw fa-table text-success"></i> <fmt:message key="headers.consulter_enseignants"></fmt:message>
				</a>
			</div>
		</div>
	</li>
	<li class="nav-item">
		<a class="nav-link" href="${pageContext.request.contextPath}/User/ConsulterAnneeSpecialiteAdmin">
			<i class="fas fa-fw fa-table"></i> <span><fmt:message key="headers.gestion_seances"></fmt:message></span>
		</a>
	</li>
	<li class="nav-item">
		<a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseModules" aria-expanded="true" aria-controls="collapseModules">
			<i class="fas fa-fw fa-copy"></i> <span><fmt:message key="headers.gestion_modules"></fmt:message></span>
		</a>
		<div id="collapseModules" class="collapse" aria-labelledby="headingModules" data-parent="#accordionSidebar">
			<div class="bg-white py-2 collapse-inner rounded">
				<a class="collapse-item" href="${pageContext.request.contextPath}/User/AjouterModuleAdmin">
					<i class="fas fa-fw fa-scroll text-success"></i> <fmt:message key="headers.ajouter_module"></fmt:message>
				</a>
				<a class="collapse-item" href="${pageContext.request.contextPath}/User/ConsulterListeModulesAdmin">
					<i class="fas fa-fw fa-table text-success"></i> <fmt:message key="headers.liste_modules"></fmt:message>
				</a>
			</div>
		</div>
	</li>
	<hr class="sidebar-divider">
	<li class="nav-item">
		<a class="nav-link" href="${pageContext.request.contextPath}/User/Logout">
			<i class="fas fa-fw fa-power-off"></i> <span><fmt:message key="headers.logout"></fmt:message></span>
		</a>
	</li>
	<hr class="sidebar-divider d-none d-md-block">
	<div class="text-center d-none d-md-inline">
		<button class="rounded-circle border-0" id="sidebarToggle"></button>
	</div>
</ul>