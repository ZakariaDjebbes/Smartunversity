<%@page import="java.util.ArrayList"%>
<%@page import="com.helpers.SeanceResponse"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="utf-8">
	<base href="${pageContext.request.contextPath}/WebContent">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
	<title>Consulter vos Séances - NTIC</title>
	<link rel="icon" href="assets/img/Logo/logo.png">
	<link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="assets/Datatables/datatables.min.css">
	<link rel="stylesheet" href="assets/Datatables/custom-datatables.css">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat:400,400i,700,700i,600,600i">
	<link rel="stylesheet" href="assets/fonts/font-awesome.min.css">
	<link rel="stylesheet" href="assets/fonts/simple-line-icons.min.css">
	<link rel="stylesheet" href="assets/css/style.css">
	<link rel="stylesheet" href="assets/css/filter-select.css">
	<link rel="stylesheet" href="assets/css/custom-checkbox.css">
	<link rel="stylesheet" href="assets/alertify/css/themes/bootstrap.min.css">
</head>

<body>
	<jsp:include page="/WEB-INF/espace_enseignant/shared/header_enseignant.jsp"></jsp:include>
	<main class="page">
	<section class="clean-block clean-form dark">
		<div class="container">
			<div class="block-heading">
				<h2 class="text-success">Liste de vos séances</h2>
				<p>Appliquez les opérations disponibles sur les séances que vous assurez.</p>
			</div>
			<c:choose>
			<c:when test="${empty seances}">
				<div class="alert alert-warning" role="alert">
					<h4 class="alert-heading"><i class="icon-exclamation fa-lg"></i> Il y a un problème!</h4>
				  <p>Vous n'assurez aucune séance pour le moment.
				  <br>
				   Veuillez consulter votre chef de département pour être affecter a une séance.
				  </p>
				</div>
			</c:when>
			<c:otherwise>
			<div id="data-table">
				<form  onsubmit="return (typeof submitted == 'undefined') ? (submitted = true) : !submitted"  class="form-normal">
					<div class="form-row align-items-center">
						<div class="col-12 col-md-3 my-1">
							<select class="custom-select filter-select form-control" id="select-module">
								<option selected>Module</option>
								<c:forEach var="seance" items="${seances}">
									<option value="${seance.getModule().getNom()} - (${seance.getModule().getCode_module()})">${seance.getModule().getNom()} - (${seance.getModule().getCode_module()})</option>
								</c:forEach>
							</select>
						</div>
						<div class="col-12 col-md-2 my-1">
							<select class="custom-select filter-select form-control" id="select-groupe">
								<option selected>Groupe</option>
								<c:forEach var="seance" items="${seances}">
									<option value="${seance.getSeance().getGroupe()}">${seance.getSeance().getGroupe()}</option>
								</c:forEach>
							</select>
						</div>
						<div class="col-12 col-md-2 my-1">
							<select class="custom-select filter-select form-control" id="select-jour">
								<option selected>Jour</option>
								<c:forEach var="seance" items="${seances}">
									<option value="${seance.getSeance().getJour().getValue(0)}">${seance.getSeance().getJour().getValue(0)}</option>
								</c:forEach>
							</select>
						</div>
						<div class="col-12 col-md-3 col-lg-2 my-1">
							<button type="button" class="btn btn-outline-success btn-filter" tabindex="-1" data-toggle="modal" data-target="#modal-filter">Plus d'options...</button>
							<div class="modal fade" id="modal-filter">
								<div class="modal-dialog modal-lg" role="document">
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title">Plus d'options de filtrage</h5>
											<button type="button" class="close" data-dismiss="modal" aria-label="Close">
												<span aria-hidden="true" class="text-danger">&times;</span>
											</button>
										</div>
										<div class="modal-body">
											<div class="row">
												<div class="form-group col">
													<select class="custom-select filter-select form-control" id="select-heure">
														<option selected>Heure</option>
														<c:forEach var="seance" items="${seances}">
															<option value="${seance.getSeance().getHeure()}">${seance.getSeance().getHeure()}</option>
														</c:forEach>
													</select>
												</div>
												<div class="form-group col">
													<select class="custom-select filter-select form-control" id="select-spécialité">
														<option selected>Spécialité</option>
														<c:forEach var="seance" items="${seances}">
															<option value="${seance.getSeance().getSpecialite()}">${seance.getSeance().getSpecialite().getValue(0)} - (${seance.getSeance().getSpecialite()})</option>
														</c:forEach>
													</select>
												</div>
											</div>
											<div class="row">
												<div class="form-group col">
													<select class="custom-select filter-select form-control" id="select-année">
														<option selected>Année</option>
														<c:forEach var="seance" items="${seances}">
															<option value="${seance.getSeance().getAnnee()}">${seance.getSeance().getAnnee().getValue(0)} - (${seance.getSeance().getAnnee()})</option>
														</c:forEach>
													</select>
												</div>
												<div class="form-group col">
													<select class="custom-select filter-select form-control" id="select-type">
														<option selected>Type</option>
														<c:forEach var="seance" items="${seances}">
															<option value="${seance.getSeance().getType()}">${seance.getSeance().getType().getValue(0)} - (${seance.getSeance().getType()})</option>
														</c:forEach>
													</select>
												</div>
											</div>
										</div>
										<div class="modal-footer">
												<input type="reset"class="btn btn-outline-danger" id="btn-reinit" value="Réinitialiser">
										        <button type="button" data-dismiss="modal" class="btn btn-success">Appliquer</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</form>
				<div class="table-responsive">
					<table class="table table-striped table-bordered text-center table-center" id="table-seances">
						<thead>
							<tr class="table-success">
								<th>Module</th>
								<th>Type</th>
								<th>Année</th>
								<th>Spécialité</th>
								<th>Groupe</th>
								<th>Jour</th>
								<th>Heure</th>
								<th style="width: 15%">Getion</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="seance" items="${sessionScope.seances}">
								<tr>
									<td>${seance.getModule().getNom()} - (<b>${seance.getModule().getCode_module()}</b>)</td>
									<td>${seance.getSeance().getType()}</td>
									<td>${seance.getSeance().getAnnee()}</td>
									<td>${seance.getSeance().getSpecialite()}</td>
									<td>${seance.getSeance().getGroupe()}</td>
									<td>${seance.getSeance().getJour().getValue(0)}</td>
									<td>${seance.getSeance().getHeure()}</td>
									<td style="max-width: 350px;">
									<a
											href="${pageContext.request.contextPath}/User/ConsulterSeanceEnseignant?code-seance=${seance.getSeance().getCode_seance()}"
											class="btn btn-outline-success" role="button">Consulter</a>									</td>	
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			</c:otherwise>
			</c:choose>
		</div>
	</section>
	</main>
	<jsp:include page="/WEB-INF/espace_enseignant/shared/footer_enseignant.jsp"></jsp:include>
	<script src="assets/js/jquery.min.js"></script>
	<script src="assets/bootstrap/js/bootstrap.min.js"></script>
	<script src="assets/Datatables/datatables.min.js"></script>
	
	<script src="assets/js/smoothproducts.min.js"></script>
	<script src="assets/js/theme.js"></script>
	<script src="assets/js/consulter-seances-enseignant.js"></script>
	<script src="assets/js/notifications_handler.js"></script>
</body>

</html>