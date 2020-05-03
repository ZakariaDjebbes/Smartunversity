<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>Login - Brand</title>
<link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat:400,400i,700,700i,600,600i">
<link rel="stylesheet" href="assets/fonts/font-awesome.min.css">
<link rel="stylesheet" href="assets/fonts/simple-line-icons.min.css">
<link rel="stylesheet" href="assets/css/Data-Table.css">
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.15/css/dataTables.bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/baguettebox.js/1.10.0/baguetteBox.min.css">
<link rel="stylesheet" href="assets/css/Pretty-Search-Form.css">
<link rel="stylesheet" href="assets/css/style.css">
<link rel="stylesheet" href="assets/css/filter-select.css">
<link rel="stylesheet" href="assets/css/custom-checkbox.css">
<link rel="stylesheet" href="assets/alertify/css/alertify.min.css">
<link rel="stylesheet" href="assets/alertify/css/themes/bootstrap.min.css">

</head>

<body>
	<jsp:include page="/WEB-INF/espace_enseignant/shared/header_enseignant.jsp"></jsp:include>
	<main class="page">
	<section class="clean-block clean-form">
		<div class="container">
			<div class="block-heading">
				<h2 class="text-success">Liste de vos séances</h2>
				<p>Appliquez les opérations disponibles sur les séances que vous assurez.</p>
			</div>
			<div id="data-table">
				<form class="form-normal">
					<div class="form-row align-items-center">
						<div class="col-12 col-md-2 my-1">
							<select class="custom-select filter-select form-control">
								<option selected>Module</option>
								<option value="1">One</option>
								<option value="2">Two</option>
								<option value="3">Three</option>
							</select>
						</div>
						<div class="col-12 col-md-2 my-1">
							<select class="custom-select filter-select form-control">
								<option selected>Groupe</option>
								<option value="1">One</option>
								<option value="2">Two</option>
								<option value="3">Three</option>
							</select>
						</div>
						<div class="col-12 col-md-2 my-1">
							<select class="custom-select filter-select form-control">
								<option selected>Jour</option>
								<option value="1">One</option>
								<option value="2">Two</option>
								<option value="3">Three</option>
							</select>
						</div>
						<div class="col-12 col-md-3 col-lg-2 my-1">
							<button class="btn btn-outline-success btn-filter form-control">Plus d'options...</button>
						</div>
					</div>
				</form>
				<div class="table-responsive">
					<table class="table table-striped table-bordered text-center table-center">
						<thead>
							<tr class="table-success">
								<th>Module</th>
								<th>Type</th>
								<th>Année</th>
								<th>Spécialité</th>
								<th>Groupe</th>
								<th>Le</th>
								<th>À</th>
								<th>Opérations</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="seance" items="${sessionScope.seances}">
								<tr>
									<td>${seance.getModule().getNom()}</td>
									<td>${seance.getSeance().getType()}</td>
									<td>${seance.getSeance().getAnnee()}</td>
									<td>${seance.getSeance().getSpecialite()}</td>
									<td>${seance.getSeance().getGroupe()}</td>
									<td>${seance.getSeance().CapitalizedJour()}</td>
									<td>${seance.getSeance().getHeure()}</td>
									<td style="max-width: 350px;">
										<button class="btn btn-outline-success btn-wrap" tabindex="-1" data-toggle="modal" data-target="#modal-${seance.getSeance().getCode_seance()}">Gérer séance</button>
										<div class="modal fade" id="modal-${seance.getSeance().getCode_seance()}">
											<div class="modal-dialog modal-lg" role="document">
												<div class="modal-content">
													<div class="modal-header">
														<h5 class="modal-title" id="exampleModalLabel">${seance.getModule().getNom()}</h5>
														<button type="button" class="close" data-dismiss="modal" aria-label="Close">
															<span aria-hidden="true" class="text-danger">&times;</span>
														</button>
													</div>
													<div class="modal-body">
														<div class="container-fluid">
															<div class="row">
																<div class="col-12 col-md-6 col-lg-3 form-group">
																	<button type="button" value="${seance.getSeance().getCode_seance()}" class="button-marquer btn btn-outline-primary btn-wrap">
																		Marquer la
																		<br class="d-none d-sm-none d-md-none d-lg-block">
																		présence
																	</button>
																</div>
																<div class="col-12 col-md-6 col-lg-3 form-group">
																	<button type="button" value="${seance.getSeance().getCode_seance()}" class="button-releve btn btn-outline-success btn-wrap">
																		Relevé
																		<br class="d-none d-sm-none d-md-none d-lg-block">
																		d'absences
																	</button>
																</div>
																<div class="col-12 col-md-6 col-lg-3 form-group">
																	<button type="button" value="${seance.getSeance().getCode_seance()}" class="button-exclus btn btn-outline-warning btn-wrap">
																		Étudiants
																		<br class="d-none d-sm-none d-md-none d-lg-block">
																		exclus
																	</button>
																</div>
																<div class="col-12 col-md-6 col-lg-3 form-group">
																	<button type="button" value="${seance.getSeance().getCode_seance()}" class="button-changement btn btn-outline-info btn-wrap">Demander un changement</button>
																</div>
															</div>
															<hr>
															<div id="content-marquer-${seance.getSeance().getCode_seance()}" style="display: none;">
																<h6 class="text-bold">
																	<i class="fa fa-pencil fa-lg text-success"></i> Marquer la présence du groupe ${seance.getSeance().getGroupe()}
																</h6>
																<div class="row">
																	<div class="col-6">
																		<h6 class="text-left text-info">${seance.getModule().getNom()}</h6>
																	</div>
																	<div class="col-6">
																		<h6 class="text-right text-info">Le ${seance.getSeance().getJour()} à ${seance.getSeance().getHeure()}</h6>
																	</div>
																</div>
																<form action="MarquerPresence" class="form-normal marquer-presence">
																	<input type="hidden" name="code_seance" value="${seance.getSeance().getCode_seance()}">
																	<div class="table-responsive">
																		<table class="table table-striped table-bordered text-center table-center">
																			<thead>
																				<tr class="table-success">
																					<th style="width: 80%">Étudiant</th>
																					<th style="width: 20%">Présence</th>
																				</tr>
																			</thead>
																			<tbody>
																				<c:forEach var="dot_etudiant" items="${seance.getDot_Etudiants()}">
																					<tr>
																						<td>${dot_etudiant.getEtudiant().getNom()} ${dot_etudiant.getEtudiant().getPrenom()}</td>
																						<td>
																							<label class="checkbox-label" for="${dot_etudiant.getEtudiant().getId_utilisateur()}">
																								<input class="checkbox-input" id="${dot_etudiant.getEtudiant().getId_utilisateur()}" type="checkbox" name="${etudiant.getId_utilisateur()}">
																								<span class="checkbox-span">Absent</span>
																							</label>
																						</td>
																					</tr>
																				</c:forEach>
																			</tbody>
																		</table>
																	</div>
																	<hr>
																	<input type="submit" value="Valider" class="form-control mr-auto btn btn-outline-success">
																</form>
															</div>
															<div id="content-exclus-${seance.getSeance().getCode_seance()}" style="display: none;">
																<span class="text-danger">PH >>></span> Liste des étudiants exclus
															</div>
															<div id="content-changement-${seance.getSeance().getCode_seance()}" style="display: none;">
																<span class="text-danger">PH >>></span> Formulaire d'une demande de changement de seance
															</div>
															<div id="content-releve-${seance.getSeance().getCode_seance()}" style="display: none;">
																<h6 class="text-bold">
																	<i class="icon-list fa-lg text-success"></i> Relevé d'absence du groupe ${seance.getSeance().getGroupe()}
																</h6>
																<div class="row">
																	<div class="col-6">
																		<h6 class="text-left text-info">${seance.getModule().getNom()}</h6>
																	</div>
																	<div class="col-6">
																		<h6 class="text-right text-info">Le ${seance.getSeance().getJour()} à ${seance.getSeance().getHeure()}</h6>
																	</div>
																</div>
																<div class="table-responsive-md">
																	<table class="table table-bordered text-center table-center">
																		<thead>
																			<tr class="table-success">
																				<th style="width: 25%">Étudiant</th>
																				<th style="width: 75%">Absences</th>
																			</tr>
																		</thead>
																		<tbody>
																			<c:forEach var="dot_etudiant" items="${seance.getDot_Etudiants()}">
																				<tr>
																					<td>${dot_etudiant.getEtudiant().getNom()} ${dot_etudiant.getEtudiant().getPrenom()}</td>
																					<td>
																						<p>
																							<button class="btn btn-outline-success btn-wrap" type="button" data-toggle="collapse"
																								data-target="#collapse-${sence.getSeance().getCode_seance()}-${dot_etudiant.getEtudiant().getId_utilisateur()}" aria-expanded="false" aria-controls="collapseExample">Afficher
																								les absences</button>
																						</p>
																						<div class="collapse" id="collapse-${sence.getSeance().getCode_seance()}-${dot_etudiant.getEtudiant().getId_utilisateur()}">
																							<ul class="list-group list-group-flush">
																								<c:forEach var="absence" items="${dot_etudiant.getAbsences()}">
																									<li class="list-group-item list-group-item-light-success">
																										<div class="text-left">
																											Absence <span class="text-danger">non justifier</span> le ${absence.getDate_absence()}.<span class="pull-right">
																												<button class="btn btn-icon-danger btn-icon">
																													<i class="icon-close fa-lg"></i>
																												</button>
																											</span>
																										</div>
																									</li>
																								</c:forEach>
																							</ul>
																						</div>
																					</td>
																				</tr>
																			</c:forEach>
																		</tbody>
																	</table>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			<form action="" method="" class="form-normal">
				<div class="form-group text-center">
					<button type="submit" class="btn btn-success btn-success-inverted form-control">Demander une séance supplémentaire</button>
				</div>
			</form>
		</div>
	</section>
	</main>
	<jsp:include page="/WEB-INF/espace_enseignant/shared/footer_enseignant.jsp"></jsp:include>

	<script src="assets/js/jquery.min.js"></script>
	<script src="assets/bootstrap/js/bootstrap.min.js"></script>
	<script src="https://cdn.datatables.net/1.10.15/js/jquery.dataTables.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/baguettebox.js/1.10.0/baguetteBox.min.js"></script>
	<script src="https://cdn.datatables.net/1.10.15/js/dataTables.bootstrap.min.js"></script>
	<script src="assets/alertify/alertify.min.js"></script>
	<script src="assets/js/smoothproducts.min.js"></script>
	<script src="assets/js/theme.js"></script>
	<script src="assets/js/Table-With-Search.js"></script>
	<script src="assets/js/custom-checkbox-handler.js"></script>
	<script src="assets/js/consulter-seances.js"></script>
</body>

</html>