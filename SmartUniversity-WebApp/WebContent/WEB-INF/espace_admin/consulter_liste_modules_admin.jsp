<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Liste des modules - NTIC</title>
<base href="${pageContext.request.contextPath}/WebContent">
<link rel="icon" href="assets/img/Logo/logo.png">
<link href="assets/fontawesome-sb/css/all.min.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="assets/data-tables/DataTables-1.10.20/css/dataTables.bootstrap4.min.css">
<link rel="stylesheet" href="assets/data-tables/custom-datatables.css">
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
									<h2 class="text-success">Liste des modules de la faculté</h2>
									<p>Liste de tout les modules existant dans le système, consultez ou supprimez les.</p>
								</div>
							</div>
							<div class="row mt-3">
								<div class="col">
									<div class="table-responsive">
										<table id="table-etudiants" class="table table-striped table-bordered">
											<thead>
												<tr class="table-success">
													<th>Nom d'utilisateur</th>
													<th>Nom</th>
													<th>Opérations</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach var="module" items="${modules}">
													<tr>
														<td>${module.getCode_module()}</td>
														<td>${module.getNom()}</td>
														<td class="text-center">
															<a href="${pageContext.request.contextPath}/User/ConsulterModuleAdmin?code-module=${module.getCode_module()}" class="btn btn-primary btn-circle btn-sm">
																<i class="fa fa-pen"></i>
															</a>
															<button type="button" data-id="${module.getCode_module()}" class="deleteModule btn btn-danger btn-circle btn-sm" data-toggle="modal" data-target="#delete-modal">
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
			        <h5 class="modal-title" id="exampleModalLabel">Supprimer ce module?</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
			      </div>
			      <div class="modal-body">
			        Voulez vous supprimer le module <span class="text-info" id="nom"></span> - (<span id="code" class="text-info"></span>)?
			      </div>
			      <div class="modal-footer">
			      	<form  onsubmit="return (typeof submitted == 'undefined') ? (submitted = true) : !submitted"  method="post">
			      		<input type="hidden" name="code-module">
				        <button type="button" class="btn btn-secondary" data-dismiss="modal">Annuler</button>
				        <button type="submit" formaction="${pageContext.request.contextPath}/User/SupprimerModuleAdmin"  type="submit" class="btn btn-outline-danger">Supprimer le module</button>
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
	<script src="assets/data-tables/DataTables-1.10.20/js/jquery.dataTables.min.js"></script>
	<script src="assets/data-tables/DataTables-1.10.20/js/dataTables.bootstrap4.min.js"></script>
	<script type="text/javascript">
		let modules = [
		<c:forEach var="module" items="${modules}">
				{
					id:"${module.getCode_module()}",
					nom:"${module.getNom()}",
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
		
		$(".deleteModule").on('click', function(){
			let id = $(this).data("id");
			console.log(id);
			let object = findById(modules, id);
			console.log(object);
			$("#nom").html(object.nom);
			$("#code").html(id);
			$("input[name='code-module']").val(id);
		});
	</script>
</body>
</html>