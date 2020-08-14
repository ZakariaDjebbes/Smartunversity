<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>SM NTIC</title>
<link rel="stylesheet" href="../assets/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat:400,400i,700,700i,600,600i">
<link rel="stylesheet" href="../assets/fonts/font-awesome.min.css">
<link rel="stylesheet" href="../assets/fonts/simple-line-icons.min.css">
<link rel="stylesheet" href="../assets/css/consulter-seance.css">
<link rel="stylesheet" href="../assets/css/Filter.css">
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.15/css/dataTables.bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/baguettebox.js/1.10.0/baguetteBox.min.css">
<link rel="stylesheet" href="../assets/css/Pretty-Search-Form.css">
<link rel="stylesheet" href="../assets/css/style.css">
</head>

<body>
	<div class="clean-block clean-info dark">
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
								<a role="tab" data-toggle="pill" href="#tab-etudiants-exclus" class="nav-link active">Etudiants exclus</a>
							</li>
							<li class="nav-item" id="demande-changement">
								<a role="tab" data-toggle="pill" href="#tab-demande-changement" class="nav-link">Demande de changement</a>
							</li>
							<li class="nav-item" id="seances-supp">
								<a role="tab" data-toggle="pill" href="#tab-seances-supp" class="nav-link">Séances supplémentaires</a>
							</li>
						</ul>
						<div class="mt-4">
							<h4 class="text-success">Détails de la séance</h4>
							<table class="table table-sm">
								<tbody>
									<tr>
										<th style="width: 30%">Module</th>
										<td>Algorithmique et structure de données (ALGO)</td>
									</tr>
									<tr>
										<th>Type</th>
										<td>Travail pratique (TP)</td>
									</tr>
									<tr>
										<th>Année et spécialité</th>
										<td>2éme année license (L2), Tronc commun (MI)</td>
									</tr>
									<tr>
										<th>Groupe</th>
										<td>5</td>
									</tr>
									<tr>
										<th>Enseigner le:</th>
										<td>Jeudi à 13:00</td>
									</tr>
								</tbody>
							</table>
						</div>
						<h4 class="text-success">Gestion de la séance</h4>
						<div class="tab-content">
							<div role="tabpanel" class="tab-pane fade" id="tab-marquer-presence">
								<div class="row">
									<div class="col"></div>
								</div>
							</div>
							<div role="tabpanel" class="tab-pane fade" id="tab-relever-absences">
								<div class="row">
									<div class="col col-12 col-md-4" style="margin-bottom: 10px;">
										<div class="text-center border rounded-0 text-center" style="background-color: rgb(195, 230, 203); padding: 13px 0px;">
											<p class="d-inline font-weight-bold">Etudiants</p>
										</div>
										<div class="list-group d-block" id="list-etudiants-relever">
											<button class="list-group-item list-group-item-action">
												<span>Djebbes Zakaria</span>
											</button>
										</div>
									</div>
									<div class="col">
										<div class="table-responsive">
											<table class="table table-striped table-bordered table-sm">
												<thead>
													<tr>
														<th class="table-success">Date</th>
														<th class="table-success">Etat</th>
													</tr>
												</thead>
												<tbody>
													<tr>
														<td>1999-02-02</td>
														<td class="text-success">
															Justifier<span class="text-right text-danger float-right" style="margin-left: 20px;"><i class="fa fa-close fa-lg"></i></span><span class="text-dark float-right"
																style="margin-left: 20px;"><i class="fa fa-list-ul fa-lg"></i></span><span class="text-right float-right"><i class="fa fa-download fa-lg"></i></span>
														</td>
													</tr>
													<tr>
														<td>1999-02-02</td>
														<td class="text-warning">
															Non traiter <span class="float-right text-danger" style="margin-left: 20px;"><i class="fa fa-close fa-lg"></i></span><span class="text-dark float-right" style="margin-left: 20px;"><i
																class="fa fa-list-ul fa-lg"></i></span><span class="text-success float-right"><i class="fa fa-download fa-lg"></i></span>
														</td>
													</tr>
													<tr>
														<td>1999-02-02</td>
														<td class="text-danger">
															Non justifier <span class="float-right" style="margin-left: 20px;"><i class="fa fa-close fa-lg"></i></span><span class="text-dark float-right" style="margin-left: 20px;"><i
																class="fa fa-list-ul fa-lg"></i></span><span class="text-primary float-right"><i class="fa fa-upload fa-lg"></i></span>
														</td>
													</tr>
												</tbody>
											</table>
										</div>
									</div>
								</div>
							</div>
							<div role="tabpanel" class="tab-pane fade show active" id="tab-etudiants-exclus">
								<div>
									<div class="table-responsive">
										<table class="table table-bordered table-striped table-bordered table-sm">
											<thead>
												<tr>
													<th class="table-warning">Etudiant</th>
													<th class="table-warning">Absences justifier</th>
													<th class="table-warning">Absences non justifier</th>
													<th class="table-warning">Total d&#39;absences</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td>Djebbes Zakaria</td>
													<td>3</td>
													<td>2</td>
													<td>5</td>
												</tr>
												<tr></tr>
											</tbody>
										</table>
									</div>
									<div class="text-center">
										<div class="btn-group">
											<button type="button" class="btn btn-outline-warning dropdown-toggle" data-toggle="dropdown">Télécharger la liste au format</button>
											<div class="dropdown-menu">
												<a class="dropdown-item" href="#">
													Excel <span class="float-right"><i class="text-success fa fa-lg fa-file-excel-o"></i></span>
												</a>
												<a class="dropdown-item" href="#">
													CSV <span class="float-right"><i class="text-dark fa fa-lg fa-table"></i></span>
												</a>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div role="tabpanel" class="tab-pane fade" id="tab-demande-changement">
								<p>Content for tab 3.</p>
							</div>
							<div role="tabpanel" class="tab-pane fade" id="tab-seances-supp">
								<p>Content for tab 3.</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="../assets/js/jquery.min.js"></script>
	<script src="../assets/bootstrap/js/bootstrap.min.js"></script>
	<script src="https://cdn.datatables.net/1.10.15/js/jquery.dataTables.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/baguettebox.js/1.10.0/baguetteBox.min.js"></script>
	<script src="https://cdn.datatables.net/1.10.15/js/dataTables.bootstrap.min.js"></script>
	<script src="../assets/js/smoothproducts.min.js"></script>
	<script src="../assets/js/theme.js"></script>
	<script src="../assets/js/consulter-absence-chef-departement.js"></script>
	<script src="../assets/js/script.js"></script>
	<script src="../assets/js/Table-With-Search.js"></script>
</body>

</html>