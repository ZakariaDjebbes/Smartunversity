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
<title><fmt:message key="pages.index_admin.consulter_liste"></fmt:message> <fmt:message key="labels.enseignant"></fmt:message> - NTIC</title>
<base href="${pageContext.request.contextPath}/WebContent">
<link rel="icon" href="assets/img/Logo/logo.png">
<link href="assets/fontawesome-sb/css/all.min.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="assets/Datatables/datatables.min.css">
<link rel="stylesheet" href="assets/Datatables/custom-datatables.css">
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
					<div class="card shadow mb-4 border-bottom-success">
						<div class="card-body">
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
								<div class="col text-center">
									<h2 class="text-success"><fmt:message key="pages.index_admin.consulter_liste"></fmt:message> <fmt:message key="labels.enseignants"></fmt:message></h2>
									<p><fmt:message key="pages.index_admin.liste_enseignant_subtitle"></fmt:message></p>
								</div>
							</div>
							<div class="row">
								<div class="col-12 col-md-6 col-lg-3 mt-3">
									<div class="dropdown keep-open">
										<a class="btn btn-outline-success dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Affichage</a>
										<div class="dropdown-menu w-10 p-2">
											<form  onsubmit="return (typeof submitted == 'undefined') ? (submitted = true) : !submitted"  class="px-1">

												<div class="custom-control custom-checkbox">
													<input type="checkbox" checked class="custom-control-input display-cb" id="display-cb-0" data-target="0">
													<label class="custom-control-label" for="display-cb-0"> <fmt:message key="labels.user"></fmt:message> </label>
												</div>
												<div class="custom-control custom-checkbox">
													<input type="checkbox" checked class="custom-control-input display-cb" id="display-cb-1" data-target="1">
													<label class="custom-control-label" for="display-cb-1"> <fmt:message key="labels.nom"></fmt:message> </label>
												</div>
												<div class="custom-control custom-checkbox">
													<input type="checkbox" checked class="custom-control-input display-cb" id="display-cb-2" data-target="2">
													<label class="custom-control-label" for="display-cb-2"> <fmt:message key="labels.prenom"></fmt:message>  </label>
												</div>
												<div class="custom-control custom-checkbox">
													<input type="checkbox" checked class="custom-control-input display-cb" id="display-cb-3" data-target="3">
													<label class="custom-control-label" for="display-cb-3"> <fmt:message key="labels.type"></fmt:message>  </label>
												</div>
												<div class="custom-control custom-checkbox">
													<input type="checkbox" class="custom-control-input display-cb" id="display-cb-4" data-target="4">
													<label class="custom-control-label" for="display-cb-4"> <fmt:message key="labels.email"></fmt:message>  </label>
												</div>
												<div class="custom-control custom-checkbox">
													<input type="checkbox" class="custom-control-input display-cb" id="display-cb-5" data-target="5">
													<label class="custom-control-label" for="display-cb-5"> <fmt:message key="labels.adresse"></fmt:message>  </label>
												</div>
												<div class="custom-control custom-checkbox">
													<input type="checkbox" class="custom-control-input display-cb" id="display-cb-6" data-target="6">
													<label class="custom-control-label" for="display-cb-5"> <fmt:message key="labels.date_n"></fmt:message>  </label>
												</div>
												<div class="custom-control custom-checkbox">
													<input type="checkbox" class="custom-control-input display-cb" id="display-cb-7" data-target="7">
													<label class="custom-control-label" for="display-cb-7"> <fmt:message key="labels.telephone"></fmt:message>  </label>
												</div>
												<div class="custom-control custom-checkbox">
													<input type="checkbox" checked class="custom-control-input display-cb" id="display-cb-8" data-target="8">
													<label class="custom-control-label" for="display-cb-8"> <fmt:message key="labels.departement"></fmt:message>  </label>
												</div>
												<div class="custom-control custom-checkbox">
													<input type="checkbox" class="custom-control-input display-cb" id="display-cb-9" data-target="9">
													<label class="custom-control-label" for="display-cb-9"> <fmt:message key="labels.grade"></fmt:message>  </label>
												</div>
											</form>
										</div>
									</div>
								</div>
							</div>
							<div class="row mt-3">
								<div class="col">
									<div class="table-responsive">
										<table id="table-enseignants" class="table table-striped table-bordered">
											<thead>
												<tr class="table-success">
													<th><fmt:message key="labels.user"></fmt:message> </th>
													<th><fmt:message key="labels.nom"></fmt:message> </th>
													<th><fmt:message key="labels.prenom"></fmt:message> </th>
													<th><fmt:message key="labels.type"></fmt:message> </th>
													<th><fmt:message key="labels.email"></fmt:message> </th>
													<th><fmt:message key="labels.adresse"></fmt:message> </th>
													<th><fmt:message key="labels.date_n"></fmt:message> </th>
													<th><fmt:message key="labels.telephone"></fmt:message> </th>
													<th><fmt:message key="labels.departement"></fmt:message> </th>
													<th><fmt:message key="labels.grade"></fmt:message> </th>
													<th><fmt:message key="labels.gestion"></fmt:message> </th>
												</tr>
											</thead>
											<tbody>
												<c:forEach var="enseignant" items="${enseignants}">
													<tr>
														<td>${enseignant.getUser()}</td>
														<td>${enseignant.getNom()}</td>
														<td>${enseignant.getPrenom()}</td>
														<td>${enseignant.getUser_type().getValue(cookie['lang'].value)}</td>
														<td>${enseignant.getEmail()}</td>
														<td>${enseignant.getAdresse()}</td>
														<td>${enseignant.getDate()}</td>
														<td>${enseignant.getTelephone()}</td>
														<td>${enseignant.getCode_departement()}</td>
														<td>${enseignant.getGrade()}</td>
														<td class="text-center">
															<a href="${pageContext.request.contextPath}/User/ConsulterEnseignantAdmin?id_enseignant=${enseignant.getId_utilisateur()}" class="btn btn-primary btn-circle btn-sm">
																<i class="fa fa-pen"></i>
															</a>
															<button type="button" data-id="${enseignant.getId_utilisateur()}" class="deleteUser btn btn-danger btn-circle btn-sm" data-toggle="modal" data-target="#delete-modal">
															<i class="fa fa-times"></i>
															</button>
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
			<div class="modal fade" id="delete-modal" tabindex="-1" role="dialog" aria-hidden="true">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" id="exampleModalLabel"><fmt:message key="labels.delete"></fmt:message> <fmt:message key="labels.utilisateur"></fmt:message>?</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
			      </div>
			      <div class="modal-body">
			        <fmt:message key="pages.index_admin.delete_user"></fmt:message> <span class="text-info" id="nom"></span> <span id="prenom" class="text-info"></span>
			      </div>
			      <div class="modal-footer">
			      	<form  onsubmit="return (typeof submitted == 'undefined') ? (submitted = true) : !submitted"  method="post">
			      		<input type="hidden" name="id_utilisateur">
			      		<input type="hidden" name="delete" value="enseignant">
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
	<script src="assets/Datatables/datatables.min.js"></script>
	
	<script src="assets/js/consulter-liste-enseignants-admin.js"></script>
	<script type="text/javascript">
		let enseignants = [
		<c:forEach var="enseignant" items="${enseignants}">
				{
					id:${enseignant.getId_utilisateur()},
					nom:"${enseignant.getNom()}",
					prenom:"${enseignant.getPrenom()}",
				},
		</c:forEach>
		];
		
		function findById(source, id) {
			  for (let i = 0; i < source.length; i++) {
			    if (source[i].id === id) {
			      return source[i];
			    }
			  }
			  throw "Couldn't find object with id: " + id;
		}
		
		$(".deleteUser").on('click', function(){
			let id = $(this).data("id");
			let object = findById(enseignants, id);
			$("#nom").html(object.nom);
			$("#prenom").html(object.prenom);
			$("input[name='id_utilisateur']").val(id);
		});
	</script>
</body>
</html>