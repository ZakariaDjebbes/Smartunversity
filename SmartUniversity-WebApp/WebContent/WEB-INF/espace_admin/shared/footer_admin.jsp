<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${cookie['lang'].value}"/>
<fmt:setBundle basename="resources.ApplicationResources"/>
<footer class="sticky-footer bg-white">
	<div class="container my-auto">
		<div class="copyright text-center my-auto">
			<span><fmt:message key="footers.copyrights"></fmt:message></span>
		</div>
	</div>
</footer>