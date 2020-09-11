<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${cookie['lang'].value}"/>
<fmt:setBundle basename="resources.ApplicationResources"/>
<footer class="page-footer  dark">
	<div class="container">
		<div class="row">
			<div class="col-sm-6 col-md-4 col-lg-3">
				<h5>Accès rapide</h5>
				<ul>
					<li>
						<a href="index.jsp" class="dropdown-item btn btn-link btn-footer" role="button"><fmt:message key="footers.index"></fmt:message></a>
					</li>
					<li>
						<a href="${pageContext.request.contextPath}/User/ModifierProfil" class="dropdown-item btn btn-link btn-footer" role="button"><fmt:message key="footers.your_account"></fmt:message></a>
					</li>
					<li>
						<a href="${pageContext.request.contextPath}/User/Logout" class="text-danger dropdown-item btn btn-link btn-footer" role="button"><fmt:message key="footers.logout"></fmt:message></a>
					</li>
				</ul>
			</div>
			<div class="col-sm-6 col-md-4 col-lg-3">
				<h5><fmt:message key="footers.gestion_seances"></fmt:message></h5>
				<ul>
					<li>
						<a href="${pageContext.request.contextPath}/User/ConsulterSeancesEnseignant" class="dropdown-item btn btn-link btn-footer" role="button"><fmt:message key="footers.your_sessions"></fmt:message></a>
					</li>
					<li>
						<a href="${pageContext.request.contextPath}/User/ConsulterStatistiquesEnseignant" class="dropdown-item btn btn-link btn-footer" role="button"><fmt:message key="footers.stats"></fmt:message></a>
					</li>
				</ul>
			</div>

			<c:if test="${utilisateur.getUser_type() eq 'chefDepartement'}">
				<div class="col-sm-6 col-md-4 col-lg-3">
					<h5><fmt:message key="footers.your_departement"></fmt:message></h5>
					<ul>
						<li>
							<a href="${pageContext.request.contextPath}/User/ConsulterSeancesChefDepartement" class="dropdown-item btn btn-link btn-footer" role="button"><fmt:message key="footers.departement_seances"></fmt:message></a>

						</li>
						<li>
							<a href="${pageContext.request.contextPath}/User/ConsulterAbsencesChefDepartement" class="dropdown-item btn btn-link btn-footer" role="button"><fmt:message key="footers.departement_absences"></fmt:message></a>

						</li>
						<li>
							<a href="${pageContext.request.contextPath}/User/ConsulterDemandesChefDepartement" class="dropdown-item btn btn-link btn-footer" role="button"><fmt:message key="footers.departement_demandes"></fmt:message></a>
						</li>
						<li>
							<a href="${pageContext.request.contextPath}/User/ConsulterStatistiquesChefDepartement" class="dropdown-item btn btn-link btn-footer" role="button"><fmt:message key="footers.departement_stats"></fmt:message></a>
						</li>
						<li>
							<a href="${pageContext.request.contextPath}/User/ConsulterEtudiantsExclusChefDepartement" class="dropdown-item btn btn-link btn-footer" role="button"><fmt:message key="footers.departement_etudiants_exclus"></fmt:message></a>
						</li>
					</ul>
				</div>
			</c:if>
		</div>
	</div>
	<div class="footer-copyright">
		<p><fmt:message key="footers.copyrights"></fmt:message></p>
	</div>
</footer>