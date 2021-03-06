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
<title><fmt:message key="labels.add_a"></fmt:message> <fmt:message key="labels.enseignant"></fmt:message> - NTIC</title>
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
								<h2 class="text-success"><fmt:message key="labels.add_a"></fmt:message> <fmt:message key="labels.enseignant"></fmt:message></h2>
								<p><fmt:message key="pages.index_admin.add_teacher_subtitle"></fmt:message></p>
							</div>
							<form  onsubmit="return (typeof submitted == 'undefined') ? (submitted = true) : !submitted"  action="${pageContext.request.contextPath}/User/AjouterEnseignantAdmin" method="post" class="form-special form-sidebar">
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
									<i class="fa fa-user-plus text-success" style="font-size: 80px"></i><small class="d-block"><fmt:message key="pages.index_admin.user_admin"></fmt:message></small>
									<hr>
								</div>
								<div class="form-row">
									<div class="col-12 col-lg-6">
										<div class="form-group">
											<label><fmt:message key="labels.nom"></fmt:message></label>
											<input class="form-control" name="nom" placeholder="Benchika" type="text" required>
										</div>
										<div class="form-group">
											<label><fmt:message key="labels.prenom"></fmt:message></label>
											<input class="form-control" name="prenom" placeholder="Fouzia" type="text" required>
										</div>
										<div class="form-group">
											<label><fmt:message key="labels.date_n"></fmt:message></label>
											<input class="form-control" name="date_n" type="date" required>
										</div>
										<div class="form-group">
											<label><fmt:message key="labels.adresse"></fmt:message></label>
											<input class="form-control" name="adresse" placeholder="Rue x ville y batiment z" type="text" required>
										</div>
										<div class="form-group">
											<label><fmt:message key="labels.telephone"></fmt:message></label>
											<input class="form-control" name="telephone" type="tel" placeholder="0123456789" required maxlength="10" minlength="10">
										</div>
									</div>
									<div class="col">
										<div class="form-group">
											<label><fmt:message key="labels.email"></fmt:message></label>
											<input class="form-control" name="email" placeholder="exemple@exml.com" type="email" required>
										</div>
										<div class="form-group">
											<label><fmt:message key="labels.grade"></fmt:message></label>
											<input class="form-control" name="grade" placeholder="Professeur" type="text" required>
										</div>
										<div class="form-group">
											<label><fmt:message key="labels.type"></fmt:message></label>
											<select name="type" class="form-control" required>
												<c:forEach var="type" items="${types}">
													<option value="${type}">${type.getValue(cookie['lang'].value)}</option>
												</c:forEach>
											</select>
										</div>
										<div id="formation" class="d-none">
											<div class="form-group">
												<label>Formation</label>
												<select name="formation" class="form-control" required>
														<option value="L1-MI">L1-MI</option>
														<option value="L2-MI">L2-MI</option>
														<option value="L3-GL">L3-GL</option>
														<option value="L3-SI">L3-SI</option>
														<option value="L3-SCI">L3-SCI</option>
														<option value="L3-TI">L3-TI</option>
														<option value="M1-GL">M1-GL</option>
														<option value="M1-STIC">M1-STIC</option>
														<option value="M1-STIW">M1-STIW</option>
														<option value="M1-RSD">M1-RSD</option>
														<option value="M2-GL">M2-GL</option>
														<option value="M2-STIC">M2-STIC</option>
														<option value="M2-STIW">M2-STIW</option>
														<option value="M2-RSD">M2-RSD</option>
												</select>
											</div>
										</div>
										<div class="form-group">
											<label><fmt:message key="labels.departement"></fmt:message></label>
											<select name="departement" class="form-control" required>
												<c:forEach var="departement" items="${departements}">
													<option value="${departement}">${departement.getValue(cookie['lang'].value)}-(${departement})</option>
												</c:forEach>
											</select>
										</div>
									</div>
								</div>
								<div class="form-row">
									<div class="col text-center">
										<button class="btn btn-outline-success" type="submit"><fmt:message key="labels.add"></fmt:message></button>
									</div>
								</div>
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
	$(document).ready(function(){
		$('select[name="type"]').on('change',function(){
			let value = this.value;
			let formation = $("#formation");
			
			if(value=='responsableFormation')
			{
				formation.removeClass("d-none");
			}
			else
			{
				formation.addClass("d-none");
			}
		});
	});
	</script>
</body>
</html>