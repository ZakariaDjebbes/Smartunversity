<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${cookie['lang'].value}"/>
<fmt:setBundle basename="resources.ApplicationResources"/>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>${etudiant.getNom()} ${etudiant.getPrenom()} - NTIC</title>
<base href="${pageContext.request.contextPath}/WebContent">
<link rel="icon" href="assets/img/Logo/logo.png">
<link href="assets/fontawesome-sb/css/all.min.css" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
<link href="assets/css/sb-admin-2.min.css" rel="stylesheet">

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
								<h2 class="text-success"><fmt:message key="pages.index_admin.modify_student"></fmt:message></h2>
								<p><fmt:message key="pages.index_admin.modify_student_subtitle"></fmt:message></p>
							</div>
							<form  onsubmit="return (typeof submitted == 'undefined') ? (submitted = true) : !submitted"  action="${pageContext.request.contextPath}/User/ConsulterEtudiantAdmin" method="post" class="form-special form-sidebar">
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
								<div class="text-center">
									<i class="fa fa-user-edit text-success" style="font-size: 80px"></i>
									<hr>
								</div>
								<div class="form-row">
									<div class="col-12 col-lg-6">
										<div class="form-group">
											<label><fmt:message key="labels.user"></fmt:message></label>
											<input class="form-control" name="user" type="text" value="${etudiant.getUser()}" required>
										</div>
										<div class="form-group">
											<label><fmt:message key="labels.nom"></fmt:message></label>
											<input class="form-control" name="nom" type="text" value="${etudiant.getNom()}" required>
										</div>
										<div class="form-group">
											<label><fmt:message key="labels.prenom"></fmt:message></label>
											<input class="form-control" name="prenom" type="text" value="${etudiant.getPrenom()}" required>
										</div>
										<div class="form-group">
											<label><fmt:message key="labels.date_n"></fmt:message></label>
											<input class="form-control" name="date_n" type="date" value="${etudiant.getDate()}" required>
										</div>
										<div class="form-group">
											<label><fmt:message key="labels.adresse"></fmt:message></label>
											<input class="form-control" name="adresse" type="text" value="${etudiant.getAdresse()}" required>
										</div>
										<div class="form-group">
											<label><fmt:message key="labels.telephone"></fmt:message></label>
											<input class="form-control" name="telephone" type="tel" required value="${etudiant.getTelephone()}" maxlength="10" minlength="10">
										</div>
									</div>
									<div class="col">
										<div class="form-group">
											<label><fmt:message key="labels.email"></fmt:message></label>
											<input class="form-control" name="email" type="email" value="${etudiant.getEmail()}" required>
										</div>
										<div class="form-group">
											<label><fmt:message key="labels.annee"></fmt:message></label>
											<select name="annee" class="form-control" required>
												<c:forEach var="annee" items="${annees}">
													<option value="${annee}" <c:if test="${etudiant.getAnnee() eq annee}">selected</c:if>>${annee.getValue(cookie['lang'].value)}-(${annee})</option>
												</c:forEach>
											</select>
										</div>
										<div class="form-group">
											<label><fmt:message key="labels.specialite"></fmt:message></label>
											<select class="form-control" name="specialite" required>
											</select>
										</div>
										<div class="form-group">
											<label><fmt:message key="labels.group"></fmt:message></label>
											<input class="form-control" name="groupe" type="number" value="${etudiant.getGroupe()}" required max="20" min="1" step="1">
										</div>
										<div class="form-group">
											<label><fmt:message key="labels.etat"></fmt:message></label>
											<select name="etat" class="form-control" required>
												<c:forEach var="etat" items="${etats}">
													<option value="${etat}" <c:if test="${etudiant.getEtat_etudiant() eq etat}">selected</c:if>>${etat.getValue(cookie['lang'].value)}</option>
												</c:forEach>
											</select>
										</div>
									</div>
								</div>
								<div class="form-row">
									<div class="col text-center">
										<button type="button" data-id="${etudiant.getId_utilisateur()}" class="deleteUser btn btn-outline-danger" data-toggle="modal" data-target="#delete-modal">
											<fmt:message key="labels.delete"></fmt:message> <fmt:message key="labels.etudiant"></fmt:message>
										</button>
									</div>
									<div class="col text-center">
										<input type="hidden" value="${etudiant.getId_utilisateur()}" name="id_etudiant">
										<button class="btn btn-outline-success" type="submit"><fmt:message key="labels.valide"></fmt:message></button>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			<div class="modal fade" id="delete-modal" tabindex="-1" role="dialog" aria-hidden="true">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" id="exampleModalLabel"><fmt:message key="pages.index_admin.delete_user"></fmt:message>?</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
			      </div>
			      <div class="modal-body">
			       <fmt:message key="pages.index_admin.delete_user"></fmt:message> <span class="text-info" id="nom"></span> <span id="prenom" class="text-info"></span>
			      </div>
			      <div class="modal-footer">
			      	<form  onsubmit="return (typeof submitted == 'undefined') ? (submitted = true) : !submitted"  method="post">
			      		<input type="hidden" name="delete" value="etudiant">
			      		<input type="hidden" name="id_utilisateur">
				        <button type="button" class="btn btn-secondary" data-dismiss="modal"><fmt:message key="labels.cancel"></fmt:message></button>
				        <button type="submit" formaction="${pageContext.request.contextPath}/User/SupprimerCompteAdmin"  type="submit" class="btn btn-outline-danger"><fmt:message key="labels.delete"></fmt:message></button>
			        </form>
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
		<script type="text/javascript">
		$(document).ready(function () {
			let etudiant = {
					id:${etudiant.getId_utilisateur()},
					nom:"${etudiant.getNom()}",
					prenom:"${etudiant.getPrenom()}",
				};
				
				
				$(".deleteUser").on('click', function(){
					$("#nom").html(etudiant.nom);
					$("#prenom").html(etudiant.prenom);
					$("input[name='id_utilisateur']").val(etudiant.id);
				});
			
			let specialites = [
				<c:forEach var="specialite" items="${specialites}">
					{
						value:"${specialite.getValue(cookie['lang'].value)}",
						id:"${specialite}"
					},
				</c:forEach>
			];
			
			function setSelectOpts(annee)
			{
		    	let r_specialites= getSpecialitesOfAnnee(annee);
		    	$('select[name="specialite"]').find('option').remove().end();
		    	for(item of r_specialites)
		    	{
		    		let option = new Option(item.value, item.id);
		    		
		    		if(item.id == "${etudiant.getSpecialite()}")
		    		{
		    			option.setAttribute('selected','selected');
		    			$('select[name="specialite"]').append(option);
		    		}
		    		else
		    		{
		    			$('select[name="specialite"]').append(option);		    			
		    		}
		    	}
			}
			
			setSelectOpts('${etudiant.getAnnee()}');
			
		    $('select[name="annee"]').change(function () {
		    	let annee = $(this).val();
		    	setSelectOpts(annee);
		    });
		    
		    function getSpecialitesOfAnnee(annee)
		    {
		    	let result = [];

		    	switch(annee)
		    	{
		    		case 'L1':
		    			result.push(search(specialites, 'MI'));
		    			break;
		    		case 'L2':
		    			result.push(search(specialites, 'MI'));
		    			break;
		    		case 'L3':
			    		result.push(search(specialites, 'GL'));
			    		result.push(search(specialites, 'SI'));
			    		result.push(search(specialites, 'SCI'));
			    		result.push(search(specialites, 'TI'));
		    			break;
		    		case 'M1': case 'M2':
		    			result.push(search(specialites, 'GL'));
		    			result.push(search(specialites, 'STIC'));
		    			result.push(search(specialites, 'STIW'));
		    			result.push(search(specialites, 'RSD'));
		    			break;
		    	}
		    	
		    	return result;
		    }
		    
		    function search(array, id){
		        for (var i=0; i < array.length; i++) {
		            if (array[i].id === id) {
		                return array[i];
		            }
		        }
		    }
		});
	</script>
</body>
</html>