<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>${seance.getModule().getNom()}</title>
<base href="${pageContext.request.contextPath}/WebContent">
<link rel="icon" href="assets/img/Logo/logo.png">
<link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="assets/data-tables/DataTables-1.10.20/css/dataTables.bootstrap4.min.css">
<link rel="stylesheet" href="assets/data-tables/custom-datatables.css">
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
	<section class="clean-block clean-info dark">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="block-heading">
						<h2 class="text-success">Consultation de séance</h2>
						<p>Marquez la présence, consulter les absences et faites vos demandes au chef de département pour cette séance.</p>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12">
					<div id="tabs-seance">
						<ul class="nav nav-pills nav-fill">
							<li class="nav-item btn-outline" id="marquer-presence">
								<a role="tab" data-toggle="pill" href="#tab-marquer-presence" class="nav-link">Marquer la présence</a>
							</li>
							<li class="nav-item" id="relever-absences">
								<a role="tab" data-toggle="pill" href="#tab-relever-absences" class="nav-link">Relever d&#39;absences</a>
							</li>
							<li class="nav-item" id="etudiants-exclus">
								<a role="tab" data-toggle="pill" href="#tab-etudiants-exclus" class="nav-link">Etudiants exclus</a>
							</li>
							<li class="nav-item" id="demande-changement">
								<a role="tab" data-toggle="pill" href="#tab-demande-changement" class="nav-link">Demande de changement</a>
							</li>
							<li class="nav-item" id="seances-supp">
								<a role="tab" data-toggle="pill" href="#tab-seances-supp" class="nav-link">Séances supplémentaires</a>
							</li>
						</ul>
						<div class="mt-4">
					    	<div class="text-left">    
					    		<h4 style="display:inline-block" class="text-success">Détails de la séance</h4>
					    		<c:if test="${utilisateur.getUser_type() eq 'chefDepartement'}">
					    			<a href="${pageContext.request.contextPath}/User/ConsulterSeanceChefDepartement?code-seance=${seance.getSeance().getCode_seance()}" style="float:right" class="badge badge-info">Consulter</a>
					    		</c:if> 
					    	</div>
							<table class="table table-sm">
								<tbody>
									<tr>
										<th style="width: 30%">Module</th>
										<td>${seance.getModule().getNom()} - (${seance.getModule().getCode_module()})</td>
									</tr>
									<tr>
										<th>Type</th>
										<td>${seance.getSeance().getType().getValue(0)} - (${seance.getSeance().getType()})</td>
									</tr>
									<tr>
										<th>Année et spécialité</th>
										<td>${seance.getSeance().getAnnee().getValue(0)} - (${seance.getSeance().getAnnee()}),${seance.getSeance().getSpecialite().getValue(0)} - (${seance.getSeance().getSpecialite()})</td>
									</tr>
									<tr>
										<th>Groupe</th>
										<td>${seance.getSeance().getGroupe()}</td>
									</tr>
									<tr>
										<th>Enseigner le:</th>
										<td>${seance.getSeance().getJour().getValue(0)} à ${seance.getSeance().getHeure()}</td>
									</tr>
								</tbody>
							</table>
						</div>
						<h4 class="text-success">Gestion de la séance</h4>
						<c:if test="${not empty isDone && not empty message}">
							<c:choose>
								<c:when test="${isDone}">
									<div class="alert alert-success alert-dismissible fade show" role="alert">
										${message}
										<button type="button" class="close" data-dismiss="alert" aria-label="Close">
											<span aria-hidden="true">&times;</span>
										</button>
									</div>
								</c:when>
								<c:when test="${not isDone}">
									<div class="alert alert-danger alert-dismissible fade show" role="alert">
										${message}
										<button type="button" class="close" data-dismiss="alert" aria-label="Close">
											<span aria-hidden="true">&times;</span>
										</button>
									</div>
								</c:when>
							</c:choose>
							<c:remove var="isDone" />
							<c:remove var="message" />
						</c:if>
						<div class="tab-content">
							<div role="tabpanel" class="tab-pane fade" id="tab-marquer-presence">
								<div class="row">
									<div class="col">
										<c:choose>
											<c:when test="${seance.hasEtudiants()}">
												<form action="${pageContext.request.contextPath}/User/MarquerPresence" method="post" class="form-normal marquer-presence">
													<input type="hidden" name="code-seance" value="${seance.getSeance().getCode_seance()}">
													<div class="table-responsive">
														<table class="table table-sm table-striped table-bordered text-center table-center" id="table-presence">
															<thead>
																<tr class="table-primary">
																	<th style="width: 30%">Nom</th>
																	<th style="width: 30%">Prenom</th>
																	<th style="width: 30%">Etat actuel</th>
																	<th style="width: 10%">Présence</th>
																</tr>
															</thead>
															<tbody>
																<c:forEach var="responseEtudiant" items="${seance.getEtudiants()}">
																	<tr>
																		<td>${responseEtudiant.getEtudiant().getNom()}</td>
																		<td>${responseEtudiant.getEtudiant().getPrenom()}</td>
																		<td>${responseEtudiant.getEtudiant().getEtat_etudiant().getValue(0)}</td>
																		<td>
																			<c:if test="${responseEtudiant.getEtudiant().getEtat_etudiant() eq 'actif'}">
																				<label class="checkbox-label" for="${responseEtudiant.getEtudiant().getId_utilisateur()}">
																					<input class="checkbox-input" id="${responseEtudiant.getEtudiant().getId_utilisateur()}" type="checkbox" name="${responseEtudiant.getEtudiant().getId_utilisateur()}">
																					<span class="checkbox-span">Absent</span>
																				</label>
																			</c:if>
																		</td>
																	</tr>
																</c:forEach>
															</tbody>
														</table>
													</div>
													<input type="submit" value="Valider" class="mt-3 form-control mr-auto btn btn-outline-primary">
												</form>
											</c:when>
											<c:otherwise>
												<div class="text-center">
													<h6 class="text-bold">
														<i class="icon-exclamation fa-lg text-primary"></i><span class="text-primary"> Aucun</span> étudiant n'est enregistré pour ce groupe
													</h6>
												</div>
											</c:otherwise>
										</c:choose>
									</div>
								</div>
							</div>
							<div role="tabpanel" class="tab-pane fade" id="tab-relever-absences">
								<c:choose>
									<c:when test="${seance.hasEtudiants()}">
										<div class="row">
											<div class="col col-12 col-md-4" style="margin-bottom: 10px;">
												<div class="text-center border rounded-0 text-center" style="background-color: rgb(195, 230, 203); padding: 13px 0px;">
													<p class="d-inline font-weight-bold">Etudiants</p>
												</div>
												<div class="select-list list-group d-block" id="list-etudiants-relever">
													<c:forEach var="etudiant" items="${seance.getEtudiants()}" varStatus="stat">
														 <c:if test="${stat.first}">
															<a class="list-group-item list-group-item-action active" id="${etudiant.getEtudiant().getId_utilisateur()}" data-toggle="list" role="tab" aria-controls="home">
																<span>${etudiant.getEtudiant().getNom()} ${etudiant.getEtudiant().getPrenom()} 
																<c:if test="${etudiant.getEtudiant().getEtat_etudiant() eq 'bloque'}">
																	<span class="badge badge-warning" style="float:right">${etudiant.getEtudiant().getEtat_etudiant().getValue(0)}</span>
																</c:if>
																</span>
															</a>											    
													    </c:if>
													    <c:if test="${!stat.first}">
															<a class="list-group-item list-group-item-action" id="${etudiant.getEtudiant().getId_utilisateur()}" data-toggle="list" role="tab" aria-controls="home">
																<span>${etudiant.getEtudiant().getNom()} ${etudiant.getEtudiant().getPrenom()}
																<c:if test="${etudiant.getEtudiant().getEtat_etudiant() eq 'bloque'}">
																	<span class="badge badge-warning" style="float:right">${etudiant.getEtudiant().getEtat_etudiant().getValue(0)}</span>
																</c:if>
																</span>
															</a>
													    </c:if>
													</c:forEach>
												</div>
												<div>
													<div class="input-group">
														<input class="form-control" type="text" id="filter-etudiants" placeholder="Cherchez un etudiant...">
														<div class="input-group-append">
															<span class="input-group-text"><i class="fa fa-search fa-lg"></i></span>
														</div>
													</div>
												</div>
											</div>
											<div class="col">
												<div class="table-responsive">
													<table class="table table-striped table-bordered table-sm" id="table-absences">
														<thead>
															<tr>
																<th class="table-success">Date</th>
																<th class="table-success">Etat</th>
																<th class="table-success">Operation</th>
															</tr>
														</thead>
														<tbody>
														</tbody>
													</table>
												</div>
											</div>
										</div>
									</c:when>
									<c:otherwise>
										<div class="text-center">
											<h6 class="text-bold">
												<i class="icon-exclamation fa-lg text-success"></i><span class="text-success"> Aucun</span> étudiant n'est enregistré pour ce groupe
											</h6>
										</div>
									</c:otherwise>
								</c:choose>
							</div>
							<div role="tabpanel" class="tab-pane fade" id="tab-etudiants-exclus">
								<div>
									<c:choose>
										<c:when test="${seance.hasEtudiantsExclus()}">
											<div class="table-responsive-md">
												<table id="table-etudiants-exclus" class="table table-bordered text-center table-sm table-center">
													<thead>
														<tr class="table-warning">
															<th>Etudiant</th>
															<th>Nombre d'absenes</th>
															<th>Nombre d'absenes justifier</th>
															<th>Nombre d'absenes non justifier</th>
														</tr>
													</thead>
													<tbody>
														<c:forEach var="responseEtudiant" items="${seance.getEtudiants()}">
															<c:if test="${responseEtudiant.isExclus()}">
																<tr>
																	<td>${responseEtudiant.getEtudiant().getNom()} ${responseEtudiant.getEtudiant().getPrenom()} 
																	<c:if test="${responseEtudiant.getEtudiant().getEtat_etudiant() eq 'bloque'}"> 
																	<b>(${responseEtudiant.getEtudiant().getEtat_etudiant().getValue(0)})</b></c:if></td>
																	<td>${responseEtudiant.getNombreAbsences()}</td>
																	<td>${responseEtudiant.getAbsencesJusifiter()}</td>
																	<td>${responseEtudiant.getAbsencesNonJustifier()}</td>
																</tr>
															</c:if>
														</c:forEach>
													</tbody>
												</table>
											</div>
											<div class="text-center">
												<div class="btn-group">
													<button type="button" class="btn btn-outline-warning dropdown-toggle" data-toggle="dropdown">Télécharger la liste au format</button>
													<div class="dropdown-menu">
														<a class="dropdown-item" id="telecharger-etudiants-exclus-excel">
															Excel <span class="float-right"><i class="text-success fa fa-lg fa-file-excel-o"></i></span>
														</a>
														<a class="dropdown-item" id="telecharger-etudiants-exclus-csv">
															CSV <span class="float-right"><i class="text-dark fa fa-lg fa-table"></i></span>
														</a>
													</div>
												</div>
											</div>
										</c:when>
										<c:otherwise>
											<div class="text-center">
												<h6 class="text-bold">
													<i class="icon-exclamation fa-lg text-warning"></i> <span class="text-warning">Aucun</span> étudiant n'est exclu pour ce groupe
												</h6>
											</div>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
							<div role="tabpanel" class="tab-pane fade" id="tab-demande-changement">
								<c:choose>
									<c:when test="${empty seance.getChangementSeance()}">
										<form action="${pageContext.request.contextPath}/User/DemanderChangementSeance" method="post" class="form-normal demander-changement">
											<input type="hidden" name="code-seance" value="${seance.getSeance().getCode_seance()}">
											<div class="row">
												<div class="col text-center text-info">
													<label>Jour</label>
												</div>
											</div>
											<div class="row">
												<div class="form-group col">
													<label>Ancien jour</label>
													<input class="form-control" type="text" placeholder="${seance.getSeance().getJour().getValue(0)}" readonly>
												</div>
												<div class="form-group col">
													<label for="nouveau-jour-${seance.getSeance().getCode_seance()}">Nouveau jour</label>
													<select class="custom-select" id="nouveau-jour-${seance.getSeance().getCode_seance()}" required name="nouveau-jour">
														<option disabled selected>Choisissez un jour</option>
														<option value="dimanche">Dimanche</option>
														<option value="lundi">Lundi</option>
														<option value="mardi">Mardi</option>
														<option value="mercredi">Mercredi</option>
														<option value="jeudi">Jeudi</option>
													</select>
												</div>
											</div>
											<div class="row">
												<div class="col form-group text-center text-info">
													<label>Heure de début</label>
												</div>
											</div>
											<div class="row">
												<div class="form-group col">
													<label>Ancienne heure</label>
													<input class="form-control" type="text" placeholder="${seance.getSeance().getHeure()}" readonly>
												</div>
												<div class="form-group col">
													<label for="nouvelle-heure-${seance.getSeance().getCode_seance()}">Nouvelle heure</label>
													<select class="custom-select" id="nouvelle-heure-${seance.getSeance().getCode_seance()}" required name="nouvelle-heure">
														<option disabled selected>Choisissez une heure</option>
														<option value="8:30">8:30</option>
														<option value="10:00">10:00</option>
														<option value="11:30">11:30</option>
														<option value="13:00">13:00</option>
														<option value="14:30">14:30</option>
													</select>
												</div>
											</div>
											<input type="submit" value="Valider" class="form-control mr-auto btn btn-outline-info">
										</form>
									</c:when>
									<c:otherwise>
										<div class="text-center">
											<h6 class="text-bold">
												<i class="icon-exclamation fa-lg text-info"></i> Une demande de changement pour cette séance <span class="text-info">existe déjâ</span>
											</h6>
										</div>
										<div class="row">
											<div class="col text-center text-info">
												<label>Jour</label>
											</div>
										</div>
										<div class="row">
											<div class="form-group col">
												<label>Ancien jour</label>
												<input class="form-control" type="text" placeholder="${seance.getSeance().getJour().getValue(0)}" readonly>
											</div>
											<div class="form-group col">
												<label>Nouveau jour</label>
												<input class="form-control" type="text" placeholder="${seance.getChangementSeance().getNouveau_jour().getValue(0)}" readonly>
											</div>
										</div>
										<hr>
										<div class="row">
											<div class="col form-group text-center text-info">
												<label>Heure de début</label>
											</div>
										</div>
										<div class="row">
											<div class="form-group col">
												<label>Ancienne heure</label>
												<input class="form-control" type="text" placeholder="${seance.getSeance().getHeure()}" readonly>
											</div>
											<div class="form-group col">
												<label>Nouvelle heure</label>
												<input class="form-control" type="text" placeholder="${seance.getChangementSeance().getHeure()}" readonly>
											</div>
										</div>
										<hr>
										<div class="row">
											<div class="text-center form-group col">
												<label>Etat de la demande:
													<c:choose>
														<c:when test="${seance.getChangementSeance().getEtat_seance() eq 'valide'}">
															<span class="text-success">${seance.getChangementSeance().getEtat_seance().getValue(0)}</span>
														</c:when>
														<c:when test="${seance.getChangementSeance().getEtat_seance() eq 'refuse'}">
															<span class="text-danger">${seance.getChangementSeance().getEtat_seance().getValue(0)}</span>
														</c:when>
														<c:when test="${seance.getChangementSeance().getEtat_seance() eq 'nonTraite'}">
															<span class="text-warning">${seance.getChangementSeance().getEtat_seance().getValue(0)}</span>
														</c:when>
													</c:choose>	
												</label>
											</div>
										</div>
										<form class="form-normal mt-3" method="post" action="${pageContext.request.contextPath}/User/SupprimerDemandeChangement">
											<input type="hidden" name="code-seance" value="${seance.getSeance().getCode_seance()}">
											<input type="submit" value="Annuler la demande" class="form-control mr-auto btn btn-outline-danger">
										</form>
									</c:otherwise>
								</c:choose>
							</div>
							<div role="tabpanel" class="tab-pane fade" id="tab-seances-supp">
								<c:choose>
									<c:when test="${not empty seance.getSeancesSupp()}">
										<div class="table-responsive-md">
											<table id="table-seances-supp" class="table table-bordered text-center table-sm table-center">
												<thead>
													<tr class="table-secondary">
														<th>Jour</th>
														<th>Heure</th>
														<th>Etat</th>
														<th>Opération</th>
													</tr>
												</thead>
												<tbody>
													<c:forEach var="seanceSupp" items="${seance.getSeancesSupp()}">
														<tr>
															<td>${seanceSupp.getJour().getValue(0)}</td>
															<td>${seanceSupp.getHeure()}</td>
															<c:choose>
																<c:when test="${seanceSupp.getEtat_seance() eq 'valide'}">
																	<td class="text-success">${seanceSupp.getEtat_seance().getValue(0)}</td>
																</c:when>
																<c:when test="${seanceSupp.getEtat_seance() eq 'refuse'}">
																	<td class="text-danger">${seanceSupp.getEtat_seance().getValue(0)}</td>
																</c:when>
																<c:when test="${seanceSupp.getEtat_seance() eq 'nonTraite'}">
																	<td class="text-warning">${seanceSupp.getEtat_seance().getValue(0)}</td>
																</c:when>
															</c:choose>	
															<td>
																<form action="${pageContext.request.contextPath}/User/AnnulerSeanceSupp" method="post" class="form-normal">
																	<input type="hidden" name="code-seance" value="${seanceSupp.getCode_seance()}">
																	<input type="hidden" name="code-seance-supp" value="${seanceSupp.getCode_seance_supp()}">
																	<input type="submit" value="Annuler" class="form-control mr-auto btn btn-outline-danger">
																</form>
															</td>
														</tr>
													</c:forEach>
												</tbody>
											</table>
											<div class="text-center mb-4 mt-4">
												<h6 class="text-dark">Demander une autre seance supplémentaire</h6>
											</div>
											<form action="${pageContext.request.contextPath}/User/DemanderSeanceSupp" method="post" class="form-normal">
												<input type="hidden" name="code-seance" value="${seance.getSeance().getCode_seance()}">
												<div class="row">
													<div class="col">
														<select class="custom-select" required name="jour-supp">
															<option disabled selected>Jour</option>
															<option value="dimanche">Dimanche</option>
															<option value="lundi">Lundi</option>
															<option value="mardi">Mardi</option>
															<option value="mercredi">Mercredi</option>
															<option value="jeudi">Jeudi</option>
														</select>
													</div>
													<div class="col">
														<select class="custom-select" required name="heure-supp">
															<option disabled selected>Heure</option>
															<option value="8:30">8:30</option>
															<option value="10:00">10:00</option>
															<option value="11:30">11:30</option>
															<option value="13:00">13:00</option>
															<option value="14:30">14:30</option>
														</select>
													</div>
													<div class="col">
														<input type="submit" value="Demander" class="form-control mr-auto btn btn-outline-secondary">
													</div>
												</div>
											</form>
										</div>
									</c:when>
									<c:otherwise>
										<div class="text-center">
											<h6 class="text-bold">
												<i class="icon-exclamation fa-lg text-secondary"></i> <span class="text-secondary">Aucune </span>Seance supplémentaire n'est programmé
											</h6>
										</div>
										<form action="${pageContext.request.contextPath}/User/DemanderSeanceSupp" method="post" class="form-normal">
											<input type="hidden" name="code-seance" value="${seance.getSeance().getCode_seance()}">
											<div class="row">
												<div class="form-group col">
													<select class="custom-select" required name="jour-supp">
														<option disabled>Choisissez un jour</option>
														<option value="dimanche">Dimanche</option>
														<option value="lundi">Lundi</option>
														<option value="mardi">Mardi</option>
														<option value="mercredi">Mercredi</option>
														<option value="jeudi">Jeudi</option>
													</select>
												</div>
											</div>
											<div class="row">
												<div class="form-group col">
													<select class="custom-select" required name="heure-supp">
														<option disabled>Choisissez une heure</option>
														<option value="8:30">8:30</option>
														<option value="10:00">10:00</option>
														<option value="11:30">11:30</option>
														<option value="13:00">13:00</option>
														<option value="14:30">14:30</option>
													</select>
												</div>
											</div>
											<input type="submit" value="Demander" class="form-control mr-auto btn btn-outline-secondary">
										</form>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	</main>
	<jsp:include page="/WEB-INF/espace_enseignant/shared/footer_enseignant.jsp"></jsp:include>
	<script src="assets/js/jquery.min.js"></script>
	<script src="assets/bootstrap/js/bootstrap.min.js"></script>
	<script src="assets/data-tables/DataTables-1.10.20/js/jquery.dataTables.min.js"></script>
	<script src="assets/data-tables/DataTables-1.10.20/js/dataTables.bootstrap4.min.js"></script>
	<script src="assets/js/smoothproducts.min.js"></script>
	<script src="assets/js/theme.js"></script>
	<script src="assets/js/table2csv.min.js"></script>
	<script src="assets/js/jquery.table2excel.min.js"></script>
	<script src="assets/js/consulter-seance-enseignant.js"></script>
	<script src="assets/js/keep-scroll.js"></script>
	<script src="assets/js/custom-checkbox-handler.js"></script>
	<script type="text/javascript">
	$(document).ready(function () {		
		let code_seance = ${seance.getSeance().getCode_seance()};
		let absences = 
		[
		<c:forEach var="etudiant" items="${seance.getEtudiants()}"> 
			<c:forEach var="absence" items="${etudiant.getAbsences()}">		
				{
					<c:if test="${absence.hasJustification()}">
					numero_justification:"${absence.GetLastJustificationByEtat().getNumero_justification()}",
					etat_absence:"${absence.GetLastJustificationByEtat().getEtat_justification().getValue(0)}",
					</c:if>
					id_etudiant:"${etudiant.getEtudiant().getId_utilisateur()}",
					numero_absence:"${absence.getAbsence().getNumero_absence()}",
					date:"${absence.getAbsence().getDate_absence()}",
					hasJustification:${absence.hasJustification()},
					isJustifier:${absence.isJustifier()},
					isNonTraite:${absence.CheckNonTraite()},
					isRefuse:${absence.CheckRefuse()},
				},
			</c:forEach>
		</c:forEach>
		]
		
		let firstId = $("#list-etudiants-relever a").attr('id');
		
		setTable(findById(absences, firstId));
		
		$('#list-etudiants-relever a').on('click', function (e) {
			  e.preventDefault()
			  let id_etudiant = $(this).attr('id');
			  let currentAbsences = findById(absences, id_etudiant);
			  
			  setTable(currentAbsences);
			});
		
		function findById(source, id) {
			let absences = [];
			  for (let i = 0; i < source.length; i++) {
			    if (source[i].id_etudiant === id) {
			      absences.push(source[i]);
			    }
			  }
			  
			return absences;
		}
		
		function setTable(absences)
		{			
			clearTable();
			
			if(absences.length == 0)
			{
				let $row = $('<tr>'+
					      '<td class="text-center" colspan="3">Cet etudiant n\'a aucune absence.</td>' +
					      '</tr>');   	
				$('table#table-absences > tbody:last').append($row);
			}
			
			for(absence of absences)
			{
				let etat;
				let textColor;
				let justificationInteraction;
				
				if(absence.isJustifier)
				{
					etat = absence.etat_absence;
					textColor = "success";
					justificationInteraction = 
					"<button type='submit' onclick='form.action=\"${pageContext.request.contextPath}/User/DownloadJustification\";' class='btn btn-icon-success btn-icon' data-toggle='tooltip' data-placement='top' title='Telecharger la justification'>"																	
						+"<i class='fa fa-download fa-lg'></i>"
					+"</button>";
				}
				else
				{
					if(!absence.hasJustification)
					{
						etat = "Non justifier";
						textColor = "danger";
						justificationInteraction = "";
						/*"<button type='submit' class='btn btn-icon-info btn-icon' data-toggle='tooltip' data-placement='top' title='Justifier cette absence'>"																	
							+"<i class='fa fa-upload fa-lg'></i>"
						+"</button>";*/
					}
					else
					{
						if(absence.isNonTraite)
						{
							etat = absence.etat_absence;
							textColor = "warning";
							justificationInteraction = "";
								/*"<button type='submit' onclick='form.action=\"${pageContext.request.contextPath}/User/DownloadJustification\";' class='btn btn-icon-success btn-icon' data-toggle='tooltip' data-placement='top' title='Telecharger la justification'>"																	
									+"<i class='fa fa-download fa-lg'></i>"
								+"</button>";*/
						}
						else if(absence.isRefuse)
						{
							etat = absence.etat_absence;
							textColor = "danger";
							justificationInteraction = "";
						}
					}
				}
								
				let operations =
				"<form class='form-normal' method='post'>"
					+"<input type='hidden' name='numero-absence' value='" + absence.numero_absence + "'>"
					+"<input type='hidden' name='id-etudiant' value='" + absence.id_etudiant + "'>"
					+"<input type='hidden' name='numero-justification' value='" + absence.numero_justification + "'>"
					+"<input type='hidden' name='code-seance' value='" + code_seance + "'>"
					+"<span class='text-right text-danger float-right' style='margin-left: 20px;'>"
						+"<button type='submit' onclick='form.action=\"${pageContext.request.contextPath}/User/SupprimerAbsence?to=/User/ConsulterSeanceEnseignant?code-seance="+ code_seance +"\";' class='btn btn-icon-danger btn-icon' data-toggle='tooltip' data-placement='top' title='Supprimer cette absence'>"
						+"	<i class='fa fa-close fa-lg'></i>"
						+"</button>"
					+"</span>"
					+"<span class='text-dark float-right' style='margin-left: 20px;'>"
						+"<a href='${pageContext.request.contextPath}/User/ConsulterAbsence?numero-absence=" + absence.numero_absence + "' class='btn btn-icon-dark btn-icon' data-toggle='tooltip' data-placement='top' title='Consulter cette absence en détails'>"																	
							+"<i class='fa fa-list-ul fa-lg'></i>"
						+"</a>"
					+"</span>"
					+"<span class='text-right float-right' id='span-dl-up'>" + justificationInteraction + "</span>"
				+"</form>"
				
				let $row = $('<tr>'+
					      '<td>' + absence.date + '</td>' +
					      '<td class="text-' + textColor + '">' + etat + '</td>' +
					      '<td>' + operations + '</td>' +
					      '</tr>');   	
				$('table#table-absences > tbody:last').append($row);
			}
		}
		
		function clearTable()
		{
			let tableTbody = $('table#table-absences tbody');
			tableTbody.empty();
		}
		
		let nombreEtudiants = ${seance.getEtudiants().size()};
		
		//filtrer etudiants >>> relever absence
		$("#filter-etudiants").on("keyup", function() {
		    let value = $(this).val().toLowerCase();
		    $("#list-etudiants-relever a span").filter(function() {
		      $(this).parent().toggle($(this).text().toLowerCase().includes(value));
		    });
		    
		    if($("#list-etudiants-relever > a:hidden").length == nombreEtudiants && !$("#empty-list-etudiants-relever").length)
		    {
		    	$("#list-etudiants-relever").append("<a class='list-group-item list-group-item-action active' id='empty-list-etudiants-relever' data-toggle='list' role='tab' aria-controls='home'>Aucun etudiant ne correspond</a>");	
		    }
		    else if ($("#list-etudiants-relever > a:hidden").length != nombreEtudiants)
		    {
		    	$("#empty-list-etudiants-relever").remove();
		    }
		  });
	});
	</script>
</body>
</html>