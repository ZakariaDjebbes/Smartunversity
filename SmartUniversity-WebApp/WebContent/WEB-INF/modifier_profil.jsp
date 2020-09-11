<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${cookie['lang'].value}"/>
<fmt:setBundle basename="resources.ApplicationResources"/>
<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>Modifier votre Profil - NTIC</title>
<base href="${pageContext.request.contextPath}/WebContent">
<link rel="icon" href="assets/img/Logo/logo.png">
<link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat:400,400i,700,700i,600,600i">
<link rel="stylesheet" href="assets/fonts/font-awesome.min.css">
<link rel="stylesheet" href="assets/fonts/simple-line-icons.min.css">
<link rel="stylesheet" href="assets/css/style.css">
</head>

<body>
	<c:choose>
		<c:when test="${utilisateur.getUser_type() eq 'enseignant' or utilisateur.getUser_type() eq 'chefDepartement' or utilisateur.getUser_type() eq 'responsableFormation'}">
			<jsp:include page="/WEB-INF/espace_enseignant/shared/header_enseignant.jsp"></jsp:include>
		</c:when>
		<c:when test="${utilisateur.getUser_type() eq 'etudiant'}">
			<jsp:include page="/WEB-INF/espace_etudiant/shared/header_etudiant.jsp"></jsp:include>
		</c:when>
	</c:choose>
	<main class="page login-page">
	<section class="clean-block clean-form dark">
		<div class="container">
			<div class="block-heading">
				<h2 class="text-success"><fmt:message key="pages.update_profil.title"></fmt:message></h2>
				<p><fmt:message key="pages.update_profil.subtitle"></fmt:message></p>
			</div>
			<form  onsubmit="return (typeof submitted == 'undefined') ? (submitted = true) : !submitted"  method="post" class="text-left form-special" id="form-profil">
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
				<div class="form-row">
					<div class="col">
						<div class="text-center">
							<h4 class="text-success"><fmt:message key="pages.update_profil.header_01"></fmt:message></h4>
						</div>
						<div class="form-group">
							<label><fmt:message key="labels.user"></fmt:message></label>
							<input class="form-control" autocomplete="off" type="text" value="${utilisateur.getUser()}" name="user" required>
						</div>
						<div class="form-group">
							<label><fmt:message key="labels.password"></fmt:message></label>
							<input class="form-control" autocomplete="off" type="password" value="${utilisateur.getPass()}" name="pass" required minlength="6">
						</div>
						<div class="text-center">
							<h4 class="text-success"><fmt:message key="pages.update_profil.header_02"></fmt:message></h4>
						</div>
						<div class="form-group">
							<label><fmt:message key="labels.nom"></fmt:message></label>
							<input class="form-control" type="text" value="${utilisateur.getNom()}" name="nom" required>
						</div>
						<div class="form-group">
							<label><fmt:message key="labels.prenom"></fmt:message></label>
							<input class="form-control" type="text" value="${utilisateur.getPrenom()}" name="prenom" required>
						</div>
						<div class="form-group">
							<label><fmt:message key="labels.adresse"></fmt:message></label>
							<input class="form-control" type="text" value="${utilisateur.getAdresse()}" name="adresse" required>
						</div>
						<div class="form-group">
							<label><fmt:message key="labels.email"></fmt:message></label>
							<input class="form-control" type="email" value="${utilisateur.getEmail()}" name="email" required>
						</div>
						<div class="form-group">
							<label><fmt:message key="labels.telephone"></fmt:message></label>
							<input class="form-control" type="tel" required value="${utilisateur.getTelephone()}" name="telephone" maxlength="10">
						</div>
						<div class="form-group">
							<label><fmt:message key="labels.date_n"></fmt:message></label>
							<input class="form-control" type="date" value="${utilisateur.getDate()}" name="date_n" required>
						</div>
					</div>
					<div class="col">
						<div class="text-center">
							<h4 class="text-success"><fmt:message key="pages.update_profil.header_03"></fmt:message></h4>
						</div>
						<div class="form-group">
							<label><fmt:message key="labels.user_type"></fmt:message></label>
							<input class="form-control" type="text" value="${utilisateur.getUser_type().getValue(cookie['lang'].value)}" readonly required>
						</div>
						<c:if test="${utilisateur.getUser_type() eq 'enseignant' or utilisateur.getUser_type() eq 'chefDepartement' or utilisateur.getUser_type() eq 'responsableFormation'}">
							<div class="form-group">
								<label><fmt:message key="labels.grade"></fmt:message></label>
								<input class="form-control" type="text" value="${utilisateur.getGrade()}" readonly required>
							</div>
						</c:if>
						<c:if test="${utilisateur.getUser_type() eq 'etudiant'}">
							<div class="form-group">
								<label><fmt:message key="labels.departement"></fmt:message></label>
								<input class="form-control" type="text" value="${utilisateur.getCode_departement().getValue(cookie['lang'].value)} - (${utilisateur.getCode_departement()})" readonly required>
							</div>
							<div class="form-group">
								<label><fmt:message key="labels.annee"></fmt:message></label>
								<input class="form-control" type="text" value="${utilisateur.getAnnee().getValue(cookie['lang'].value)} - (${utilisateur.getAnnee()})" readonly required>
							</div>
							<div class="form-group">
								<label><fmt:message key="labels.specialite"></fmt:message></label>
								<input class="form-control" type="text" value="${utilisateur.getSpecialite().getValue(cookie['lang'].value)} - (${utilisateur.getSpecialite()})" readonly required>
							</div>
							<div class="form-group">
								<label><fmt:message key="labels.group"></fmt:message></label>
								<input class="form-control" type="text" value="${utilisateur.getGroupe()}" readonly required>
							</div>
						</c:if>
						<c:if test="${utilisateur.getUser_type() eq 'enseignant' or utilisateur.getUser_type() eq 'chefDepartement' or utilisateur.getUser_type() eq 'responsableFormation'}">
							<div class="text-center">
								<h4 class="text-danger"><fmt:message key="pages.update_profil.delete_account"></fmt:message></h4>
								<small class="d-block"><fmt:message key="pages.update_profil.small_delete_account"></fmt:message>
								</small>
								<button class="btn btn-outline-danger mt-3" type="button" type="button" data-toggle="modal" data-target="#supprimer-profil-modal"><fmt:message key="labels.delete"></fmt:message></button>
								<div class="modal fade" id="supprimer-profil-modal" tabindex="-1" role="dialog" aria-hidden="true">
									<div class="modal-dialog" role="document">
										<div class="modal-content">
											<div class="modal-header">
												<h5 class="modal-title"><fmt:message key="labels.warning"></fmt:message>!</h5>
												<button type="button" class="close" data-dismiss="modal" aria-label="Close">
													<span aria-hidden="true">&times;</span>
												</button>
											</div>
											<div class="modal-body">
												<fmt:message key="pages.update_profil.small_delete_account"></fmt:message>
											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-secondary" data-dismiss="modal"><fmt:message key="labels.cancel"></fmt:message></button>
												<button type="submit" formaction="${pageContext.request.contextPath}/User/SupprimerProfil" class="btn btn-outline-danger"><fmt:message key="labels.delete"></fmt:message></button>
											</div>
										</div>
									</div>
								</div>
							</div>
						</c:if>
					</div>
				</div>
				<div class="form-row">
					<div class="col text-center mt-3">
						<button class="btn btn-outline-success" formaction="${pageContext.request.contextPath}/User/ModifierProfil" type="submit"><fmt:message key="labels.edit"></fmt:message></button>
					</div>
				</div>
			</form>
		</div>
	</section>
	</main>
	<c:choose>
		<c:when test="${utilisateur.getUser_type() eq 'enseignant' or utilisateur.getUser_type() eq 'chefDepartement' or utilisateur.getUser_type() eq 'responsableFormation'}">
			<jsp:include page="/WEB-INF/espace_enseignant/shared/footer_enseignant.jsp"></jsp:include>
		</c:when>
		<c:when test="${utilisateur.getUser_type() eq 'etudiant'}">
			<jsp:include page="/WEB-INF/espace_etudiant/shared/footer_etudiant.jsp"></jsp:include>
		</c:when>
	</c:choose>	<script src="assets/js/jquery.min.js"></script>
	<script src="assets/bootstrap/js/bootstrap.min.js"></script>
	<script src="assets/js/smoothproducts.min.js"></script>
	<script src="assets/js/theme.js"></script>
	<script src="assets/js/modifier_profil_buttonHandler.js"></script>
	<c:if test="${utilisateur.getUser_type() eq 'enseignant' or utilisateur.getUser_type() eq 'chefDepartement' or utilisateur.getUser_type() eq 'responsableFormation'}">
		<script src="assets/js/notifications_handler.js"></script>
	</c:if>
</body>

</html>