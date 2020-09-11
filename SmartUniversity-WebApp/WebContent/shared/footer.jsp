<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${cookie['lang'].value}"/>
<fmt:setBundle basename="resources.ApplicationResources"/>

<footer class="page-footer dark">
	<div class="container">
		<div class="row">
			<div class="col">
				<h5><fmt:message key="footers.quick_access"></fmt:message></h5>
				<ul>
					<li>
						<a href="index.jsp"><fmt:message key="footers.index"></fmt:message></a>
					</li>
					<li>
						<a href="nous-contacter"><fmt:message key="footers.contact"></fmt:message></a>
					</li>
					<li>
						<a href="login.jsp"><fmt:message key="footers.login"></fmt:message></a>
					</li>
				</ul>
			</div>
			<div class="col">
				<h5><fmt:message key="footers.contact_details"></fmt:message></h5>
				<ul class="no-ul">
					<li>
						<p class="text-white">
							<i class="fa fa-location-arrow footer-icon text-success"></i>Nouvelle Ville&nbsp;
						</p>
					</li>
					<li>
						<p class="text-white">
							<i class="fa fa-phone footer-icon text-success"></i>02365656
						</p>
					</li>
					<li>
						<p class="text-white">
							<i class="fa fa-envelope-o footer-icon text-success"></i>Université2@exe.com
						</p>
					</li>
				</ul>
			</div>
		</div>
	</div>
	<div class="footer-copyright">
		<p><fmt:message key="footers.copyrights"></fmt:message></p>
	</div>
</footer>