<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${cookie['lang'].value}"/>
<fmt:setBundle basename="resources.ApplicationResources"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="refresh" content="15;URL='index.jsp'">
<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title><fmt:message key="labels.error"></fmt:message> - NTIC</title>
<link rel="icon" href="assets/img/Logo/logo.png">
<link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat:400,400i,700,700i,600,600i">
<link rel="stylesheet" href="assets/fonts/font-awesome.min.css">
<link rel="stylesheet" href="assets/fonts/simple-line-icons.min.css">
<link rel="stylesheet" href="assets/css/style.css">
<style type="text/css">
#center {
	position: absolute;
	top: 50%;
	left: 50%;
	width: 500px;
	height: 300px;
	margin-left: -250px;
	margin-top: -150px;
}
</style>
</head>
<body>
	<div id="center" class="text-center">
		<h1><fmt:message key="pages.error.header"></fmt:message></h1>
		<br>
		<small><fmt:message key="pages.error.redirect_in"></fmt:message></small>
		<br>
		<hr>
		<a href="index.jsp" class="text-success"><fmt:message key="pages.error.redirect_link"></fmt:message></a>
	</div>
</body>
</html>