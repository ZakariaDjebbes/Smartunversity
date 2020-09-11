<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${cookie['lang'].value}"/>
<fmt:setBundle basename="resources.ApplicationResources"/>

<footer class="page-footer  dark">
	<div class="container">
		<div class="row">
			<div class="col-6">
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
			<div class="col-6">
				<h5><fmt:message key="footers.features"></fmt:message></h5>
				<ul>
					<li>
						<a href="${pageContext.request.contextPath}/User/ConsulterReleverAbsencesEtudiant" class="dropdown-item btn btn-link btn-footer" role="button"><fmt:message key="footers.releve"></fmt:message></a>
					</li>
					<li>
						<a href="${pageContext.request.contextPath}/User/ConsulterEmploiEtudiant" class="dropdown-item btn btn-link btn-footer" role="button"><fmt:message key="footers.emploi"></fmt:message></a>
					</li>
					<li>
						<a href="${pageContext.request.contextPath}/User/ConsulterCongeAcademique" class="dropdown-item btn btn-link btn-footer" role="button"><fmt:message key="footers.conge_academique"></fmt:message></a>
					</li>
				</ul>
			</div>
		</div>
	</div>
	<div class="footer-copyright">
		<p><fmt:message key="footers.copyrights"></fmt:message></p>
	</div>
</footer>