<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
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
<link rel="stylesheet" href="assets/css/Filter.css">
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.15/css/dataTables.bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/baguettebox.js/1.10.0/baguetteBox.min.css">
<link rel="stylesheet" href="assets/css/Pretty-Search-Form.css">
<link rel="stylesheet" href="assets/css/style.css">
</head>

<body>
	<jsp:include page="/WEB-INF/espace_enseignant/shared/header_enseignant.jsp"></jsp:include>
	<main class="page login-page">
	<section class="clean-block clean-form">
		<div class="container">
			<div class="block-heading">
				<h2 class="text-success">Liste de vos séances</h2>
			</div>
			<div id="data-table">
				<form class="form-normal shadow p-3 mb-5 rounded">
					<div class="form-row">
						<div class="col col-12 col-lg-8">
							<div class="form-group">
								<label class="text-center text-black-50 d-block">Nom module</label><select class="form-control"><option value="12" selected=""></option>
									<option value="13">This is item 2</option>
									<option value="14">This is item 3</option></select>
							</div>
						</div>
						<div class="col col-12 col-lg-4">
							<div class="form-group">
								<label class="text-center text-black-50 d-block">Section</label><select class="form-control"><option value="12" selected=""></option>
									<option value="13">This is item 2</option>
									<option value="14">This is item 3</option></select>
							</div>
						</div>
						<div class="col col-12 col-lg-4">
							<div class="form-group">
								<label class="text-center text-black-50 d-block">Groupe</label><select class="form-control"><option value="12" selected=""></option>
									<option value="13">This is item 2</option>
									<option value="14">This is item 3</option></select>
							</div>
						</div>
						<div class="col col-12 col-lg-4">
							<div class="form-group">
								<label class="text-center text-black-50 d-block">Jour</label><select class="form-control"><option value="12" selected=""></option>
									<option value="13">This is item 2</option>
									<option value="14">This is item 3</option></select>
							</div>
						</div>
						<div class="col col-12 col-lg-4">
							<div class="form-group">
								<label class="text-center text-black-50 d-block">Horaire</label><select class="form-control selectpicker"><option value="12" selected=""></option>
									<option value="13">This is item 2</option>
									<option value="14">This is item 3</option></select>
							</div>
						</div>
					</div>
					<div class="form-group text-center">
						<button class="btn btn-outline-success form-control" type="button" style="width: 180px;">Filtrer</button>
					</div>
				</form>
				<form class="search-form form-normal form-search">
					<div class="input-group">
						<div class="input-group-prepend">
							<span class="input-group-text"><i class="fa fa-search"></i></span>
						</div>
						<input class="form-control" type="text" placeholder="Je cherche...">
						<div class="input-group-append">
							<button class="btn btn-success btn-success-inverted" type="button">Chercher</button>
						</div>
					</div>
				</form>
				<div class="table-responsive">
					<table class="table table-striped table-bordered text-center table-center">
						<thead>
							<tr class="table-success">
								<th>Nom module</th>
								<th>Type</th>
								<th>Année</th>
								<th>Spécialité</th>
								<th>Section</th>
								<th>Groupe</th>
								<th>Le</th>
								<th>À</th>
								<th>Opérations</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="seance" items="${sessionScope.seances}">
								<tr>
									<td>
										${seance.getModule().getNom()}
									</td>
									<td>
										${seance.getSeance().getType()}
									</td>
									<td>
										${seance.getSeance().getAnnee()}
									</td>
									<td>
										${seance.getSeance().getSpecialite()}
									</td>
									<td>
										${seance.getSeance().getSection()}
									</td>
									<td>
										${seance.getSeance().getGroupe()}
									</td>
									<td>
										${seance.getSeance().CapitalizedJour()}
									</td>
									<td>
										${seance.getSeance().getHeure()}
									</td>
									<td>
										<button class="btn btn-outline-success form-control" tabindex="-1" data-toggle="modal" data-target="#modal${seance.getSeance().getCode_seance()}">Marquer la présence</button>
										<div class="modal fade" id="modal${seance.getSeance().getCode_seance()}">
										  <div class="modal-dialog modal-lg" role="document">
										    <div class="modal-content">
										      <div class="modal-header">
										        <h5 class="modal-title text-success" id="exampleModalLabel">${seance.getModule().getNom()} <span class="text-danger">Place holder >>> Méthode manuelle</span></h5>
										        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
										          <span aria-hidden="true" class="text-danger">&times;</span>
										        </button>
										      </div>
										      <div class="modal-body">
													<div class="text-center">
														<h6>Liste des étudiants du groupe ${seance.getSeance().getGroupe()}</h6>
														<small><em>Cochez les cases des étudiants présents.</em></small>
													</div>
													<table class="table table-striped table-bordered text-center table-center">
														<thead>
															<tr class="table-success">
																<th>Nom</th>
																<th>Prénom</th>
																<th>Date de naissance</th>
																<th>Présence</th>
															</tr>
														</thead>
														<tbody>
															<c:forEach var="etudiant" items="${seance.getEtudiants()}">
												      			<tr>
												      				<td>
												      					${etudiant.getNom()}
												      				</td>
												      				<td>
												      					${etudiant.getPrenom()}
												      				</td>
												      				<td>
												      					${etudiant.getDate()}
												      				</td>
												      				<td>
												      				</td>
												      			</tr>
												      		</c:forEach>
											      		</tbody>
										      		</table>
										      		<div class="modal-footer row-bottom">
										      			<input type="submit" value="Valider" class="form-control mr-auto btn btn-outline-success">
										      			<input type="reset" value="Réinitialiser" class="form-control btn btn-outline-danger">
										      		</div>
										       </div>
										    </div>
										  </div>
										</div>
										<button class="btn btn-outline-info btn-margin-top form-control">Demander un changement</button>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div>
			<form action="" method="" class="form-normal">
				<div class="form-group text-center">
					<button type="submit" class="btn btn-success btn-success-inverted">Demander l'ajout</button>
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
	<script src="assets/js/smoothproducts.min.js"></script>
	<script src="assets/js/theme.js"></script>
	<script src="assets/js/script.js"></script>
	<script src="assets/js/Table-With-Search.js"></script>
</body>

</html>