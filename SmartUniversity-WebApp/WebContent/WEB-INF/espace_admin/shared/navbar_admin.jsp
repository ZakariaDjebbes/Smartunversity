<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<ul class="navbar-nav bg-gradient-success sidebar sidebar-dark accordion" id="accordionSidebar">
	<a class="sidebar-brand d-flex align-items-center justify-content-center" href="index.jsp">
		<div class="sidebar-brand-icon">
			<img src="assets/img/Logo/logo_dark.png" style="width: 50px; height:50px">
		</div>
		<div class="sidebar-brand-text mx-3">Faculté NTIC</div>
	</a>
	<hr class="sidebar-divider my-0">
	<li class="nav-item">
		<a class="nav-link" href="index.jsp">
			<i class="fas fa-fw fa-home"></i> <span>Acceuil</span>
		</a>
	</li>
	<hr class="sidebar-divider">
	<div class="sidebar-heading">Gestion du système</div>
	<li class="nav-item">
		<a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseEtudiants" aria-expanded="true" aria-controls="collapseEtudiants">
			<i class="fas fa-fw fa-copy"></i> <span>Gestion des étudiants</span>
		</a>
		<div id="collapseEtudiants" class="collapse" aria-labelledby="headingEtudiants" data-parent="#accordionSidebar">
			<div class="bg-white py-2 collapse-inner rounded">
				<a class="collapse-item" href="${pageContext.request.contextPath}/User/AjouterEtudiantAdmin">
					<i class="fas fa-fw fa-user-plus text-success"></i> Ajouter un étudiant
				</a>
				<a class="collapse-item" href="${pageContext.request.contextPath}/User/ConsulterListeEtudiantsAdmin">
					<i class="fas fa-fw fa-table text-success"></i> Liste des étudiants
				</a>
			</div>
		</div>
	</li>
	<li class="nav-item">
		<a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseEnseignants" aria-expanded="true" aria-controls="collapseEnseignants">
			<i class="fas fa-fw fa-copy"></i> <span>Gestion des enseignants</span>
		</a>
		<div id="collapseEnseignants" class="collapse" aria-labelledby="headingEnseignants" data-parent="#accordionSidebar">
			<div class="bg-white py-2 collapse-inner rounded">
				<a class="collapse-item" href="${pageContext.request.contextPath}/User/AjouterEnseignantAdmin">
					<i class="fas fa-fw fa-user-plus text-success"></i> Ajouter un enseignant
				</a>
				<a class="collapse-item" href="${pageContext.request.contextPath}/User/ConsulterListeEnseignantsAdmin">
					<i class="fas fa-fw fa-table text-success"></i> Liste des enseignant
				</a>
			</div>
		</div>
	</li>
	<li class="nav-item">
		<a class="nav-link" href="${pageContext.request.contextPath}/User/ConsulterAnneeSpecialiteAdmin">
			<i class="fas fa-fw fa-table"></i> <span>Gérer les séances</span>
		</a>
	</li>
	<li class="nav-item">
		<a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseModules" aria-expanded="true" aria-controls="collapseModules">
			<i class="fas fa-fw fa-copy"></i> <span>Gestion des modules</span>
		</a>
		<div id="collapseModules" class="collapse" aria-labelledby="headingModules" data-parent="#accordionSidebar">
			<div class="bg-white py-2 collapse-inner rounded">
				<a class="collapse-item" href="${pageContext.request.contextPath}/User/AjouterModuleAdmin">
					<i class="fas fa-fw fa-scroll text-success"></i> Ajouter un module
				</a>
				<a class="collapse-item" href="${pageContext.request.contextPath}/User/ConsulterListeModulesAdmin">
					<i class="fas fa-fw fa-table text-success"></i> Liste des modules
				</a>
			</div>
		</div>
	</li>
	<hr class="sidebar-divider">
	<li class="nav-item">
		<a class="nav-link" href="${pageContext.request.contextPath}/User/Logout">
			<i class="fas fa-fw fa-power-off"></i> <span>Se déconnecter</span>
		</a>
	</li>
	<hr class="sidebar-divider d-none d-md-block">
	<div class="text-center d-none d-md-inline">
		<button class="rounded-circle border-0" id="sidebarToggle"></button>
	</div>
</ul>