<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${cookie['lang'].value}"/>
<fmt:setBundle basename="resources.ApplicationResources"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<base href="${pageContext.request.contextPath}/WebContent">
<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>${seanceDepartement.getModule().getNom()}</title>
<link rel="icon" href="assets/img/Logo/logo.png">
<link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
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
						<h2 class="text-success"><fmt:message key="pages.consulter_seance_chef.title"></fmt:message></h2>
						<p><fmt:message key="pages.consulter_seance_chef.subtitle"></fmt:message></p>
					</div>
					<div class="table-responsive">
						<h4 class="text-success"><fmt:message key="pages.consulter_seance.detail_seance"></fmt:message></h4>					
						<table class="table table-sm">
							<tbody>
								<tr>
									<th style="width: 30%"><fmt:message key="labels.module"></fmt:message></th>
									<td>${seanceDepartement.getModule().getNom()} - (${seanceDepartement.getModule().getCode_module()})</td>
								</tr>
								<tr>
									<th><fmt:message key="labels.type"></fmt:message></th>
									<td>${seanceDepartement.getSeance().getType().getValue(cookie['lang'].value)} - (${seanceDepartement.getSeance().getType()})</td>
								</tr>
								<tr>
									<th><fmt:message key="labels.annee"></fmt:message>, <fmt:message key="labels.specialite"></fmt:message></th>
									<td>${seanceDepartement.getSeance().getAnnee().getValue(cookie['lang'].value)} - (${seanceDepartement.getSeance().getAnnee()}), ${seanceDepartement.getSeance().getSpecialite().getValue(cookie['lang'].value)} - (${seanceDepartement.getSeance().getSpecialite()})</td>
								</tr>
								<tr>
									<th><fmt:message key="labels.group"></fmt:message></th>
									<td>${seanceDepartement.getSeance().getGroupe()}</td>
								</tr>
								<tr>
									<th><fmt:message key="labels.enseigne_le"></fmt:message></th>
									<td>${seanceDepartement.getSeance().getJour().getValue(cookie['lang'].value)} à ${seanceDepartement.getSeance().getHeure()}</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12">
					<h4 class="text-success"><fmt:message key="pages.consulter_seance.enseignant"></fmt:message></h4>
					<!-- 
					<div class="block-heading">
						<h2 class="text-success">Enseignant chargé de la séance</h2>
						<p>Affecter ou déssafecter un enseignant a cette séance.</p>
					</div>
					 -->
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
					<c:choose>
						<c:when test="${not empty seanceDepartement.getEnseignant()}">
							<div id="e-exists">
								<div class="table-responsive">
									<table class="table table-sm">
										<tbody>
											<tr>
												<th style="width: 30%"><fmt:message key="labels.nom"></fmt:message>, <fmt:message key="labels.prenom"></fmt:message></th>
												<td>${seanceDepartement.getEnseignant().getNom()}&nbsp;${seanceDepartement.getEnseignant().getPrenom()}</td>
											</tr>
											<tr>
												<th><fmt:message key="labels.ne_le"></fmt:message></th>
												<td>${seanceDepartement.getEnseignant().getDate()}</td>
											</tr>
											<tr>
												<th><fmt:message key="labels.adresse"></fmt:message></th>
												<td>${seanceDepartement.getEnseignant().getAdresse()}</td>
											</tr>
											<tr>
												<th><fmt:message key="labels.contact"></fmt:message></th>
												<td>
													<ul>
														<li>
															<b><fmt:message key="labels.email"></fmt:message></b>: ${seanceDepartement.getEnseignant().getEmail()}
														</li>
														<li>
															<b><fmt:message key="labels.telephone"></fmt:message></b>: ${seanceDepartement.getEnseignant().getTelephone()}
														</li>
													</ul>
												</td>
											</tr>
											<tr>
												<th><fmt:message key="labels.grade"></fmt:message></th>
												<td>${seanceDepartement.getEnseignant().getGrade()}</td>
											</tr>
											<tr>
												<th><fmt:message key="labels.departement"></fmt:message></th>
												<td>${seanceDepartement.getEnseignant().getCode_departement().getValue(cookie['lang'].value)} - (${seanceDepartement.getEnseignant().getCode_departement()})</td>
											</tr>
										</tbody>
									</table>
								</div>
								<div class="text-center" style="padding-top: 25px;">
									<button type="button" class="btn btn-danger" data-toggle="modal" data-target="#confirm-affecter">
									  	<fmt:message key="pages.consulter_seance_chef.unassign_teacher"></fmt:message>
									</button>
									<div class="modal fade" id="confirm-affecter" tabindex="-1" role="dialog" aria-hidden="true">
									  <div class="modal-dialog" role="document">
									    <div class="modal-content">
									      <div class="modal-header">
									        <h5 class="modal-title"><fmt:message key="pages.consulter_seance_chef.unassign_teacher"></fmt:message></h5>
									        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
									          <span aria-hidden="true">&times;</span>
									        </button>
									      </div>
									      <div class="modal-body">
									      	<fmt:message key="pages.consulter_seance_chef.unassign_modal"></fmt:message> <span id="confirm-nom-prenom" class="text-info">${seanceDepartement.getEnseignant().getNom()}&nbsp;${seanceDepartement.getEnseignant().getPrenom()}</span>.
									      </div>
									      <div class="modal-footer">
									        <button type="button" class="btn btn-secondary" data-dismiss="modal"><fmt:message key="labels.cancel"></fmt:message></button>
									        <form  onsubmit="return (typeof submitted == 'undefined') ? (submitted = true) : !submitted"  action="${pageContext.request.contextPath}/User/DesaffecterSeance" method="post">
									        	<button type="submit" class="btn btn-outline-danger"><fmt:message key="pages.consulter_seance_chef.unassign_teacher"></fmt:message></button>
									        </form>
									      </div>
									    </div>
									  </div>
									</div>
								</div>
							</div>
						</c:when>
						<c:otherwise>
							<div id="e-not-exists">
								<c:if test="${not empty enseignants}">
								<div class="row justify-content-center">
									<div class="col col-md-4 col-xs-12 mb-3">
										<div class="text-center border rounded-0 text-center" style="background-color: #C3E6CB; padding: 13px 0px;">
											<p class="d-inline font-weight-bold"><fmt:message key="labels.enseignants"></fmt:message></p>
										</div>
										<div class="list-group d-block select-list" role="tablist" id="list-enseignants">
											<c:forEach var="enseignant" items="${enseignants}" varStatus="stat">
												 <c:if test="${stat.first}">
													<a class="list-group-item list-group-item-action active" id="${enseignant.getEnseignant().getId_utilisateur()}" data-toggle="list" role="tab" aria-controls="home">
														<span>${enseignant.getEnseignant().getNom()} ${enseignant.getEnseignant().getPrenom()}</span>
														<c:choose>
															<c:when test="${enseignant.isDisponible()}">
																<i class="fa fa-check float-right fa-lg text-success"></i>														
															</c:when>
															<c:otherwise>
																<i class="fa fa-close float-right fa-lg text-success"></i>																												
															</c:otherwise>
														</c:choose>
													</a>											    
											    </c:if>
											    <c:if test="${!stat.first}">
													<a class="list-group-item list-group-item-action" id="${enseignant.getEnseignant().getId_utilisateur()}" data-toggle="list" role="tab" aria-controls="home">
														<span>${enseignant.getEnseignant().getNom()} ${enseignant.getEnseignant().getPrenom()}</span>
														<c:choose>
															<c:when test="${enseignant.isDisponible()}">
																<i class="fa fa-check float-right fa-lg text-success"></i>														
															</c:when>
															<c:otherwise>
																<i class="fa fa-close float-right fa-lg text-danger"></i>																												
															</c:otherwise>
														</c:choose>
													</a>
											    </c:if>
											</c:forEach>
										</div>
										<div>
											<div class="input-group">
												<input class="form-control" type="text" id="filter-enseignants" placeholder="Cherchez un enseignant...">
												<div class="input-group-append">
													<span class="input-group-text"><i class="fa fa-search fa-lg"></i></span>
												</div>
											</div>
										</div>
									</div>
									<div class="col">
										<div class="table-responsive">
											<table class="table table-sm">
												<tbody>
													<tr class="table-success">
														<th style="width: 30%" colspan="2" class="text-center"><fmt:message key="pages.consulter_seance.detail_enseignant"></fmt:message></th>
													</tr>
													<tr>
														<th style="width: 30%"><fmt:message key="labels.nom">, </fmt:message> <fmt:message key="labels.prenom"></fmt:message></th>
														<td id="nom-prenom"></td>
													</tr>
													<tr>
														<th><fmt:message key="labels.ne_le"></fmt:message></th>
														<td id="date"></td>
													</tr>
													<tr>
														<th><fmt:message key="labels.adresse"></fmt:message></th>
														<td id="adresse"></td>
													</tr>
													<tr>
														<th><fmt:message key="labels.contact"></fmt:message></th>
														<td>
															<ul>
																<li>
																	<b><fmt:message key="labels.email"></fmt:message></b>: <span id="mail"></span>
																</li>
																<li>
																	<b><fmt:message key="labels.telephone"></fmt:message></b>: <span id="telephone"></span> 
																</li>
															</ul>
														</td>
													</tr>
													<tr>
														<th><fmt:message key="labels.grade"></fmt:message></th>
														<td id="grade"></td>
													</tr>
													<tr>
														<th><fmt:message key="labels.departement"></fmt:message></th>
														<td id="departement"></td>
													</tr>
													<tr>
														<th><fmt:message key="labels.dispo"></fmt:message></th>
														<td id="disponibilite"></td>
													</tr>
												</tbody>
											</table>
										</div>
									</div>
								</div>
								<div class="text-center" style="padding-top: 25px;">
									<button type="button" class="btn btn-success" data-toggle="modal" id="btn-affecter" data-target="#confirm-affecter">
									  	<fmt:message key="pages.consulter_seance_chef.assign_teacher"></fmt:message>
									</button>
									<div class="modal fade" id="confirm-affecter" tabindex="-1" role="dialog" aria-hidden="true">
									  <div class="modal-dialog" role="document">
									    <div class="modal-content">
									      <div class="modal-header">
									        <h5 class="modal-title"><fmt:message key="pages.consulter_seance_chef.assign_teacher"></fmt:message></h5>
									        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
									          <span aria-hidden="true">&times;</span>
									        </button>
									      </div>
									      <div class="modal-body">
									      		<fmt:message key="pages.consulter_seance_chef.assign_modal"></fmt:message> <span id="confirm-nom-prenom" class="text-info">PLACE HOLDER</span>
									      </div>
									      <div class="modal-footer">
									        <button type="button" class="btn btn-secondary" data-dismiss="modal"><fmt:message key="labels.cancel"></fmt:message></button>
									        <form  onsubmit="return (typeof submitted == 'undefined') ? (submitted = true) : !submitted"  action="${pageContext.request.contextPath}/User/AffecterSeance" method="post" id="form-affecter">
									        	<input type="hidden" name="id-enseignant" value="">	
									        	<button type="submit" class="btn btn-outline-success"><fmt:message key="pages.consulter_seance_chef.assign_teacher"></fmt:message></button>
									      	</form>
									      </div>
									    </div>
									  </div>
									</div>
								</div>
								</c:if>
							</div>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</div>
	</main>
	<jsp:include page="/WEB-INF/espace_enseignant/shared/footer_enseignant.jsp"></jsp:include>
	<script src="assets/js/jquery.min.js"></script>
	<script src="assets/bootstrap/js/bootstrap.min.js"></script>
	<script src="assets/js/smoothproducts.min.js"></script>
	<script src="assets/js/theme.js"></script>
	<c:if test="${empty seanceDepartement.getEnseignant()}">
		<script type="text/javascript">
		$(document).ready(function(){
			let enseignants = [
				<c:forEach items="${enseignants}" var="enseignant">
					{
					id: "${enseignant.getEnseignant().getId_utilisateur()}",
					nom: "${enseignant.getEnseignant().getNom()}",
					prenom: "${enseignant.getEnseignant().getPrenom()}",
					adresse: "${enseignant.getEnseignant().getAdresse()}",
					date: "${enseignant.getEnseignant().getDate()}",
					telephone: "${enseignant.getEnseignant().getTelephone()}",
					grade: "${enseignant.getEnseignant().getGrade()}",
					departement: "${enseignant.getEnseignant().getCode_departement().getValue(cookie['lang'].value)} - (${enseignant.getEnseignant().getCode_departement()})",
					disponibilite: ${enseignant.isDisponible()},
					mail: "${enseignant.getEnseignant().getEmail()}",
				},
				</c:forEach>
			];
			let currentEnseignant = enseignants[0];
			let toggleCounter = 0;
			setTableText(currentEnseignant);
			
			$("#form-affecter").submit(function(){
				let $input = $(this).find("input[name=id-enseignant]");
				$input.val(currentEnseignant.id);
			});
			
			$("#btn-affecter").on('click', function(e) {
				$("#confirm-nom-prenom").text(currentEnseignant.nom + " " + currentEnseignant.prenom);
			});
			
			$('#list-enseignants a').on('click', function (e) {
				  e.preventDefault()
				  let id = $(this).attr('id');
				  let enseignant = findById(enseignants, id);

				  if(enseignant != currentEnseignant)
				  {  
					  currentEnseignant = enseignant;
					  changeTableText(currentEnseignant, 'fast');
				  }
				});
			
			function findById(source, id) {
				  for (let i = 0; i < source.length; i++) {
				    if (source[i].id === id) {
				      return source[i];
				    }
				  }
				  throw "Couldn't find object with id: " + id;
			}
			
			
			//TODO styling gets wanky when filtering
			$("#filter-enseignants").on("keyup", function() {
			    let value = $(this).val().toLowerCase();
			    $("#list-enseignants a span").filter(function() {
			      $(this).parent().toggle($(this).text().toLowerCase().includes(value));
			    });
			    
			    if($("#list-enseignants > a:hidden").length == enseignants.length && !$("#empty-list-enseignants").length)
			    {
			    	$("#list-enseignants").append("<a class='list-group-item list-group-item-action active' id='empty-list-enseignants' data-toggle='list' role='tab' aria-controls='home'>Aucun enseignant ne correspond</a>");	
			    }
			    else if ($("#list-enseignants > a:hidden").length != enseignants.length)
			    {
			    	$("#empty-list-enseignants").remove();
			    }
			  });
			
			function setTableText(enseignant)
			{
				  $("#nom-prenom").text(enseignant.nom + " " + enseignant.prenom);
				  $("#date").text(enseignant.date);
				  $("#departement").text(enseignant.departement);
				  $("#adresse").text(enseignant.adresse);
				  $("#telephone").text(enseignant.telephone);
				  $("#grade").text(enseignant.grade);
				  if(enseignant.disponibilite == true) 
				  {
					  $("#disponibilite").text("Disponible");
					  $("#disponibilite").addClass("text-success");
				  }
				  else
				  {
					  $("#disponibilite").text("Indisponible");
					  $("#disponibilite").addClass("text-danger");
			      }
				  $("btn-affecter").prop("disabled", disponibilite);
				  $("#mail").text(enseignant.mail);				  
			}
			
			function changeTableText(enseignant, speed)
			{
				  $("#nom-prenom").fadeOut(speed);
				  $("#date").fadeOut(speed);
				  $("#departement").fadeOut(speed);
				  $("#adresse").fadeOut(speed);
				  $("#telephone").fadeOut(speed);
				  $("#grade").fadeOut(speed);
				  $("#disponibilite").fadeOut(speed);
				  $("#mail").fadeOut(speed, function(){
					  setTableText(enseignant);
					  fadeInTable();
				  });
			}
			
			function fadeInTable(speed)
			{
				  $("#nom-prenom").fadeIn(speed);
				  $("#date").fadeIn(speed);
				  $("#departement").fadeIn(speed);
				  $("#adresse").fadeIn(speed);
				  $("#telephone").fadeIn(speed);
				  $("#grade").fadeIn(speed);
				  $("#disponibilite").fadeIn(speed);
				  $("#mail").fadeIn(speed);
			}
		});
		</script>
	</c:if>
	<script src="assets/js/notifications_handler.js"></script>
</body>
</html>