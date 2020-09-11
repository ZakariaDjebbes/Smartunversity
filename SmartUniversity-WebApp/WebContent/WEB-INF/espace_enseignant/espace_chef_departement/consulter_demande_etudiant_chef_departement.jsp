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
<title>${demande.getEtudiant().getNom()}</title>
<link rel="icon" href="assets/img/Logo/logo.png">
<base href="${pageContext.request.contextPath}/WebContent">
<link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="assets/Datatables/datatables.min.css">
<link rel="stylesheet" href="assets/Datatables/custom-datatables.css">
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
						<h2 class="text-success"><fmt:message key="pages.consulter_demande.demande_de"></fmt:message> <fmt:message key="pages.consulter_demandes.conge"></fmt:message></h2>
						<p><fmt:message key="pages.consulter_demande.subtitle"></fmt:message></p>
					</div>
				</div>
			</div>
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
				<div class="col mt-3">
					<table class="table table-sm table-responsive">
						<tbody>
							<tr>
								<th style="width: 30%;"><fmt:message key="labels.etudiant"></fmt:message></th>
								<td>${demande.getEtudiant().getNom()} ${demande.getEtudiant().getPrenom()}</td>
							</tr>
							<tr>
								<th><fmt:message key="labels.ne_le"></fmt:message></th>
								<td>${demande.getEtudiant().getDate()}</td>
							</tr>
							<tr>
								<th><fmt:message key="labels.adresse"></fmt:message></th>
								<td>${demande.getEtudiant().getAdresse()}</td>
							</tr>
							<tr>
								<th><fmt:message key="labels.contact"></fmt:message></th>
								<td>
									<ul>
										<li>
											<b><fmt:message key="labels.email"></fmt:message></b>: ${demande.getEtudiant().getEmail()}
										</li>
										<li>
											<b><fmt:message key="labels.telephone"></fmt:message></b>: ${demande.getEtudiant().getTelephone()}
										</li>
									</ul>
								</td>
							</tr>
							<tr>
								<th><fmt:message key="labels.annee"></fmt:message>, <fmt:message key="labels.specialite"></fmt:message></th>
								<td>${demande.getEtudiant().getAnnee().getValue(cookie['lang'].value)} - (${demande.getEtudiant().getAnnee()}), ${demande.getEtudiant().getSpecialite().getValue(cookie['lang'].value)} - (${demande.getEtudiant().getSpecialite()})</td>
							</tr>
							<tr>
								<th><fmt:message key="labels.departement"></fmt:message></th>
								<td>${demande.getEtudiant().getCode_departement().getValue(cookie['lang'].value)} - (${demande.getEtudiant().getCode_departement()})</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<div class="text-center">
						<h4 class="text-success"><fmt:message key="pages.consulter_demande.detail_demande"></fmt:message></h4>
						<fmt:message key="pages.consulter_demande.conge"></fmt:message>
						<h6><fmt:message key="pages.consulter_demande.conge_file"></fmt:message>:</h6>
						<img src="data:image/${demande.getCongeAcademique().getExtension()};base64,${demande.getCongeAcademique().base64EncodedFichier()}" class="justification-image" />
						<div class="modal modal-img-justification">
							<span class="close close-img-modal" id="">×</span>
							<img class="modal-content img-modal"/>
							<div class="caption-modal-justification"></div>
						</div>
						<p class="mt-5">
							<span class="font-weight-bold"><fmt:message key="labels.etat"></fmt:message></span>&nbsp;: 
							<c:choose>
								<c:when test="${demande.getCongeAcademique().getEtat_demande() eq 'valide'}">
									<span class="text-success">${demande.getCongeAcademique().getEtat_demande().getValue(cookie['lang'].value)}</span>
								</c:when>
								<c:when test="${demande.getCongeAcademique().getEtat_demande() eq 'refuse'}">
									<span class="text-danger">${demande.getCongeAcademique().getEtat_demande().getValue(cookie['lang'].value)}</span>
								</c:when>
								<c:when test="${demande.getCongeAcademique().getEtat_demande() eq 'nonTraite'}">
									<span class="text-warning">${demande.getCongeAcademique().getEtat_demande().getValue(cookie['lang'].value)}</span>
								</c:when>
							</c:choose>
						</p>
						<form  onsubmit="return (typeof submitted == 'undefined') ? (submitted = true) : !submitted"  method="post">
							<div class="form-group text-center">
								<button class="btn btn-outline-success" formaction="${pageContext.request.contextPath}/User/ValiderDemande" type="submit"><fmt:message key="labels.valide"></fmt:message></button>
								<button class="btn btn-outline-danger ml-5" formaction="${pageContext.request.contextPath}/User/RefuserDemande" type="submit"><fmt:message key="labels.refuse"></fmt:message></button>
							</div>
						</form>
					</div>
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
	<script src="assets/js/consulter-demande-etudiant-chef-departement.js"></script>
	<script src="assets/js/keep-scroll.js"></script>
	<script src="assets/js/notifications_handler.js"></script>
</body>
</html>