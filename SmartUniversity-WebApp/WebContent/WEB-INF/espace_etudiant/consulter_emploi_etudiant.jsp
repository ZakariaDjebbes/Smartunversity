<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>Emploi du temps - ${utilisateur.getNom()} ${utilisateur.getPrenom()}</title>
<base href="${pageContext.request.contextPath}/WebContent">
<link rel="icon" href="assets/img/Logo/logo.png">
<link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="assets/data-tables/DataTables-1.10.20/css/dataTables.bootstrap4.min.css">
<link rel="stylesheet" href="assets/data-tables/custom-datatables.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat:400,400i,700,700i,600,600i">
<link rel="stylesheet" href="assets/fonts/font-awesome.min.css">
<link rel="stylesheet" href="assets/fonts/simple-line-icons.min.css">
<link rel="stylesheet" href="assets/css/emploi-du-temps.css">
<link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
	<jsp:include page="/WEB-INF/espace_etudiant/shared/header_etudiant.jsp"></jsp:include>
	<main class="page">
	<div class="clean-block clean-info dark">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="block-heading">
						<h2 class="text-success">Emploi du temps</h2>
						<p>Toutes vos séances par jour et par heure</p>
					</div>
				</div>
			</div>
			<div class="dropdown">
				<button class="btn btn-outline-dark dropdown-toggle" data-toggle="dropdown" aria-expanded="false" type="button">Telecharger au format</button>
				<div class="dropdown-menu" role="menu">
					<a class="dropdown-item" role="presentation" id="btn-download-excel">
						Excel&nbsp;<i class="fa fa-file-excel-o float-right fa-lg text-success"></i>
					</a>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12">
					<div class="table-responsive">
						<table class="table table-bordered" id="table-emploi">
							  <caption class="text-center font-weight-bold">Emploi du temps - ${utilisateur.getAnnee()}, ${utilisateur.getSpecialite()} Groupe ${utilisateur.getGroupe()}</caption>
							<thead>
								<tr class="text-center">
									<th></th>
									<th>Dimanche</th>
									<th>Lundi</th>
									<th>Mardi</th>
									<th>Mercredi</th>
									<th>Jedui</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>08:30 - 10:00</td>
									<!--DIMANCHE 830 10-->
									<td class="table-free" id="dimanche-8:30"></td>
									<!--LUNDI 830 10-->
									<td class="table-free" id="lundi-8:30"></td>
									<!--MARDI 830 10-->
									<td class="table-free" id="mardi-8:30"></td>
									<!--MERCREDI 830 10-->
									<td class="table-free" id="mercredi-8:30"></td>
									<!--JEUDI 830 10-->
									<td class="table-free" id="jeudi-8:30"></td>
								</tr>
								<tr>
									<td>10:00 - 11:30</td>
									<!--DIMANCHE 10 1130-->
									<td class="table-free" id="dimanche-10:00"></td>
									<!--LUNDI 10 1130-->
									<td class="table-free" id="lundi-10:00"></td>
									<!--MARDI 10 1130-->
									<td class="table-free" id="mardi-10:00"></td>
									<!--MERCREDI 10 1130-->
									<td class="table-free" id="mercredi-10:00"></td>
									<!--JEUDI 10 1130-->
									<td class="table-free" id="jeudi-10:00"></td>
								</tr>
								<tr>
									<td>11:30 - 13:00</td>
									<!--DIMANCHE 1130 13-->
									<td class="table-free" id="dimanche-11:30"></td>
									<!--LUNDI 1130 13-->
									<td class="table-free" id="lundi-11:30"></td>
									<!--MARDI 1130 13-->
									<td class="table-free" id="mardi-11:30"></td>
									<!--MERCREDI 1130 13-->
									<td class="table-free" id="mercredi-11:30"></td>
									<!--JEUDI 1130 13-->
									<td class="table-free" id="jeudi-11:30"></td>
								</tr>
								<tr>
									<td>13:00 - 14:30</td>
									<!--DIMANCHE 13 1430-->
									<td class="table-free" id="dimanche-13:00"></td>
									<!--LUNDI 13 1430-->
									<td class="table-free" id="lundi-13:00"></td>
									<!--MARDI 13 1430-->
									<td class="table-free" id="mardi-13:00"></td>
									<!--MERCREDI 13 1430-->
									<td class="table-free" id="mercredi-13:00"></td>
									<!--JEUDI 13 1430-->
									<td class="table-free" id="jeudi-13:00"></td>
								</tr>
								<tr>
									<td>14:30 - 16:00</td>
									<!--DIMANCHE 1430 16-->
									<td class="table-free" id="dimanche-14:30"></td>
									<!--LUNDI 1430 16-->
									<td class="table-free" id="lundi-14:30"></td>
									<!--MARDI 1430 16-->
									<td class="table-free" id="mardi-14:30"></td>
									<!--MERCREDI 1430 16-->
									<td class="table-free" id="mercredi-14:30"></td>
									<!--JEUDI 1430 16-->
									<td class="table-free" id="jeudi-14:30"></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
	</main>
	<jsp:include page="/WEB-INF/espace_etudiant/shared/footer_etudiant.jsp"></jsp:include>
	<script src="assets/js/jquery.min.js"></script>
	<script src="assets/bootstrap/js/bootstrap.min.js"></script>
	<script src="assets/js/smoothproducts.min.js"></script>
	<script src="assets/js/theme.js"></script>
	<script src="assets/js/table2csv.min.js"></script>
	<script src="assets/js/jquery.table2excel.min.js"></script>
	<script src="assets/js/keep-scroll.js"></script>
	<script>
		$(document).ready(function(){

		let data = [
			<c:forEach items="${seancesEtudiant}" var="seance">
			{
				code_seance:"${seance.getSeance().getCode_seance()}",
				nom:"${seance.getModule().getNom()}",
				nombreAbsences:${releverAbsences.getNombreAbsences(seance.getSeance().getCode_seance())},
				jour:"${seance.getSeance().getJour()}",
				heure:"${seance.getSeance().getHeure()}",
				type:"${seance.getSeance().getType()}",
				isExclu:${releverAbsences.isExcluFrom(seance.getSeance().getCode_seance())},
				seancesSupp: [
					<c:forEach items="${seance.getSeancesSupp()}" var="seanceSupp">
						{
							jour: "${seanceSupp.getJour()}",
							heure:"${seanceSupp.getHeure()}"
						},
					</c:forEach>
				],
			},
			</c:forEach>
		];
		
	    $('#btn-download-excel').on('click', function(e){
	        $("#table-emploi").table2excel({
	            exclude: ".noExport",
	            name: "Emploi du temps",
	            filename: "emploi-temps-etudiant-excel",
	        });
	    });
		
		for(seance of data)
		{
			let code_seance = seance.code_seance;
			let type = seance.type;
			let jour = seance.jour;
			let heure = seance.heure;
			let nombreAbsences = seance.nombreAbsences;
			let isExclu = seance.isExclu;
			let nom = seance.nom;
			let seancesSupp = seance.seancesSupp;
			setTemplate(jour, heure, getTemplate(type, nom, nombreAbsences, isExclu, code_seance), false);
			
			console.log(seancesSupp);
			for(seanceSupp of seancesSupp)
			{
				let suppJour = seanceSupp.jour;
				let suppHeure = seanceSupp.heure;
				setTemplate(suppJour, suppHeure, getTemplate(type, nom, nombreAbsences, isExclu, code_seance), true);
			}
		}
		
		function setTemplate(jour, heure, template, isSupp) 
		{
			let element = document.getElementById(jour + "-" + heure);
			element.className = "";
			if(isSupp)
			{
				element.classList.add("table-warning");	
			}
			else
			{
				element.classList.add("table-info");	
			}
			element.innerHTML += template;
		}
		
		function getTemplate(type, nom, nombreAbsences, isExclu, code_seance)
		{
			let absencesColor = isExclu ? "text-danger" : "text-success";
			
			let template = type
			+'<hr>'
			+'<b>' + nom + '</b>'
			+'<br>'
			+'<a href="${pageContext.request.contextPath}/User/ConsulterSeanceEtudiant?code-seance=' + code_seance + '"><span class="badge badge-primary">Consulter</span></a>'
			+'<hr>'
			+'<span class="' + absencesColor + '">' + nombreAbsences + ' absences</span>';
			
			return template;
		}
		
		function isIterable(obj) {
			  // checks for null and undefined
			  if (obj == null) {
			    return false;
			  }
			  return typeof obj[Symbol.iterator] === 'function';
			}
		});	
	</script>
</body>
</html>