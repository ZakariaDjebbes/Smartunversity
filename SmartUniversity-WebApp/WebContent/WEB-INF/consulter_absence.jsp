<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>${absence.getEtudiant().getNom()} ${absence.getEtudiant().getPrenom()}</title>
<link rel="icon" href="assets/img/Logo/logo.png">
<base href="${pageContext.request.contextPath}/WebContent">
<link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="assets/data-tables/DataTables-1.10.20/css/dataTables.bootstrap4.min.css">
<link rel="stylesheet" href="assets/data-tables/custom-datatables.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat:400,400i,700,700i,600,600i">
<link rel="stylesheet" href="assets/fonts/font-awesome.min.css">
<link rel="stylesheet" href="assets/fonts/simple-line-icons.min.css">
<link rel="stylesheet" href="assets/css/style.css">

</head>

<body>
	<jsp:include page="/WEB-INF/espace_enseignant/shared/header_enseignant.jsp"></jsp:include>
	<main class="page landing-page">
	<div class="clean-block clean-info dark">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="block-heading">
						<h2 class="text-success">Consultation de l'absence</h2>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-12">
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
						<c:remove var="isDone"/>
						<c:remove var="message"/>
					</c:if>
					<div>
						<h4 class="text-success">Details de l&#39;etudiant</h4>
					</div>
					<table class="table table-sm table-responsive">
						<tbody>
							<tr>
								<th style="width: 30%;">Etudiant</th>
								<td>${absence.getEtudiant().getNom()} ${absence.getEtudiant().getPrenom()} 
								<c:if test="${absence.getEtudiant().getEtat_etudiant() eq 'bloque'}">
									<span class="badge badge-warning" style="float:right">${absence.getEtudiant().getEtat_etudiant().getValue(0)}</span>
								</c:if>
								</td>
							</tr>
							<tr>
								<th>Né le</th>
								<td>${absence.getEtudiant().getDate()}</td>
							</tr>
							<tr>
								<th>Adresse</th>
								<td>${absence.getEtudiant().getAdresse()}</td>
							</tr>
							<tr>
								<th>Contact</th>
								<td>
									<ul>
										<li>
											<b>Adresse mail</b>: ${absence.getEtudiant().getEmail()}
										</li>
										<li>
											<b>Téléphone</b>: ${absence.getEtudiant().getTelephone()}
										</li>
									</ul>
								</td>
							</tr>
							<tr>
								<th>Année et spécialité</th>
								<td>${absence.getEtudiant().getAnnee().getValue(0)} - (${absence.getEtudiant().getAnnee()}), ${absence.getEtudiant().getSpecialite().getValue(0)} - (${absence.getEtudiant().getSpecialite()})</td>
							</tr>
							<tr>
								<th>Département</th>
								<td>${absence.getEtudiant().getCode_departement().getValue(0)} - (${absence.getEtudiant().getCode_departement()})</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="row">
				<c:if test="${absence.getEtudiant().getEtat_etudiant() ne 'bloque'}">
					<div class="col-md-4 mt-2">
						<h4 class="text-success">Justification</h4>
						<div>
							<c:choose>
								<c:when test="${not empty justification}">
									<img src="data:image/${justification.getExtension()};base64,${justification.base64EncodedFichier()}" class="justification-image" />
									<ul>
										<li>
											<b>Posté le:</b> ${justification.getFormattedDate_jusitifcation()}
										</li>
										<li>
											<b>Etat actuel: </b>
											<c:choose>
												<c:when test="${justification.getEtat_justification() eq 'valide'}">
													<span class="text-success">
														${justification.getEtat_justification().getValue(0)}
													</span>
												</c:when>
												<c:when test="${justification.getEtat_justification() eq 'refuse'}">
													<span class="text-danger">
														${justification.getEtat_justification().getValue(0)}
													</span>
												</c:when>
												<c:otherwise>
													<span class="text-warning">
														${justification.getEtat_justification().getValue(0)}
													</span>									
												</c:otherwise>
											</c:choose>
										</li>
										<li class="mt-3">
											<form method="post" action="${pageContext.request.contextPath}/User/DownloadJustification">
												<input type="hidden" name="numero-justification" value="${justification.getNumero_justification()}">								
												<input type="hidden" name="numero-absence" value="${absence.getAbsence().getNumero_absence()}">
												<input type="hidden" name="id-etudiant" value="${absence.getEtudiant().getId_utilisateur()}">
												<button type="submit" class="btn btn-outline-success">
													<i class="fa fa-download"> Télécharger</i>
												</button>
											</form>
										</li>
										<c:if test="${justification.getEtat_justification() eq 'refuse' && absence.isJustifiable()}">
											<li class="mt-3">
												<button type="button" class="btn btn-outline-info" data-toggle="modal" data-target="#upload-modal">
													<i class="fa fa-upload"> Autre justification</i>
												</button>
												<div class="modal fade" id="upload-modal" tabindex="-1" role="dialog" aria-labelledby="upload-modal" aria-hidden="true">
												  <div class="modal-dialog" role="document">
												    <div class="modal-content">
												      <div class="modal-header">
												        <h5 class="modal-title" id="exampleModalLabel">Uploader une nouvelle justification</h5>
												        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
												          <span aria-hidden="true">&times;</span>
												        </button>
												      </div>
												      <div class="modal-body">
												      	<div class="text-center">
												      		<img src="" id="justification-in-modal" class="justification-image" style="margin-bottom: 10px;" />
														</div>
														<form class="form-normal" method="post" action="${pageContext.request.contextPath}/User/UploadJustification" enctype="multipart/form-data">
															<div class="custom-file">
															    <input type="hidden" name="numero-absence" value="${absence.getAbsence().getNumero_absence()}">
															    <input type="file" accept="image/*" name="ficiher-justification" class="custom-file-input" id="input-upload-justification-modal">
															    <label class="custom-file-label" for="input-upload-justification">Choose file</label>
															</div>
															<div class="text-center" style="margin-top: 15px;">
																<input type="submit" value="Envoyer" class="btn btn-outline-info">
															</div>
														</form>
												      </div>
												    </div>
												  </div>
												</div>
											</li>
										</c:if>
										<c:if test="${justification.getEtat_justification() eq 'nonTraite'}">
											<li class="mt-3">
												<button type="button" class="btn btn-outline-danger">
													<i class="fa fa-close"> Annuler</i>
												</button>
											</li>
										 </c:if>
									</ul>
									<div class="modal modal-img-justification">
										<span class="close close-img-modal" id="">×</span>
										<img class="modal-content img-modal"/>
										<div class="caption-modal-justification"></div>
									</div>
									</c:when>
									<c:otherwise>
										<div class="alert alert-dark" role="alert">
										  Cette absence n'est pas justifier
										</div>
										<div class="text-center">	
											<img src="" id="justification-out-modal" class="justification-image" style="margin-bottom: 10px;" />
										</div>
										<div class="modal modal-img-justification">
											<span class="close close-img-modal">×</span>
											<img class="modal-content img-modal"/>
											<div class="caption-modal-justification"></div>
										</div>
										<form class="form-normal" method="post" action="${pageContext.request.contextPath}/User/UploadJustification" enctype="multipart/form-data">
											<div class="custom-file">
												<input type="hidden" name="numero-absence" value="${absence.getAbsence().getNumero_absence()}">
											    <input type="file" accept="image/*" name="ficiher-justification" class="custom-file-input" id="input-upload-justification">
											    <label class="custom-file-label" for="input-upload-justification">Choissiez un fichier</label>
											</div>
											<div class="text-center" style="margin-top: 15px;">
												<input type="submit" value="Envoyer" class="btn btn-outline-info">
											</div>
										</form>
									</c:otherwise>
							</c:choose>
						</div>
					</div>
				</c:if>
				<div class="col mt-2">
			    	<div class="text-left">    
			    		<h4 style="display:inline-block" class="text-success">Séance</h4>
			    		<c:choose>
			    			<c:when test="${utilisateur.getUser_type() eq 'chefDepartement'}">
			    				<a href="${pageContext.request.contextPath}/User/ConsulterSeanceChefDepartement?code-seance=${absence.getSeance().getCode_seance()}" 
			    				style="float:right" class="badge badge-info">Consulter</a>
			    			</c:when>
			    			<c:when test="${utilisateur.getUser_type() eq 'enseignant'}">
			    				<a href="${pageContext.request.contextPath}/User/ConsulterSeanceEnseignant?code-seance=${absence.getSeance().getCode_seance()}" 
			    				style="float:right" class="badge badge-info">Consulter</a>
			    			</c:when>
			    		</c:choose>
			    	</div>				
			    	<div>
						<div class="table-responsive">
							<table class="table table-sm">
								<tbody>
									<tr>
										<th style="width: 30%">Module</th>
										<td>${absence.getModule().getNom()} - ${absence.getModule().getCode_module()}</td>
									</tr>
									<tr>
										<th>Type</th>
										<td>${absence.getSeance().getType().getValue(0)} - (${absence.getSeance().getType()})</td>
									</tr>
									<tr>
										<th>Groupe</th>
										<td>${absence.getSeance().getGroupe()}</td>
									</tr>
									<tr>
										<th>Enseigner le:</th>
										<td>Le ${absence.getSeance().getJour().getValue(0)} à ${absence.getSeance().getHeure()}</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<c:if test="${not empty absence.getJustifications() &&  absence.getEtudiant().getEtat_etudiant() ne 'bloque'}">
						<h4 class="text-success">Historique des justifications</h4>
						<div>
							<div class="table-responsive">
								<table class="table table-sm" id="table-historique">
									<thead>
										<tr class="table-success">
											<th>Etat</th>
											<th>Date</th>
											<th>Consulter</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${absence.getJustifications()}" var="c_justification">
											<c:if test="${c_justification.getNumero_justification() ne justification.getNumero_justification()}">
												<tr>
													<c:choose>
														<c:when test="${c_justification.getEtat_justification() eq 'valide'}">
															<td class="text-success">${c_justification.getEtat_justification().getValue(0)}</td>
														</c:when>
														<c:when test="${c_justification.getEtat_justification() eq 'refuse'}">
															<td class="text-danger">${c_justification.getEtat_justification().getValue(0)}</td>
														</c:when>
														<c:when test="${c_justification.getEtat_justification() eq 'nonTraite'}">
															<td class="text-warning">${c_justification.getEtat_justification().getValue(0)}</td>
														</c:when>
													</c:choose>
													<td>${absence.getAbsence().getDate_absence()}</td>
													<td>
														<a
															href="${pageContext.request.contextPath}/User/ConsulterAbsence?numero-absence=${absence.getAbsence().getNumero_absence()}
															&numero-justification=${c_justification.getNumero_justification()}"
															class="btn btn-outline-success" role="button">Consulter</a>
													</td>
												</tr>
											</c:if>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</c:if>
				</div>
			</div>
			<c:if test="${justification.getEtat_justification() eq 'nonTraite' && utilisateur.getUser_type() eq 'chefDepartement'}">
				<div class="row mt-3">
					<div class="col mt-3 text-center">
						<button type="button" class="btn btn-danger" data-toggle="modal" data-target="#refuser-justification">
						  	Refuser la justification
						</button>
						<div class="modal fade" id="refuser-justification" tabindex="-1" role="dialog" aria-hidden="true">
						  <div class="modal-dialog" role="document">
						    <div class="modal-content">
						      <div class="modal-header">
						        <h5 class="modal-title">Refuser la justification</h5>
						        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
						          <span aria-hidden="true">&times;</span>
						        </button>
						      </div>
						      <div class="modal-body">
						      		Vous allez refuser cette justification, elle sera classée comme <span class="text-danger">Invalide</span>.
						      </div>
						      <div class="modal-footer">
						        <button type="button" class="btn btn-secondary" data-dismiss="modal">Annuler</button>
						        <form action="${pageContext.request.contextPath}/User/RefuserJustification" method="post">
						        	<input type="hidden" name="numero-absence" value="${absence.getAbsence().getNumero_absence()}">
						    		<input type="hidden" name="numero-justification" value="${justification.getNumero_justification()}">
						        	<button type="submit" class="btn btn-outline-danger">Refuser</button>
						        </form>
						      </div>
						    </div>
						  </div>
						</div>
					</div>
					<div class="col mt-3 text-center">
						<button type="button" class="btn btn-success" data-toggle="modal" data-target="#valider-justification">
						  	Valider la justification
						</button>
						<div class="modal fade" id="valider-justification" tabindex="-1" role="dialog" aria-hidden="true">
						  <div class="modal-dialog" role="document">
						    <div class="modal-content">
						      <div class="modal-header">
						        <h5 class="modal-title">Accepter la justification</h5>
						        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
						          <span aria-hidden="true">&times;</span>
						        </button>
						      </div>
						      <div class="modal-body">
						      		Vous allez accepter cette justification, elle sera classée comme <span class="text-success">Valide</span>.
						      </div>
						      <div class="modal-footer">
						        <button type="button" class="btn btn-secondary" data-dismiss="modal">Annuler</button>
						        <form action="${pageContext.request.contextPath}/User/ValiderJustification" method="post">
						        	<input type="hidden" name="numero-absence" value="${absence.getAbsence().getNumero_absence()}">
						    		<input type="hidden" name="numero-justification" value="${justification.getNumero_justification()}">
						        	<button type="submit" class="btn btn-outline-success">Valider</button>
						        </form>
						      </div>
						    </div>
						  </div>
						</div>				
					</div>
				</div>
			</c:if>
		</div>
	</div>
	</main>
	<jsp:include page="/WEB-INF/espace_enseignant/shared/footer_enseignant.jsp"></jsp:include>
	<script src="assets/js/jquery.min.js"></script>
	<script src="assets/bootstrap/js/bootstrap.min.js"></script>
	<script src="assets/data-tables/DataTables-1.10.20/js/jquery.dataTables.min.js"></script>
	<script src="assets/data-tables/DataTables-1.10.20/js/dataTables.bootstrap4.min.js"></script>
	<script src="assets/js/smoothproducts.min.js"></script>
	<script src="assets/js/theme.js"></script>
	<script src="assets/js/consulter-absence-chef-departement.js"></script>
</body>
</html>