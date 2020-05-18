<%@page import="java.util.ArrayList"%>
<%@page import="com.helpers.SeanceResponse"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%! @SuppressWarnings("unchecked") %>
<% ArrayList<SeanceResponse> seances = (ArrayList<SeanceResponse>)session.getAttribute("seances");%>

<!DOCTYPE html>
<html>

<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
	<title>Consulter vos Séances - NTIC</title>
	<link rel="icon" href="assets/img/Logo/logo.png">
	<link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="assets/data-tables/DataTables-1.10.20/css/dataTables.bootstrap4.min.css">
	<link rel="stylesheet" href="assets/data-tables/custom-datatables.css">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat:400,400i,700,700i,600,600i">
	<link rel="stylesheet" href="assets/fonts/font-awesome.min.css">
	<link rel="stylesheet" href="assets/fonts/simple-line-icons.min.css">
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
				<c:if test="${not empty isDone && not empty message}">
					<c:choose>
						<c:when test="${isDone}">
							<div class="alert alert-success" role="alert">
			  					${message}
							</div>
						</c:when>
						<c:when test="${not isDone}">
							<div class="alert alert-danger" role="alert">
			  					${message}
							</div>
						</c:when>
					</c:choose>
					<c:remove var="isDone"/>
					<c:remove var="message"/>
				</c:if>
				<form class="form-normal">
					<div class="form-row align-items-center">
						<div class="col-12 col-md-2 my-1">
							<select class="custom-select filter-select form-control" id="select-module">
								<option selected>Module</option>
								<c:forEach var="value" items="<%=SeanceResponse.getUniqueModules(seances)%>">
									<option value="${value}">${value}</option>
								</c:forEach>
							</select>
						</div>
						<div class="col-12 col-md-2 my-1">
							<select class="custom-select filter-select form-control" id="select-groupe">
								<option selected>Groupe</option>
								<c:forEach var="value" items="<%=SeanceResponse.getUniqueGroupes(seances)%>">
									<option value="${value}">${value}</option>
								</c:forEach>
							</select>
						</div>
						<div class="col-12 col-md-2 my-1">
							<select class="custom-select filter-select form-control" id="select-jour">
								<option selected>Jour</option>
								<c:forEach var="value" items="<%=SeanceResponse.getUniqueJours(seances)%>">
									<option value="${value}">${value}</option>
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
														<c:forEach var="value" items="<%=SeanceResponse.getUniqueHeures(seances)%>">
															<option value="${value}">${value}</option>
														</c:forEach>
													</select>
												</div>
												<div class="form-group col">
													<select class="custom-select filter-select form-control" id="select-spécialité">
														<option selected>Spécialité</option>
														<c:forEach var="value" items="<%=SeanceResponse.getUniqueSpecialites(seances)%>">
															<option value="${value}">${value}</option>
														</c:forEach>
													</select>
												</div>
											</div>
											<div class="row">
												<div class="form-group col">
													<select class="custom-select filter-select form-control" id="select-année">
														<option selected>Année</option>
														<c:forEach var="value" items="<%=SeanceResponse.getUniqueAnnees(seances)%>">
															<option value="${value}">${value}</option>
														</c:forEach>
													</select>
												</div>
												<div class="form-group col">
													<select class="custom-select filter-select form-control" id="select-type">
														<option selected>Type</option>
														<c:forEach var="value" items="<%=SeanceResponse.getUniqueTypes(seances)%>">
															<option value="${value}">${value}</option>
														</c:forEach>
													</select>
												</div>
											</div>
										</div>
										<div class="modal-footer">
										        <button type="button" class="btn btn-outline-success">Appliquer</button>
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
																<div class="col-12 col-md-6 col-lg-4 form-group">
																	<button type="button" value="${seance.getSeance().getCode_seance()}" class="button-marquer btn btn-outline-primary btn-wrap">
																		Marquer la présence
																	</button>
																</div>
																<div class="col-12 col-md-6 col-lg-4 form-group">
																	<button type="button" value="${seance.getSeance().getCode_seance()}" class="button-releve btn btn-outline-success btn-wrap">
																		Relevé d'absences
																	</button>
																</div>
																<div class="col-12 col-md-12 col-lg-4 form-group">
																	<button type="button" value="${seance.getSeance().getCode_seance()}" class="button-exclus btn btn-outline-warning btn-wrap">
																		Étudiants exclus
																	</button>
																</div>
															</div>
															<div class="row justify-content-lg-center">
																<div class="col-12 col-md-6 col-lg-5 form-group">
																	<button type="button" value="${seance.getSeance().getCode_seance()}" class="button-changement btn btn-outline-info btn-wrap">Demander un changement</button>
																</div>
																<div class="col-12 col-md-6 col-lg-5 form-group">
																	<button type="button" value="${seance.getSeance().getCode_seance()}" class="button-seance-supp btn btn-outline-secondary btn-wrap">Séances Supplémentaires</button>
																</div>
															</div>
															<hr>
															<div id="content-marquer-${seance.getSeance().getCode_seance()}" style="display: none;">
																<c:choose>
																	<c:when test="${seance.hasEtudiants()}">	
																		<h6 class="text-bold">
																			<i class="fa fa-pencil fa-lg text-primary"></i> Marquer la présence du groupe ${seance.getSeance().getGroupe()}
																		</h6>
																		<div class="row">
																			<div class="col-6">
																				<h6 class="text-left text-primary">${seance.getModule().getNom()}</h6>
																			</div>
																			<div class="col-6">
																				<h6 class="text-right text-primary">Le ${seance.getSeance().getJour()} à ${seance.getSeance().getHeure()}</h6>
																			</div>
																		</div>
																		<form action="MarquerPresence" method ="post" class="form-normal marquer-presence">
																			<input type="hidden" name="code-seance" value="${seance.getSeance().getCode_seance()}">
																			<div class="table-responsive">
																				<table class="table table-striped table-bordered text-center table-center">
																					<thead>
																						<tr class="table-primary">
																							<th style="width: 80%">Étudiant</th>
																							<th style="width: 20%">Présence</th>
																						</tr>
																					</thead>
																					<tbody>
																						<c:forEach var="responseEtudiant" items="${seance.getEtudiants()}">
																							<tr>
																								<td>${responseEtudiant.getEtudiant().getNom()} ${responseEtudiant.getEtudiant().getPrenom()}</td>
																								<td>
																									<label class="checkbox-label" for="${responseEtudiant.getEtudiant().getId_utilisateur()}">
																										<input class="checkbox-input" id="${responseEtudiant.getEtudiant().getId_utilisateur()}" type="checkbox" name="${responseEtudiant.getEtudiant().getId_utilisateur()}">
																										<span class="checkbox-span">Absent</span>
																									</label>
																								</td>
																							</tr>
																						</c:forEach>
																					</tbody>
																				</table>
																			</div>
																			<hr>
																			<input type="submit" value="Valider" class="form-control mr-auto btn btn-outline-primary">
																		</form>
																	</c:when>
																	<c:otherwise>
																		<h6 class="text-bold">
																			<i class="icon-exclamation fa-lg text-primary"></i><span class="text-primary"> Aucun</span> étudiant n'est enregistré pour ce groupe
																		</h6>
																	</c:otherwise>
																</c:choose>
															</div>
															<div id="content-releve-${seance.getSeance().getCode_seance()}" style="display: none;">
																<c:choose>
																	<c:when test="${seance.hasAbsences()}">
																		<h6 class="text-bold">
																			<i class="icon-list fa-lg text-success"></i> Relevé d'absence du groupe ${seance.getSeance().getGroupe()}
																		</h6>
																		<div class="row">
																			<div class="col-6">
																				<h6 class="text-left text-success">${seance.getModule().getNom()}</h6>
																			</div>
																			<div class="col-6">
																				<h6 class="text-right text-success">Le ${seance.getSeance().getJour()} à ${seance.getSeance().getHeure()}</h6>
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
																					<c:forEach var="responseEtudiant" items="${seance.getEtudiants()}">
																						<tr>
																							<td>${responseEtudiant.getEtudiant().getNom()} ${responseEtudiant.getEtudiant().getPrenom()}</td>
																							<td>
																								<c:choose>
																								<c:when test="${responseEtudiant.getNombreAbsences() gt 0}">
																									<p>
																										<button class="btn btn-outline-success btn-wrap" type="button" data-toggle="collapse"
																											data-target="#collapse-${seance.getSeance().getCode_seance()}-${responseEtudiant.getEtudiant().getId_utilisateur()}" aria-expanded="false" aria-controls="collapseExample">Afficher
																											les absences</button>
																									</p>
																									<div class="collapse" id="collapse-${seance.getSeance().getCode_seance()}-${responseEtudiant.getEtudiant().getId_utilisateur()}">
																										<ul class="list-group list-group-flush">
																											<c:forEach var="absence" items="${responseEtudiant.getAbsences()}">
																												<li class="list-group-item list-group-item-light-success">
																													<div class="text-left">
																														Absence 
																														<c:choose>
																															<c:when test="${not absence.isJustifier()}">
																																<span class="text-danger">non justifier</span>
																															</c:when>
																															<c:otherwise>
																															<!-- TODO Ajouer telechargement ou view de la justification -->
																																<span class="text-success">justifier</span>
																															</c:otherwise>
																														</c:choose>
																														 le ${absence.getAbsence().getDate_absence()}.<span class="pull-right">
																															<button class="btn btn-icon-danger btn-icon">
																																<i class="icon-close fa-lg"></i>
																															</button>
																														</span>
																													</div>
																												</li>
																											</c:forEach>
																										</ul>
																									</div>
																								</c:when>
																								<c:otherwise>
																									<p><span class="text-success">Aucune</span> absence n'est enregistré pour cet étudiant</p>
																								</c:otherwise>
																								</c:choose>
																							</td>
																						</tr>
																					</c:forEach>
																				</tbody>
																			</table>
																		</div>
																	</c:when>
																	<c:otherwise>
																		<h6 class="text-bold">
																			<i class="icon-exclamation fa-lg text-success"></i><span class="text-success"> Aucune</span> absence n'est enregistré pour ce groupe
																		</h6>
																	</c:otherwise>
																</c:choose>
															</div>
															<div id="content-exclus-${seance.getSeance().getCode_seance()}" style="display: none;">
																<c:choose>
																	<c:when test="${seance.hasEtudiantsExclus()}">
																		<h6 class="text-bold">
																			<i class="icon-list fa-lg text-warning"></i> Liste des étudiants exclus du groupe ${seance.getSeance().getGroupe()}
																		</h6>
																		<div class="row">
																			<div class="col-6">
																				<h6 class="text-left text-warning">${seance.getModule().getNom()}</h6>
																			</div>
																			<div class="col-6">
																				<h6 class="text-right text-warning">Le ${seance.getSeance().getJour()} à ${seance.getSeance().getHeure()}</h6>
																			</div>
																		</div>
																		<div class="table-responsive-md">
																			<table class="table table-bordered text-center table-center">
																				<thead>
																					<tr class="table-warning">
																						<th style="width: 40%">Étudiant</th>
																						<th>Nombre d'absenes</th>
																						<th>Nombre d'absenes justifier</th>
																						<th>Nombre d'absenes non justifier</th>
																					</tr>
																				</thead>
																				<tbody>
																					<c:forEach var="responseEtudiant" items="${seance.getEtudiants()}">
																						<c:if test="${responseEtudiant.isExclus()}">
																							<tr>
																								<td>${responseEtudiant.getEtudiant().getNom()} ${responseEtudiant.getEtudiant().getPrenom()}</td>
																								<td>${responseEtudiant.getNombreAbsences()}</td>
																								<td>${responseEtudiant.getAbsencesJusifiter()}</td>
																								<td>${responseEtudiant.getAbsencesNonJustifier()}</td>
																							</tr>
																						</c:if>
																					</c:forEach>
																				</tbody>
																			</table>
																		</div>
																	</c:when>
																	<c:otherwise>
																		<h6 class="text-bold">
																			<i class="icon-exclamation fa-lg text-warning"></i> <span class="text-warning">Aucun</span> étudiant n'est exclu pour ce groupe
																		</h6>
																	</c:otherwise>
																</c:choose>
															</div>
															<div id="content-changement-${seance.getSeance().getCode_seance()}" style="display: none;">
																<c:choose>
																	<c:when test="${empty seance.getChangementSeance()}">
																		<h6 class="text-bold">
																			<i class="fa fa-wpforms fa-lg text-info"></i> Demander un changement
																		</h6>
																		<div class="row">
																			<div class="col-6">
																				<h6 class="text-left text-info">${seance.getModule().getNom()}</h6>
																			</div>
																			<div class="col-6">
																				<h6 class="text-right text-info">Le ${seance.getSeance().getJour()} à ${seance.getSeance().getHeure()}</h6>
																			</div>
																		</div>
																		<form action="DemanderChangementSeance" method="post" class="form-normal demander-changement">
																			<input type="hidden" name="code-seance" value="${seance.getSeance().getCode_seance()}">																			
																			<hr>
																			<div class="row">
																				<div class="col text-center text-info">
																					<label>Jour</label>
																				</div>
																			</div>
																			<div class="row">
																				<div class="form-group col">
																					<label>Ancien jour</label>
																					<input class="form-control" type="text" placeholder="${seance.getSeance().CapitalizedJour()}" readonly>
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
																			<hr>
																			<input type="submit" value="Valider" class="form-control mr-auto btn btn-outline-info">																	
																		</form>
																	</c:when>
																	<c:otherwise>
																		<h6 class="text-bold">
																			<i class="icon-exclamation fa-lg text-info"></i> Une demande de changement pour cette séance <span class="text-info">existe déjâ</span>
																		</h6>
																		<div class="row">
																			<div class="col-6">
																				<h6 class="text-left text-info">${seance.getModule().getNom()}</h6>
																			</div>
																			<div class="col-6">
																				<h6 class="text-right text-info">Le ${seance.getSeance().getJour()} à ${seance.getSeance().getHeure()}</h6>
																			</div>
																		</div>
																		<hr>
																			<div class="row">
																				<div class="col text-center text-info">
																					<label>Jour</label>
																				</div>
																			</div>
																			<div class="row">
																				<div class="form-group col">
																					<label>Ancien jour</label>
																					<input class="form-control" type="text" placeholder="${seance.getSeance().CapitalizedJour()}" readonly>
																				</div>
																				<div class="form-group col">
																					<label>Nouveau jour</label>
																					<input class="form-control" type="text" placeholder="${seance.getChangementSeance().CapitalizedJour()}" readonly>
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
																			<form class="form-normal" method="post" action="SupprimerDemandeChangement">
																				<input type="hidden" name="code-seance" value="${seance.getSeance().getCode_seance()}">
																				<input type="submit" value="Annuler la demande" class="form-control mr-auto btn btn-outline-danger">
																			</form>
																	</c:otherwise>
																</c:choose>
															</div>
															<div id="content-seance-supp-${seance.getSeance().getCode_seance()}" style="display: none;">
																<c:choose>
																	<c:when test="${not empty seance.getSeancesSupp()}">
																		<h6 class="text-bold">
																			<i class="fa fa-wpforms fa-lg text-secondary"></i> Seances supplémentaires
																		</h6>
																		<div class="row">
																			<div class="col-6">
																				<h6 class="text-left text-secondary">${seance.getModule().getNom()}</h6>
																			</div>
																			<div class="col-6">
																				<h6 class="text-right text-secondary">Le ${seance.getSeance().getJour()} à ${seance.getSeance().getHeure()}</h6>
																			</div>
																		</div>
																		<div class="table-responsive-md">
																			<table class="table table-bordered text-center table-center">
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
																							<td>${seanceSupp.getJour()}</td>
																							<td>${seanceSupp.getHeure()}</td>
																							<td>${seanceSupp.getEtat_seance()}</td>
																							<td>
																								<form action="AnnulerSeanceSupp" method="post" class="form-normal">
																									<input type="hidden" name="code-seance" value="${seanceSupp.getCode_seance()}">																			
																									<input type="hidden" name="code-seance-supp" value="${seanceSupp.getCode_seance_supp()}">																			
																									<input type="submit" value="Annuler" class="form-control mr-auto btn btn-outline-danger">
																								</form>
																							</td>
																						</tr>
																					</c:forEach>
																				</tbody>
																			</table>
																			<hr>
																			<form action="DemanderSeanceSupp" method="post" class="form-normal">
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
																		<h6 class="text-bold">
																			<i class="icon-exclamation fa-lg text-secondary"></i> <span class="text-secondary">Aucune </span>Seance supplémentaire n'est programmé
																		</h6>
																		<div class="row">
																			<div class="col-6">
																				<h6 class="text-left text-secondary">${seance.getModule().getNom()}</h6>
																			</div>
																			<div class="col-6">
																				<h6 class="text-right text-secondary">Le ${seance.getSeance().getJour()} à ${seance.getSeance().getHeure()}</h6>
																			</div>
																		</div>
																		<form action="DemanderSeanceSupp" method="post" class="form-normal">
																			<input type="hidden" name="code-seance" value="${seance.getSeance().getCode_seance()}">																			
																			<hr>
																			<div class="row">
																				<div class="col text-center text-secondary">
																					<label>Faire une demande de seance supplémentaire</label>
																				</div>
																			</div>
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
																			<hr>
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
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
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
	<script src="https://cdnjs.cloudflare.com/ajax/libs/baguettebox.js/1.10.0/baguetteBox.min.js"></script>
	<script src="assets/alertify/alertify.min.js"></script>
	<script src="assets/js/smoothproducts.min.js"></script>
	<script src="assets/js/theme.js"></script>
	<script src="assets/js/Table-With-Search.js"></script>
	<script src="assets/js/custom-checkbox-handler.js"></script>
	<script src="assets/js/consulter-seances.js"></script>
</body>

</html>