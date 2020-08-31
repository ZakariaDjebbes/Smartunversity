<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>Statistiques - NTIC</title>
<base href="${pageContext.request.contextPath}/WebContent">
<link rel="icon" href="assets/img/Logo/logo.png">
<link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="assets/data-tables/DataTables-1.10.20/css/dataTables.bootstrap4.min.css">
<link rel="stylesheet" href="assets/data-tables/custom-datatables.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat:400,400i,700,700i,600,600i">
<link rel="stylesheet" href="assets/fonts/font-awesome.min.css">
<link rel="stylesheet" href="assets/fonts/simple-line-icons.min.css">
<link rel="stylesheet" href="assets/css/style.css">
<link rel="stylesheet" href="assets/css/filter-select.css">
<link rel="stylesheet" href="assets/css/custom-checkbox.css">
<link rel="stylesheet" href="assets/alertify/css/themes/bootstrap.min.css">
</head>
<body>
	<jsp:include page="/WEB-INF/espace_enseignant/shared/header_enseignant.jsp"></jsp:include>
	<main class="page">
	<section class="clean-block clean-info dark">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="block-heading">
						<h2 class="text-success">Statistiques de vos groupes</h2>
						<p>Consulter les statistiques des absences de vos groupes par groupe, module, jour ou heure</p>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<form>
						<div class="form-group">
							<label for="module">Module</label>
							<select class="form-control" id="module">
								<option value="all-modules">Tous les modules</option>
							</select>
						</div>
						<div class="d-none" id="groupes-d-div">
							<div class="form-group">
								<label for="groupe">Groupe</label>
								<select class="form-control" id="groupe">
									<option value="all-groupes">Tous les groupes</option>
								</select>
							</div>
						</div>
					</form>
				</div>
			</div>
			<div class="row justify-content-center">
				<div class="col-10 text-center">
					<form>
						<div class="row">
							<div class="form-group col">
								<label for="chart-type">Type de graphique</label>
								<select class="form-control" id="chart-type">
									<option value="bar">Barres</option>
									<option value="line">Graphe</option>
								</select>
							</div>
							<div class="form-group col">
								<label for="stat-type">Type de statistiques</label>
								<select class="form-control" id="stat-type">
									<option value="stat-jour">Absences par jour</option>
									<option value="stat-heure">Absences par heure</option>
									<option value="stat-module">Absences par module</option>
									<option value="stat-groupe">Absences par groupe</option>
								</select>
							</div>
						</div>
					</form>
					<canvas id="chart"></canvas>
				</div>
			</div>
		</div>
	</section>
	</main>
	<jsp:include page="/WEB-INF/espace_enseignant/shared/footer_enseignant.jsp"></jsp:include>
	<script src="assets/js/jquery.min.js"></script>
	<script src="assets/bootstrap/js/bootstrap.min.js"></script>
	<script src="assets/js/smoothproducts.min.js"></script>
	<script src="assets/js/theme.js"></script>
	<script src="assets/js/keep-scroll.js"></script>
	<script src="assets/js/notifications_handler.js"></script>
	<script src="assets/chartjs/Chart.min.js"></script>
	<script src="assets/js/lodash.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			let canvas = document.getElementById('chart').getContext('2d');
			const byDay = "jour";
			const byHour = "heure";
			const byGroup = "groupe";
			const byModule= "module";
			let moduleSelect = $("#module");
			let groupeSelect = $("#groupe");
			let statTypeSelect = $("#stat-type");
			let chartTypeSelect = $("#chart-type");
						
			let jours = [
				<c:forEach var="jour" items="${jours}">
				"${jour.getValue(0)}",
				</c:forEach>
			];
			
			let data = [
				<c:forEach var="seance" items="${sessionScope.seances}">
				{
					module: "${seance.getModule().getNom()}",
					code_module: "${seance.getModule().getCode_module()}",
					jour: "${seance.getSeance().getJour().getValue(0)}",
					heure: "${seance.getSeance().getHeure()}",
					groupe: ${seance.getSeance().getGroupe()},
					nombre_absences: ${seance.GetNombreAbsences()},
					nombre_absences_justifier: ${seance.GetNombreAbsencesJustifier()},
					nombre_absences_non_justifier: ${seance.GetNombreAbsencesNonJustifier()}
				},
				</c:forEach>
			];
			
			setModules(data, moduleSelect);
			
			moduleSelect.on('change', function(){
				let value = this.value;
				let displayDiv = $("#groupes-d-div");
				
				if(value == "all-modules")
				{
					displayDiv.addClass("d-none");
				}
				else
				{
					setGroupes(data, value, groupeSelect);
					displayDiv.removeClass("d-none");
				}
			});
			
			let byDayAllDataset = 	getDatasetAbsencesALL(data, byDay);

			let chart = new Chart(canvas, {
			    type: 'radar',
			    data: {
			        labels: ['Dimanche', 'Lundi', 'Mardi', 'Mercredi', 'Jeudi'],
			        datasets: [
			        	{
			                label: "Total d'absences",
			                backgroundColor: 'rgba(255, 206, 86, 0.2)',
				            borderColor:'rgba(255, 206, 86, 1)',
				            borderWidth: 1,
				            barPercentage: 0.5,				        
			            },
			        	{
			                label: "Absences justifier",
			                backgroundColor: 'rgba(255, 99, 132, 0.2)',
				            borderColor: 'rgba(255,99,132,1)',
				            borderWidth: 1,
				            barPercentage: 0.5,
			            },
			        	{
			                label: "Absences non justifier",
			                backgroundColor:'rgba(54, 162, 235, 0.2)',
				            borderColor: 'rgba(54, 162, 235, 1)',
				            borderWidth: 1,
				            barPercentage: 0.5,
			            }   
			        ]
			    },
			    options: {
				        title: {
				            display: true,
				            text: 'Nombre d\'absences par jour'
				        },
			        	scales: {
			                yAxes: [{
			                    ticks: {
			                        beginAtZero: true
			                    }
			                }]
			            }
			    	}
			    });

			updateChart(chart, getDatasetAbsencesALL(data, byDay));
			//changeChart(chart, "radar");
			function updateChart(chart, data) {
				let formated_data = getFormatedDataset(data);
				
				for(let i = 0; i < chart.data.datasets.length; i++)
				{
					chart.data.datasets[i].data = formated_data[i];	
				}
			    chart.update();
			}
			
			function changeChart(chart, newType) {
				let canvas = document.getElementById('chart').getContext('2d');

				  if (chart) {
					  chart.destroy();
				  }

				  let temp = jQuery.extend(true, {}, chart.config);
				  temp.type = newType;
				  chart = new Chart(canvas, temp);
			};
			
			function setModules(data, select)
			{	
				let modules = [];
				
				for(item of data)
				{
					let module = {
						nom: item.module,
						code: item.code_module
					}
					
					modules.push(module);
				}
				
				let uniq_modules = _.uniqBy(modules, 'nom');
				for(module of uniq_modules)
				{
					let option = new Option(module.nom + " ("+ module.code +")", module.code);
					select.append(option);
				}
			}
			
			function setGroupes(data, code, select)
			{	
				select.find('option').not(':first').remove();
				
				let groupes = [];
				for(item  of data)
				{
					if(item.code_module == code)
					{
						groupes.push(item.groupe);
					}
				}

				groupes = _.uniq(groupes);								
				groupes.sort((a, b) => a - b);
			
				for(groupe of groupes)
				{
					let option = new Option(groupe, groupe);
					select.append(option);	
				}
			}
						
			function getDatasetAbsencesALL(data, by)
			{
				let dataset = [];
				
				switch(by)
				{
					case byDay:
						for(jour of jours)
						{
							let nombreAbsences = 0;
							let nombreAbsencesJustifier = 0;
							let nombreAbsencesNonJustifier = 0;
							
							for(item of data)
							{
								if(item.jour == jour)
								{	
									nombreAbsences += item.nombre_absences;
									nombreAbsencesJustifier += item.nombre_absences_justifier;
									nombreAbsencesNonJustifier += item.nombre_absences_non_justifier;	
								}
							}
							
							let set = {
									nombreAbsences: nombreAbsences,
									nombreAbsencesJustifier: nombreAbsencesJustifier,
									nombreAbsencesNonJustifier: nombreAbsencesNonJustifier
							};
			
							dataset.push(set);
						}
					return dataset;
			}
		}
			
		function getFormatedDataset(dataset)
		{
			let nombresAbsences = [];
			let nombresAbsencesJustifier = [];
			let nombresAbsencesNonJustifier = [];
						
			for(let i = 0; i < dataset.length; i++)
			{
				nombresAbsences.push(dataset[i].nombreAbsences);
				nombresAbsencesJustifier.push(dataset[i].nombreAbsencesJustifier);
				nombresAbsencesNonJustifier.push(dataset[i].nombreAbsencesNonJustifier);
			}
			
			let result = [nombresAbsences, nombresAbsencesJustifier, nombresAbsencesNonJustifier];
			
			return result;
		}
	});
	</script>
</body>
</html>