<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${cookie['lang'].value}"/>
<fmt:setBundle basename="resources.ApplicationResources"/>

<nav class="navbar navbar-light navbar-expand-lg fixed-top bg-white clean-navbar">
	<div class="container">
		<a class="navbar-brand logo" href="index.jsp">
			<img src="assets/img/Logo/logo.png" style="width: 50px;" class="nav-brand-img">
			<fmt:message key="headers.faculty"></fmt:message>&nbsp;<span class="text-success"><strong>NTIC</strong></span>&nbsp;
		</a>
		<button class="navbar-toggler" data-toggle="collapse" data-target="#navcol-1">
			<span class="sr-only">Toggle navigation</span><span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navcol-1">
			<ul class="nav navbar-nav ml-auto">
				<li class="nav-item" role="presentation">
					<a class="nav-link" href="index.jsp"><fmt:message key="headers.index"></fmt:message></a>
				</li>
				<li class="nav-item" role="presentation">
					<a class="nav-link" href="nous-contacter.jsp"><fmt:message key="headers.contact"></fmt:message></a>
				</li>
				<li class="nav-item" role="presentation">
					<a class="nav-link" href="login.jsp"><fmt:message key="headers.login"></fmt:message></a>
				</li>
				<li class="nav-item dropdown">
					<a class="dropdown-toggle nav-link" data-toggle="dropdown" aria-expanded="false" href="#">
						<i class="icon-globe fa-lg"></i>
					</a>
					<div class="dropdown-menu" role="menu">
						<a class="dropdown-item" href="UpdateCookieLocale?cookieLocale=fr"><fmt:message key="headers.fr"></fmt:message></a>
						<a class="dropdown-item" href="UpdateCookieLocale?cookieLocale=en"><fmt:message key="headers.en"></fmt:message></a>
					</div>
				</li>
			</ul>
		</div>
	</div>
</nav>