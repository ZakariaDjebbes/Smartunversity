<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>${module.getNom()} - NTIC</title>
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
								<h2 class="text-success">Modification d'un module</h2>
								<p>Modifier les données de ce module</p>
							</div>
							<form  onsubmit="return (typeof submitted == 'undefined') ? (submitted = true) : !submitted"  action="${pageContext.request.contextPath}/User/ConsulterModuleAdmin" method="post" class="form-special form-sidebar">
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
									<i class="fa fa-scroll text-success" style="font-size: 80px"></i>
									<hr>
								</div>
								<div class="form-row">
									<div class="col-12">
										<div class="form-group">
											<label>Code du module</label>
											<input class="form-control" name="code-module" value="${module.getCode_module()}" type="text" required>
										</div>
										<div class="form-group">
											<label>Nom complet du module</label>
											<input class="form-control" name="nom" value="${module.getNom()}" type="text" required>
										</div>
									</div>
								</div>
								<div class="form-row">
									<div class="col text-center">
										<button type="button" data-id="${module.getCode_module()}" class="deleteModule btn btn-outline-danger" data-toggle="modal" data-target="#delete-modal">
											Supprimer ce module
										</button>								
									</div>
									<div class="col text-center">
										<input type="hidden" value="${module.getCode_module()}" name="code-module">
										<button class="btn btn-outline-success" type="submit">Enregistrer les modifications</button>
									</div>
								</div>
								<input type="hidden" name="old-code-module" value="${module.getCode_module()}">
								<input type="hidden" name="old-nom-module" value="${module.getNom()}">
							</form>
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
	<script type="text/javascript">
		let module = 
		{
				id:"${module.getCode_module()}",
				nom:"${module.getNom()}"
		}
		
		$(".deleteModule").on('click', function(){
			$("#nom").html(module.nom);
			$("#code").html(module.id);
			$("input[name='code-module']").val(module.id);
		});
	</script>
</body>
</html>