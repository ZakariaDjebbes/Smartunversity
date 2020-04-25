<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<footer class="page-footer dark">
	<div class="container">
		<div class="row">
			<div class="col-sm-3">
				<h5>Accès rapide</h5>
				<ul>
					<li>
						<form method="post" action="FormLink">
							<input type="hidden" name="link" value="/WEB-INF/espace_enseignant/index_enseignant.jsp">
							<button type="submit" class="dropdown-item btn btn-link btn-footer" role="presentation">Acceuil</button>
						</form>
					</li>
					<li>
						<form method="post" action="FormLink">
							<input type="hidden" name="link" value="Logout">
							<button type="submit" class="dropdown-item btn btn-link btn-footer" role="presentation">Se Déconnecter</button>
						</form>
					</li>
				</ul>
			</div>
			<div class="col-sm-3">
				<h5>Gérer les absences</h5>
				<ul>
					<li><a href="#">Marquer la présence</a></li>
					<li><a href="#">Consulter le relevé d'absences</a></li>
					<li><a href="#">Etablir la liste des exclus</a></li>
					<li><a href="#">Consulter les statistiques</a></li>
				</ul>
			</div>
			<div class="col-sm-3">
				<h5>Faire vos demandes</h5>
				<ul>
					<li>
						<form method="post" action="FormLink">
							<input type="hidden" name="link" value="/WEB-INF/espace_enseignant/modifier_profil_enseignant.jsp">
							<button type="submit" class="dropdown-item btn btn-link btn-footer" role="presentation">Modifier mon profil</button>
						</form>
					</li>
					<li>
						<form method="post" action="FormLink">
							<input type="hidden" name="link" value="WEB-INF/espace_enseignant/supprimer_profil_enseignant.jsp">
							<button type="submit" class="dropdown-item btn btn-link btn-footer" role="presentation">Supprimer mon profil</button>
						</form>
					</li>
				</ul>
			</div>
		</div>
	</div>
	<div class="footer-copyright">
		<p>© 2020 Djebbes Zakaria &amp; Ouaden Aymen - All rights reserved.</p>
	</div>
</footer>