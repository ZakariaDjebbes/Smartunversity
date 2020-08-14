<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<footer class="page-footer  dark">
	<div class="container">
		<div class="row">
			<div class="col-6">
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
			<div class="col-6">
				<h5>Fonctionalités</h5>
				<ul>
					<li>
						<a href="${pageContext.request.contextPath}/User/ConsulterReleverAbsencesEtudiant" class="dropdown-item btn btn-link btn-footer" role="button">Relevé d'absences</a>
					</li>
					<li>
						<a href="${pageContext.request.contextPath}/User/ConsulterEmploiEtudiant" class="dropdown-item btn btn-link btn-footer" role="button">Emploi du temps</a>
					</li>
					<li>
						<a href="${pageContext.request.contextPath}/User/ConsulterCongeAcademique" class="dropdown-item btn btn-link btn-footer" role="button">Congé académique</a>
					</li>
				</ul>
			</div>
		</div>
	</div>
	<div class="footer-copyright">
		<p>© 2020 Djebbes Zakaria &amp; Ouaden Aymen - All rights reserved.</p>
	</div>
</footer>