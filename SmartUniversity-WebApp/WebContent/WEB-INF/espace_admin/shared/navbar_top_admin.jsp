<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${cookie['lang'].value}"/>
<fmt:setBundle basename="resources.ApplicationResources"/>
<nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
	<button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
		<i class="text-success fa fa-bars"></i>
	</button>
	<ul class="navbar-nav ml-auto">
		<li class="nav-item dropdown">
			<a class="dropdown-toggle nav-link" data-toggle="dropdown" aria-expanded="false" href="#">
				<i class="fa-globe fa"></i>
			</a>
			<div class="dropdown-menu" role="menu">
				<a class="dropdown-item text-center" href="UpdateCookieLocale?cookieLocale=fr"><fmt:message key="headers.fr"></fmt:message></a>
				<a class="dropdown-item text-center" href="UpdateCookieLocale?cookieLocale=en"><fmt:message key="headers.en"></fmt:message></a>
			</div>
		</li>
		<div class="topbar-divider d-none d-sm-block"></div>
		<li class="nav-item dropdown no-arrow">
			<a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				<span class="mr-2 d-none d-lg-inline text-gray-600 small">${utilisateur.getNom()} ${utilisateur.getPrenom()} <i class="fa fa-caret-down"></i></span>
			</a>
			<div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
				<a class="dropdown-item" href="${pageContext.request.contextPath}/User/Logout">
					<i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i> <fmt:message key="headers.logout"></fmt:message>
				</a>
			</div>
		</li>
	</ul>
</nav>