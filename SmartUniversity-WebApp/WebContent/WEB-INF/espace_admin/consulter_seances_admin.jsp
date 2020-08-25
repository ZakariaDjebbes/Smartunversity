<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Gestion des séances - NTIC</title>
<base href="${pageContext.request.contextPath}/WebContent">
<link rel="icon" href="assets/img/Logo/logo.png">
<link href="assets/fontawesome-sb/css/all.min.css" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
<link href="assets/css/sb-admin-2.min.css" rel="stylesheet">
<link rel="stylesheet" href="assets/css/emploi-du-temps.css">

<style type="text/css">
div.card-link.card:hover {
	transition: 0.35s;
	background-color: #C3E6CB;
	color: black;
}

div.card-link.card {
	transition: 0.35s;
}
</style>

</head>

<body id="page-top">
	<div id="wrapper">
		<jsp:include page="/WEB-INF/espace_admin/shared/navbar_admin.jsp"></jsp:include>
		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
				<jsp:include page="/WEB-INF/espace_admin/shared/navbar_top_admin.jsp"></jsp:include>
				<div class="container-fluid">
					<div class="card mb-4 p-3 border-bottom-success">
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
							<div class="text-center">
								<h2 class="text-success">Gérer les séances de la faculté</h2>
								<p>Sélectionnez un groupe puis modifiez, supprimez ou ajouter une séance.</p>
							</div>
							<div class="row">
								<h5>Liste des groupes ${annee} - ${specialite}:</h5>
							</div>
							<div class="row mt-3">
								<ul class="list-inline" id="liste-groupes">
									<li class="list-inline-item">
										<a href="#" id="add-group" class="btn btn-success btn-circle">
											<i class="fa fa-plus"></i>
										</a>
									</li>
								</ul>
							</div>
							<div class="row mt-3">
								<h5>
									Emploi du temps du groupe <span class="group-number"></span>:
								</h5>
							</div>
							<div class="row mt-3">
								<div class="table-responsive">
									<table class="table table-bordered" id="table-emploi">
										<caption class="text-center font-weight-bold">
											Emploi du temps - ${annee}, ${specialite} Groupe <span class="group-number"></span>
										</caption>
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
			</div>
			<jsp:include page="/WEB-INF/espace_admin/shared/footer_admin.jsp"></jsp:include>
		</div>
	</div>
	<div class="modal fade" id="modal-add-session" tabindex="-1" role="dialog" aria-labelledby="modal-add-session" aria-hidden="true">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title">Ajouter une séance</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <form  onsubmit="return (typeof submitted == 'undefined') ? (submitted = true) : !submitted"  action="${pageContext.request.contextPath}/User/AjouterSeanceAdmin" method="post">
		      <div class="modal-body">
		        <div class="form-row">
		        	<div class="form-group">
		        		<label for="type">Type de la séance</label>
		        		<select class="form-control" name="type" id="type">
		        			<option value="TP">TP</option>
		        			<option value="TD">TD</option>
		        		</select>
		        	</div>
		        </div>
		        <div class="form-row">
    		        <div class="form-group">
		        		<label for="module">Module</label>
		        		<select class="form-control" name="module" id="module">
		        		</select>
		        	</div>
		        </div>
		      </div>
		      <div class="modal-footer">
		      	<input name="jour" value="" type="hidden">
		        <input name="heure" value="" type="hidden">
		        <input name="annee" value="${annee}" type="hidden">
		        <input name="specialite" value="${specialite}" type="hidden">
		        <input name="groupe" value="" type="hidden">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Annuler</button>
		        <button type="submit" class="btn btn-outline-success">Ajouter</button>
		      </div>
	      </form>
	    </div>
	  </div>
	</div>
	<div class="modal fade" id="modal-delete-session" tabindex="-1" role="dialog" aria-labelledby="modal-delete-session" aria-hidden="true">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title">Supprimer cette séance?</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        Voulez vous supprimer cette séance?
	      </div>
	      <div class="modal-footer">
	      	<form  onsubmit="return (typeof submitted == 'undefined') ? (submitted = true) : !submitted"  action="${pageContext.request.contextPath}/User/SupprimerSeanceAdmin" method="post">
	      		<input type="hidden" name="code_seance" value="">
      			<input name="annee" value="${annee}" type="hidden">
		        <input name="specialite" value="${specialite}" type="hidden">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Annuler</button>
		        <button type="submit" class="btn btn-outline-danger">Supprimer</button>
	        </form>
	      </div>
	    </div>
	  </div>
	</div>
		<div class="modal fade" id="modal-update-session" tabindex="-1" role="dialog" aria-labelledby="modal-update-session" aria-hidden="true">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title">Modifier une séance</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <form  onsubmit="return (typeof submitted == 'undefined') ? (submitted = true) : !submitted"  action="${pageContext.request.contextPath}/User/ConsulterSeancesAdmin" method="post">
		      <div class="modal-body">
		        <div class="form-row">
		        	<div class="form-group">
		        		<label for="type">Type de la séance</label>
		        		<select class="form-control" name="type" id="type">
		        			<option value="TP">TP</option>
		        			<option value="TD">TD</option>
		        		</select>
		        	</div>
		        </div>
		        <div class="form-row">
    		        <div class="form-group">
		        		<label for="module">Module</label>
		        		<select class="form-control" name="code_module" id="module">
		        		</select>
		        	</div>
		        </div>
		      </div>
		      <div class="modal-footer">
		        <input name="code_seance" value="" type="hidden">
		        <input name="annee" value="${annee}" type="hidden">
		        <input name="specialite" value="${specialite}" type="hidden">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Annuler</button>
		        <button type="submit" class="btn btn-outline-primary">Modifier</button>
		      </div>
	      </form>
	    </div>
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
		let seances = [
			<c:forEach items="${seances}" var="seance">
			{
				code_seance:"${seance.getSeance().getCode_seance()}",
				code:"${seance.getModule().getCode_module()}",
				nom:"${seance.getModule().getNom()}",
				jour:"${seance.getSeance().getJour()}",
				heure:"${seance.getSeance().getHeure()}",
				type:"${seance.getSeance().getType()}",
				groupe:"${seance.getSeance().getGroupe()}",
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

		let modules = [
			<c:forEach items="${modules}" var="module">
			{
				code:"${module.getCode_module()}",
				nom:"${module.getNom()}",
			},
			</c:forEach>
		];
				
		for(module of modules)
		{
			$("#modal-add-session select[name='module'], #modal-update-session select[name='code_module']").append(new Option(module.nom + " - ("+ module.code +")", module.code));
		}
		
		let groups = getGroups(seances);
		setGroupList(groups);
		
		$("a#add-group").on('click', function(e){
			e.preventDefault();
			addGroup();
		});
				
		function addGroup()
		{
			let groupNumber = 1;
			
			while($('a[data-group="' + groupNumber + '"]').length)
			{
				groupNumber++;
			}
			
			let li= 
				'<li class="list-inline-item">'
					+'<a data-group="' + groupNumber + '" class="btn btn-outline-success btn-circle">'
						+groupNumber
					+'</a>'
				+'</li>';
			
				
			if(groupNumber > 1)
			{
				let after = $('a[data-group="' + (groupNumber - 1) + '"]').parent('li');
				
		    	$(li).insertAfter(after);
			}
			else
			{
				$('#liste-groupes').prepend(li);
			}
				
			setSeanceOfTable(groupNumber);
		}
		
		function getGroups(seances)
		{
			let groups = [];
			
			for(item of seances)
			{
				let group = item.groupe;
				if(!groups.includes(group))
				{
					groups.push(group);
				}
			}
			
			groups.sort(function(a, b) {
				return a - b;
			});
			
			return groups;
		}
		
		function setGroupList(groups)
		{
			let first = true;
			
			for(group of groups)
			{
				let li;
				if(first)
				{
					li= 
					'<li class="list-inline-item">'
						+'<a data-group="' + group + '" class="btn active btn-outline-success btn-circle">'
							+group
						+'</a>'
					+'</li>';
					
					setSeanceOfTable(group);
					first = false;
				}
				else
				{
					li= 
					'<li class="list-inline-item">'
						+'<a data-group="' + group + '" class="btn btn-outline-success btn-circle">'
							+group
						+'</a>'
					+'</li>';
				}
				$('#add-group').before(li);
			}
		}
		
		function emptyTable()
		{
			$("#table-emploi td[id]").each(function(){
				$(this).html('');
				$(this).attr('class', '');
				$(this).addClass("table-free")
			});
		}
		
		function setSeanceOfTable(group)
		{
			$("span.group-number").html(group);
			$("#modal-add-session input[name='groupe']").val(group);
			for(seance of seances)
			{
				let c_group = seance.groupe;
				if(c_group == group)
				{
					let code_seance = seance.code_seance;
					let type = seance.type;
					let jour = seance.jour;
					let heure = seance.heure;
					let nom = seance.nom;
					let seancesSupp = seance.seancesSupp;
					setTemplate(jour, heure, getTemplate(type, nom, true, code_seance), false);
					
					for(seanceSupp of seancesSupp)
					{
						let suppJour = seanceSupp.jour;
						let suppHeure = seanceSupp.heure;
						setTemplate(suppJour, suppHeure, getTemplate(type, nom, false), true);
					}
				}
			}
			$("#table-emploi td").each(function(){
				if(!$(this).html()){
					let date = getDate($(this));
					let day = date[0];
					let hour = date[1];
					let addSession = '<a href="" data-day="' + day + '" data-hour="' + hour + '" data-toggle="modal" class="add-session" data-target="#modal-add-session"><span class="badge badge-secondary">Ajouter une séance</span></a>'
					$(this).html(addSession);
				}	
			});
			
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
		
		function getTemplate(type, nom, isModifiable, code_seance)
		{
			let template;
			
			if(isModifiable)
			{
				template = type
				+'<hr>'
				+'<b>' + nom + '</b>'
				+'<br>'
				+'<a href="" data-code="' + code_seance + '" data-toggle="modal" data-target="#modal-update-session" class="update-session"><span class="badge badge-primary">Consulter</span></a>'
				+'<a href="" data-code="' + code_seance + '" data-toggle="modal" data-target="#modal-delete-session" class="delete-session"><span class="badge badge-danger ml-1">Supprimer</span></a>'
			}
			else
			{
				template = type
				+'<hr>'
				+'<b>' + nom + '</b>'
			}
			return template;
		}
		
		 $("body").on('click', 'a.delete-session', function(){
			$("#modal-delete-session input[name='code_seance']").val($(this).data("code"));
		});
		
		 $("body").on('click', 'a.update-session', function(){
				$("#modal-update-session input[name='code_seance']").val($(this).data("code"));
			});
		 
		 $("body").on('click', 'a.add-session', function() {
			$("#modal-add-session input[name='jour']").val($(this).data("day"));
			$("#modal-add-session input[name='heure']").val($(this).data("hour"));				
		});
		
		$("body").on('click', 'a[data-group]', function(){
			let group = $(this).data("group");
			emptyTable();
			setSeanceOfTable(group);
			 disabledButtons();
			$(this).addClass('active');
		});
		
		function disabledButtons()
		{
			$("a[data-group]").each(function(){
				$(this).removeClass("active");
			});
		}
		
		function getDate(element)
		{
			let id = element.attr('id');
			let data = id.split("-");
			
			return data;
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