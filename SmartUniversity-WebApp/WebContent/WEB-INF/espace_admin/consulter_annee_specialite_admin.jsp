<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Gestion des séances - NTIC</title>
<base href="${pageContext.request.contextPath}/WebContent">
<link rel="icon" href="assets/img/Logo/logo.png">
<link href="assets/fontawesome-sb/css/all.min.css" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
<link href="assets/css/sb-admin-2.min.css" rel="stylesheet">
<style type="text/css">
div.card-link.card:hover {
	transition: 0.35s;
	background-color: #C3E6CB;
	color: black;
}

div.card-link.card {
	transition: 0.35s;
}
</style>

</head>

<body id="page-top">
	<div id="wrapper">
		<jsp:include page="/WEB-INF/espace_admin/shared/navbar_admin.jsp"></jsp:include>
		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
				<jsp:include page="/WEB-INF/espace_admin/shared/navbar_top_admin.jsp"></jsp:include>
				<div class="container-fluid">
					<div class="card mb-4 py-3 border-bottom-success">
						<div class="card-body">
							<div class="text-center">
								<h2 class="text-success">Gérer les séances de la faculté</h2>
								<p>Sélectionnez une année et une spécialité</p>
							</div>
							<c:forEach var="entry" items="${specialitesByAnnee}">
								<c:set var="c_specialites" value="${entry.value}"></c:set>
								<c:set var="annee" value="${entry.key}"></c:set>
								<div class="row">
									<h5>${annee.getValue(0)}:</h5>
								</div>
								<div class="row">
									<c:forEach var="specialite" items="${c_specialites}">
										<div class="col-sm-6 col-lg-3 py-2">
											<div class="card card-link border-secondary  mb-3" style="max-width: 18rem;">
												<div class="card-body text-center text-seconday">
													<h5 class="card-text text-center">${annee} - ${specialite}</h5>
													<a href="${pageContext.request.contextPath}/User/ConsulterSeancesAdmin?annee=${annee}&specialite=${specialite}" class="stretched-link"></a>
												</div>
											</div>
										</div>
									</c:forEach>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
			<jsp:include page="/WEB-INF/espace_admin/shared/footer_admin.jsp"></jsp:include>
		</div>
	</div>
	<a class="scroll-to-top rounded" href="#page-top">
		<i class="fas fa-angle-up"></i>
	</a>
	<script src="assets/js/jquery.min.js"></script>
	<script src="assets/bootstrap/js/bootstrap.min.js"></script>
	<script src="assets/js/jquery.easing.min.js"></script>
	<script src="assets/js/sb-admin-2.min.js"></script>
	<script src="assets/js/Chart.min.js"></script>
</body>
</html>