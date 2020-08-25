<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<base href="${pageContext.request.contextPath}/WebContent">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>Gérer les demandes du département - NTIC</title>
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
</head>

<body>
	<jsp:include page="/WEB-INF/espace_enseignant/shared/header_enseignant.jsp"></jsp:include>
	<main class="page landing-page">
	<section class="clean-block clean-info dark">
		<div class="container">
			<div class="row">
				<div class="col">
					<div class="block-heading">
						<h2 class="text-success">Liste des demandes</h2>
						<p>Acceptez ou refusez les demandes des enseignants ou etudiants du département.</p>
					</div>
				</div>
			</div>
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
			<div class="row">
				<div class="col">
					<div>
						<ul class="nav nav-pills nav-fill">
							<li class="nav-item demande-tab" id="demande-enseignants">
								<a class="nav-link active" role="tab" data-toggle="pill" href="#tab-demandes-enseignants">Demandes des enseignants</a>
							</li>
							<li class="nav-item demande-tab" id="demande-etudiants">
								<a class="nav-link" role="tab" data-toggle="pill" href="#tab-demandes-etudiants">Demandes des étudiants</a>
							</li>
						</ul>
						<div class="tab-content">
							<div class="tab-pane fade show" role="tabpanel" id="tab-demandes-etudiants">
								<div class="row">
									<div class="col-12 col-md-6 col-lg-3 mt-3">
										<div class="dropdown">
											<a class="btn btn-outline-success dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
												Filtrer par etat
											</a>
											<div class="dropdown-menu w-100" style="min-width:280px;">
												<form  onsubmit="return (typeof submitted == 'undefined') ? (submitted = true) : !submitted"  class="px-1">
													<div class="custom-control custom-checkbox">
													  <input type="checkbox" class="custom-control-input" name="etat_demande_etudiant" value="Valider" id="cb-demande-valide">
													  <label class="custom-control-label" for="cb-demande-valide">Demandes <span class="text-success">validées</span></label>
													</div>
													<div class="custom-control custom-checkbox">
													  <input type="checkbox" class="custom-control-input" name="etat_demande_etudiant" value="Refuser" id="cb-demande-refuse">
													  <label class="custom-control-label" for="cb-demande-refuse">Demandes <span class="text-danger">refusées</span></label>
													</div>
													<div class="custom-control custom-checkbox">
													  <input type="checkbox" class="custom-control-input" name="etat_demande_etudiant" value="Non traiter" id="cb-demande-non-traite">
													  <label class="custom-control-label" for="cb-demande-non-traite">Demandes <span class="text-warning">non traitées</span></label>
													</div>
												</form>
											</div>
										</div>
									</div>
								</div>
								<div class="table-responsive mt-3">
									<table class="table table-striped table-bordered text-center table-center" id="table-demandes-etudiants">
										<thead>
											<tr class="table-success">
												<th>Etudiant</th>
												<th>Demande</th>
												<th>Etat actuel</th>
												<th>Traiter</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="demande" items="${demandesDepartement.getDemandesCongeAcademiqueResponse()}">
												<tr>
													<td>${demande.getEtudiant().getNom()} ${demande.getEtudiant().getPrenom()}</td>
													<td>
														Demande de congé académique pour cette année universitaire
													</td>
													<c:choose>
														<c:when test="${demande.getCongeAcademique().getEtat_demande() eq 'valide'}">
															<td class="text-success">${demande.getCongeAcademique().getEtat_demande().getValue(0)}</td>
														</c:when>
														<c:when test="${demande.getCongeAcademique().getEtat_demande() eq 'refuse'}">
															<td class="text-danger">${demande.getCongeAcademique().getEtat_demande().getValue(0)}</td>
														</c:when>
														<c:when test="${demande.getCongeAcademique().getEtat_demande() eq 'nonTraite'}">
															<td class="text-warning">${demande.getCongeAcademique().getEtat_demande().getValue(0)}</td>
														</c:when>
													</c:choose>
													<td>
														<a href="${pageContext.request.contextPath}/User/ConsulterDemandeChefDepartement?type=conge&numero-conge-academique=${demande.getCongeAcademique().getNumero_conge_academique()}" class="btn btn-outline-success" role="button">Traiter</a>
													</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
							</div>
							<div class="tab-pane fade show active" role="tabpanel" id="tab-demandes-enseignants">
								<div class="row">
									<div class="col-12 col-md-6 col-lg-3 mt-3">
										<div class="dropdown">
											<a class="btn btn-outline-success dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
												Filtrer par type de demande
											</a>
											<div class="dropdown-menu w-100" style="min-width:280px;">
												<form  onsubmit="return (typeof submitted == 'undefined') ? (submitted = true) : !submitted"  class="px-1">
													<div class="custom-control custom-checkbox">
													  <input type="checkbox" class="custom-control-input" name="type_demande_enseignant" value="Séance supplémentaire" id="cb-seance-supp">
													  <label class="custom-control-label" for="cb-seance-supp">Séance supplémentaire</label>
													</div>
													<div class="custom-control custom-checkbox">
													  <input type="checkbox" class="custom-control-input" name="type_demande_enseignant" value="Changement d'horaires" id="cb-changement">
													  <label class="custom-control-label" for="cb-changement">Changement d'horaires</label>
													</div>
												</form>
											</div>
										</div>
									</div>
									<div class="col-12 col-md-6 col-lg-3 mt-3">
										<div class="dropdown">
											<a class="btn btn-outline-success dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
												Filtrer par etat
											</a>
											<div class="dropdown-menu w-100" style="min-width:280px;">
												<form  onsubmit="return (typeof submitted == 'undefined') ? (submitted = true) : !submitted"  class="px-1">
													<div class="custom-control custom-checkbox">
													  <input type="checkbox" class="custom-control-input" name="etat_demande_enseignant" value="Valider" id="cb-demandes-valide">
													  <label class="custom-control-label" for="cb-demandes-valide">Demandes <span class="text-success">validées</span></label>
													</div>
													<div class="custom-control custom-checkbox">
													  <input type="checkbox" class="custom-control-input" name="etat_demande_enseignant" value="Refuser" id="cb-demandes-refuse">
													  <label class="custom-control-label" for="cb-demandes-refuse">Demandes <span class="text-danger">refusées</span></label>
													</div>
													<div class="custom-control custom-checkbox">
													  <input type="checkbox" class="custom-control-input" name="etat_demande_enseignant" value="Non traiter" id="cb-demandes-non-traite">
													  <label class="custom-control-label" for="cb-demandes-non-traite">Demandes <span class="text-warning">non traitées</span></label>
													</div>
												</form>
											</div>
										</div>
									</div>
								</div>
								<div class="table-responsive mt-3">
									<table class="table table-striped table-bordered text-center table-center" id="table-demandes-enseignants">
										<thead>
											<tr class="table-success">
												<th>Enseignant</th>
												<th>Type de demande</th>
												<th>Demande</th>
												<th>Etat actuel</th>
												<th>Traiter</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="demande" items="${demandesDepartement.getDemandesSeanceSuppResponse()}">
												<tr>
													<td>${demande.getEnseignant().getNom()} ${demande.getEnseignant().getPrenom()}</td>
													<td>Séance supplémentaire</td>
													<td>Pour le module <b>${demande.getModule().getNom()}</b> le <b>${demande.getSeanceSupp().getJour().getValue(0)}</b> à <b>${demande.getSeanceSupp().getHeure()}</b></td>
													<c:choose>
														<c:when test="${demande.getSeanceSupp().getEtat_seance() eq 'valide'}">
															<td class="text-success">${demande.getSeanceSupp().getEtat_seance().getValue(0)}</td>
														</c:when>
														<c:when test="${demande.getSeanceSupp().getEtat_seance() eq 'refuse'}">
															<td class="text-danger">${demande.getSeanceSupp().getEtat_seance().getValue(0)}</td>
														</c:when>
														<c:when test="${demande.getSeanceSupp().getEtat_seance() eq 'nonTraite'}">
															<td class="text-warning">${demande.getSeanceSupp().getEtat_seance().getValue(0)}</td>
														</c:when>
													</c:choose>
													<td>
														<a href="${pageContext.request.contextPath}/User/ConsulterDemandeChefDepartement?type=supp&code-seance-supp=${demande.getSeanceSupp().getCode_seance_supp()}" class="btn btn-outline-success" role="button">Traiter</a>
													</td>
												</tr>
											</c:forEach>
											<c:forEach var="demande" items="${demandesDepartement.getDemandesChangementSeanceResponse()}">
												<tr>
													<td>${demande.getEnseignant().getNom()} ${demande.getEnseignant().getPrenom()}</td>
													<td>Changement d'horaires</td>
													<td>Pour le module <b>${demande.getModule().getNom()}</b> du <b>${demande.getSeance().getJour().getValue(0)}</b>, <b>${demande.getSeance().getHeure()}</b> à <b>${demande.getChangementSeance().getNouveau_jour().getValue(0)}</b>, <b>${demande.getChangementSeance().getHeure()}</b></td>
													<c:choose>
														<c:when test="${demande.getChangementSeance().getEtat_seance() eq 'valide'}">
															<td class="text-success">${demande.getChangementSeance().getEtat_seance().getValue(0)}</td>
														</c:when>
														<c:when test="${demande.getChangementSeance().getEtat_seance() eq 'refuse'}">
															<td class="text-danger">${demande.getChangementSeance().getEtat_seance().getValue(0)}</td>
														</c:when>
														<c:when test="${demande.getChangementSeance().getEtat_seance() eq 'nonTraite'}">
															<td class="text-warning">${demande.getChangementSeance().getEtat_seance().getValue(0)}</td>
														</c:when>
													</c:choose>
													<td>
														<a href="${pageContext.request.contextPath}/User/ConsulterDemandeChefDepartement?code-seance=${demande.getSeance().getCode_seance()}&type=changement" class="btn btn-outline-success" role="button">Traiter</a>
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
	</section>
	</main>
	<jsp:include page="/WEB-INF/espace_enseignant/shared/footer_enseignant.jsp"></jsp:include>
	<script src="assets/js/jquery.min.js"></script>
	<script src="assets/bootstrap/js/bootstrap.min.js"></script>
	<script src="assets/data-tables/DataTables-1.10.20/js/jquery.dataTables.min.js"></script>
	<script src="assets/data-tables/DataTables-1.10.20/js/dataTables.bootstrap4.min.js"></script>
	<script src="assets/js/smoothproducts.min.js"></script>
	<script src="assets/js/theme.js"></script>
	<script src="assets/js/custom-checkbox-handler.js"></script>
	<script src="assets/js/consulter-demandes-chef-departement.js"></script>
</body>
</html>