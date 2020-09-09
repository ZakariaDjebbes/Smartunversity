<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<footer class="page-footer  dark">
	<div class="container">
		<div class="row">
			<div class="col-sm-6 col-md-4 col-lg-3">
				<h5>Accès rapide</h5>
				<ul>
					<li>
						<a href="index.jsp" class="dropdown-item btn btn-link btn-footer" role="button">Accueil</a>
					</li>
					<li>
						<a href="${pageContext.request.contextPath}/User/ModifierProfil" class="dropdown-item btn btn-link btn-footer" role="button">Votre compte</a>
					</li>
					<li>
						<a href="${pageContext.request.contextPath}/User/Logout" class="text-danger dropdown-item btn btn-link btn-footer" role="button">Se déconnecter</a>
					</li>
				</ul>
			</div>
			<div class="col-sm-6 col-md-4 col-lg-3">
				<h5>Gérer vos séances</h5>
				<ul>
					<li>
						<a href="${pageContext.request.contextPath}/User/ConsulterSeancesEnseignant" class="dropdown-item btn btn-link btn-footer" role="button">Vos séances</a>
					</li>
					<li>
						<a href="${pageContext.request.contextPath}/User/ConsulterStatistiquesEnseignant" class="dropdown-item btn btn-link btn-footer" role="button">Les statistiques</a>
					</li>
				</ul>
			</div>

			<c:if test="${utilisateur.getUser_type() eq 'chefDepartement'}">
				<div class="col-sm-6 col-md-4 col-lg-3">
					<h5>Votre département</h5>
					<ul>
						<li>
							<a href="${pageContext.request.contextPath}/User/ConsulterSeancesChefDepartement" class="dropdown-item btn btn-link btn-footer" role="button">Consulter les séances</a>

						</li>
						<li>
							<a href="${pageContext.request.contextPath}/User/ConsulterAbsencesChefDepartement" class="dropdown-item btn btn-link btn-footer" role="button">Consulter les absences</a>

						</li>
						<li>
							<a href="${pageContext.request.contextPath}/User/ConsulterDemandesChefDepartement" class="dropdown-item btn btn-link btn-footer" role="button">Consulter les demandes</a>
						</li>
						<li>
							<a href="${pageContext.request.contextPath}/User/ConsulterStatistiquesChefDepartement" class="dropdown-item btn btn-link btn-footer" role="button">Consulter les statistiques</a>
						</li>
						<li>
							<a href="${pageContext.request.contextPath}/User/ConsulterEtudiantsExclusChefDepartement" class="dropdown-item btn btn-link btn-footer" role="button">Etudiants exclus</a>
						</li>
					</ul>
				</div>
			</c:if>
		</div>
	</div>
	<div class="footer-copyright">
		<p>© 2020 Djebbes Zakaria &amp; Ouaden Aymen - All rights reserved.</p>
	</div>
</footer>