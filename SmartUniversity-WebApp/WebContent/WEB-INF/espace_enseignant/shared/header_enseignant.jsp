<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<nav class="navbar navbar-light navbar-expand-xl fixed-top bg-white clean-navbar">
	<div class="container">
		<a class="navbar-brand logo" href="#"><img src="assets/img/Logo/logo.png" style="width: 50px;">Faculté&nbsp;<span class="text-success"><strong>NTIC</strong></span>&nbsp;</a>
		<button class="navbar-toggler" data-toggle="collapse" data-target="#navcol-1">
			<span class="sr-only">Toggle navigation</span><span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navcol-1">
			<ul class="nav navbar-nav ml-auto">
				<li class="nav-item" role="presentation">
					<form method="post" action="FormLink">
						<input type="hidden" name="link" value="/WEB-INF/espace_enseignant/index_enseignant.jsp">
						<button type="submit" class="dropdown-item btn btn-link btn-nav" role="presentation">Acceuil</button>
					</form>
				</li>
				<li class="nav-item dropdown"><a class="dropdown-toggle nav-link" data-toggle="dropdown" aria-expanded="false" href="#">Gérer les absences</a>
					<div class="dropdown-menu" role="menu">
						<form method="post" action="FormLink">
							<input type="hidden" name="link" value="/WEB-INF/espace_enseignant/index_enseignant.jsp">
							<button type="submit" class="dropdown-item btn btn-link btn-nav" role="presentation">Marquer la présence</button>
						</form>
						<form method="post" action="FormLink">
							<input type="hidden" name="link" value="/WEB-INF/espace_enseignant/index_enseignant.jsp">
							<button type="submit" class="dropdown-item btn btn-link btn-nav" role="presentation">Consulter les relevés d'absences</button>
						</form>
						<form method="post" action="FormLink">
							<input type="hidden" name="link" value="/WEB-INF/espace_enseignant/index_enseignant.jsp">
							<button type="submit" class="dropdown-item btn btn-link btn-nav" role="presentation">Etablir la liste des étudiants exclus d'un groupe</button>
						</form>
						<form method="post" action="FormLink">
							<input type="hidden" name="link" value="/WEB-INF/espace_enseignant/index_enseignant.jsp">
							<button type="submit" class="dropdown-item btn btn-link btn-nav" role="presentation">Consulter les statistiques d'un groupe</button>
						</form>
					</div>
				</li>
				<li class="nav-item dropdown"><a class="dropdown-toggle nav-link" data-toggle="dropdown" aria-expanded="false" href="#">Faire une demande</a>
					<div class="dropdown-menu" role="menu">
						<form method="post" action="FormLink">
							<input type="hidden" name="link" value="/WEB-INF/espace_enseignant/index_enseignant.jsp">
							<button type="submit" class="dropdown-item btn btn-link btn-nav" role="presentation">Demander l'ajout d'une séance</button>
						</form>
						<form method="post" action="FormLink">
							<input type="hidden" name="link" value="/WEB-INF/espace_enseignant/index_enseignant.jsp">
							<button type="submit" class="dropdown-item btn btn-link btn-nav" role="presentation">Demander le changement d'une séance</button>
						</form>
					</div>
				</li>
				<li class="nav-item dropdown"><a class="dropdown-toggle nav-link" data-toggle="dropdown" aria-expanded="false" href="#">Gérer votre Profil</a>
					<div class="dropdown-menu" role="menu">
						<form method="post" action="FormLink">
							<input type="hidden" name="link" value="/WEB-INF/espace_enseignant/modifier_profil_enseignant.jsp">
							<button type="submit" class="dropdown-item btn btn-link btn-nav" role="presentation">Modifier mon profil</button>
						</form>
						<form method="post" action="FormLink">
							<input type="hidden" name="link" value="/WEB-INF/espace_enseignant/supprimer_profil_enseignant.jsp">
							<button type="submit" class="dropdown-item btn btn-link btn-nav" role="presentation">Supprimer mon profil</button>
						</form>
						  <div class="dropdown-divider"></div>
						<form method="post" action="Logout">
							<button type="submit" class="dropdown-item btn btn-link btn-nav text-danger" role="presentation">Se déconnecter</button>
						</form>
					</div></li>
				<li class="nav-item dropdown"><a class="dropdown-toggle nav-link" data-toggle="dropdown" aria-expanded="false" href="#"><img src="assets/img/Logo/french_flag.png"
						style="width: 25px; margin-right: 10px;">Français (FR)</a>
					<div class="dropdown-menu" role="menu">
						<a class="dropdown-item" role="presentation" href="#"><img src="assets/img/Logo/english_flag.png" style="width: 25px; margin-right: 10px;">English (EN)</a><a class="dropdown-item"
							role="presentation" href="#"><img src="assets/img/Logo/arabic_flag.png" style="width: 25px; margin-right: 10px;">العربية &nbsp; &nbsp; &nbsp; (AR)</a>
					</div></li>
			</ul>
		</div>
	</div>
</nav>