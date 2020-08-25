<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Ajouter un etudiant - NTIC</title>
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
								<h2 class="text-success">Ajouter un étudiant</h2>
								<p>Ajouter un étudiant dans le système</p>
							</div>
							<form  onsubmit="return (typeof submitted == 'undefined') ? (submitted = true) : !submitted"  action="${pageContext.request.contextPath}/User/AjouterEtudiantAdmin" method="post" class="form-special form-sidebar">
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
									<i class="fa fa-user-plus text-success" style="font-size: 80px"></i><small class="d-block">Un email contenant le nom d'utilisateur et le mot de passe sera automatiquement envoyé a
										l'étudiant concerné.</small>
									<hr>
								</div>
								<div class="form-row">
									<div class="col-12 col-lg-6">
										<div class="form-group">
											<label>Nom</label>
											<input class="form-control" name="nom" placeholder="Djebbes" type="text" required>
										</div>
										<div class="form-group">
											<label>Prenom</label>
											<input class="form-control" name="prenom" placeholder="Zakaria" type="text" required>
										</div>
										<div class="form-group">
											<label>Date de naissance</label>
											<input class="form-control" name="date_n" type="date" required>
										</div>
										<div class="form-group">
											<label>Adresse</label>
											<input class="form-control" name="adresse" placeholder="Rue x ville y batiment z" type="text" required>
										</div>
										<div class="form-group">
											<label>Telephone</label>
											<input class="form-control" name="telephone" type="tel" placeholder="0123456789" required maxlength="10" minlength="10">
										</div>
									</div>
									<div class="col">
										<div class="form-group">
											<label>Email</label>
											<input class="form-control" name="email" placeholder="exemple@exml.com" type="email" required>
										</div>
										<div class="form-group">
											<label>Année</label>
											<select name="annee" class="form-control" required>
												<c:forEach var="annee" items="${annees}">
													<option value="${annee}">${annee.getValue(0)}-(${annee})</option>
												</c:forEach>
											</select>
										</div>
										<div class="form-group">
											<label>Spécialite</label>
											<select class="form-control" name="specialite" required>
											</select>
										</div>
										<div class="form-group">
											<label>Groupe</label>
											<input class="form-control" name="groupe" type="number" value="1" required max="20" min="1" step="1">
										</div>
									</div>
								</div>
								<div class="form-row">
									<div class="col text-center">
										<button class="btn btn-outline-success" type="submit">Ajouter l'étudiant</button>
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
		$(document).ready(function () {
			let specialites = [
				<c:forEach var="specialite" items="${specialites}">
					{
						value:"${specialite.getValue(0)}",
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
		    		$('select[name="specialite"]').append(new Option(item.value, item.id));
		    	}
			}
			
			setSelectOpts('L1');
			
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