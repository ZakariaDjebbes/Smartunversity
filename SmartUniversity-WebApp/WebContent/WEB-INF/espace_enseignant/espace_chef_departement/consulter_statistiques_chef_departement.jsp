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
<title><fmt:message key="pages.stats.title_chef"></fmt:message> - NTIC</title>
<base href="${pageContext.request.contextPath}/WebContent">
<link rel="icon" href="assets/img/Logo/logo.png">
<link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="assets/Datatables/datatables.min.css">
<link rel="stylesheet" href="assets/Datatables/custom-datatables.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat:400,400i,700,700i,600,600i">
<link rel="stylesheet" href="assets/fonts/font-awesome.min.css">
<link rel="stylesheet" href="assets/fonts/simple-line-icons.min.css">
<link rel="stylesheet" href="assets/css/style.css">
<link rel="stylesheet" href="assets/css/filter-select.css">
<link rel="stylesheet" href="assets/css/custom-checkbox.css">

</head>
<body>
	<jsp:include page="/WEB-INF/espace_enseignant/shared/header_enseignant.jsp"></jsp:include>
	<main class="page">
	<section class="clean-block clean-info dark">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="block-heading">
						<h2 class="text-success"><fmt:message key="pages.stats.title_chef"></fmt:message></h2>
						<p><fmt:message key="pages.stats.subtitle"></fmt:message></p>
					</div>
				</div>
			</div>
			<div class="row justify-content-center">
				<div class="col-10 text-center">
					<form>
						<div class="row">
							<div class="form-group col">
								<label for="chart-type"><fmt:message key="pages.stats.chart_type"></fmt:message></label>
								<select class="form-control" id="chart-type">
									<option value="bar"><fmt:message key="pages.stats.bar"></fmt:message></option>
									<option value="line"><fmt:message key="pages.stats.graph"></fmt:message></option>
								</select>
							</div>
							<div class="form-group col">
								<label for="stat-type"><fmt:message key="pages.stats.stat_type"></fmt:message></label>
								<select class="form-control" id="stat-type">
									<option value="stat-jour"><fmt:message key="pages.stats.per_day"></fmt:message></option>
									<option value="stat-heure"><fmt:message key="pages.stats.per_hour"></fmt:message></option>
									<option value="stat-module"><fmt:message key="pages.stats.per_module"></fmt:message></option>
									<option value="stat-enseignant"><fmt:message key="pages.stats.per_enseignant"></fmt:message></option>
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
			const departement = "${utilisateur.getCode_departement()}";
			const byDay = "jour";
			const byHour = "heure";
			const byModule= "module";
			const byEnseignant = "enseignant";
			const titleByDay = '<fmt:message key="pages.stats.per_day_title"></fmt:message>' + departement;
			const titleByHour = '<fmt:message key="pages.stats.per_hour_title"></fmt:message>' + departement;
			const titleByGroup = '<fmt:message key="pages.stats.per_group_title"></fmt:message>' + departement;
			const titleByEnseignant = '<fmt:message key="pages.stats.per_enseignant_title"></fmt:message>' + departement;
			let statTypeSelect = $("#stat-type");
			let chartTypeSelect = $("#chart-type");
			let statModuleOption = $("option[value='stat-module']");			
			
			let heures = ["8:30", "10:00", "11:30", "13:00", "14:30"];
			
			let jours = [
				<c:forEach var="jour" items="${jours}">
				"${jour.getValue(cookie['lang'].value)}",
				</c:forEach>
			];

			let data = [
				<c:forEach var="item" items="${data}">
				{
					enseignant: "${item.getEnseignant().getNom()} ${item.getEnseignant().getPrenom()}",
					module: "${item.getModule().getNom()}",
					code_module: "${item.getModule().getCode_module()}",
					jour: "${item.getSeance().getJour().getValue(cookie['lang'].value)}",
					heure: "${item.getSeance().getHeure()}",
					groupe: ${item.getSeance().getGroupe()},
					nombre_absences: ${item.getNombreAbsences()},
				},
				</c:forEach>
			];
			
			let ctx = document.getElementById('chart').getContext('2d');
			Chart.defaults.global.defaultFontFamily = "arial";
			
			let chart_data = {
	          datasets: [
		        	{
		                label: '<fmt:message key="labels.nombre_absence"></fmt:message>',
		                backgroundColor: 'rgba(54, 162, 235, 0.2)',
			            borderColor:'rgba(54, 162, 235, 1)',
			            borderWidth: 1,
			            barPercentage: 0.5,				        
			            data:[]
		        	},
	        	]
			};
			
			let chart = new Chart(ctx, {
			    type: 'bar',
			    data: chart_data,
			    options: {
			        title: {
			            display: true,
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
			updateChart(chart, getDatasetAbsences(data, byDay), titleByDay, jours);

			function updateChart(chart, data, title, labels) {
				let formated_data = getFormatedDataset(data);
				chart.options.title.text = title;
				chart.data.labels = labels;
				for(let i = 0; i < chart.data.datasets.length; i++)
				{
					chart.data.datasets[i].data = formated_data[i];	
				}
			    chart.update();
			}
			
			function changeChart(newType) {
				chart.destroy();
				chart = null;
				chart =  new Chart(ctx, {
				    type: newType,
				    data: chart_data,
				    options: {
				        title: {
				            display: true,
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
			};
			
			chartTypeSelect.on('change', function(){
				let value = this.value;
				changeChart(value);
			});

			statTypeSelect.on('change', function(){
				let value = this.value;
				current_chart_type = value;
				updateChartByValue(value)
			});
			
			function updateChartByValue(value)
			{
				switch (value) {
				case "stat-jour":
					updateChart(chart, getDatasetAbsences(data, byDay), titleByDay, jours);
					break;
				case "stat-heure":
					updateChart(chart, getDatasetAbsences(data, byHour), titleByHour, heures);
					break;
				case "stat-module":
					let modules = getModules();
					let codes = [];
					
					for(module of modules)
					{
						codes.push(module.code);
					}
					updateChart(chart, getDatasetAbsences(data, byModule), titleByModule, codes);
					break;
				case "stat-enseignant":
					let enseignants = getEnseignants();

					updateChart(chart, getDatasetAbsences(data, byEnseignant), titleByEnseignant, enseignants);
					break;
				}
			}
			
			function getDatasetAbsences(data, by)
			{
				let dataset = [];
				
				switch(by)
				{
					case byDay:
						for(jour of jours)
						{
							let nombreAbsences = 0;
							
							for(item of data)
							{
								if(item.jour == jour)
								{	
									nombreAbsences += item.nombre_absences;
								}
							}
							
							let set = {
									nombreAbsences: nombreAbsences,
							};
			
							dataset.push(set);
						}
					return dataset;
					case byHour: 
						for(heure of heures)
						{
							let nombreAbsences = 0;
							
							for(item of data)
							{
								if(item.heure == heure)
								{
									nombreAbsences += item.nombre_absences;
								}
							}
							
							let set = {
									nombreAbsences: nombreAbsences,
							};
							
							dataset.push(set);
						}
						
					return dataset;
					case byModule: 
						let modules = getModules();
						let codes = [];
						
						for(module of modules)
						{
							codes.push(module.code);
						}
						
						for(code of codes)
						{
							let nombreAbsences = 0;
							
							for(item of data)
							{
								if(item.code_module == code)
								{
									nombreAbsences += item.nombre_absences;
								}
							}
							
							let set = {
									nombreAbsences: nombreAbsences,
							};
							
							dataset.push(set);
						}
						
					return dataset;
					case byEnseignant: 
						let enseignants = getEnseignants();
						
						for(enseignant of enseignants)
						{
							let nombreAbsences = 0;
							
							for(item of data)
							{
								if(item.enseignant == enseignant)
								{
									nombreAbsences += item.nombre_absences;
								}
							}
							
							let set = {
									nombreAbsences: nombreAbsences,
							};
							
							dataset.push(set);
						}
						
					return dataset;
			}
		}
			
		function getFormatedDataset(dataset)
		{
			let nombresAbsences = [];
						
			for(let i = 0; i < dataset.length; i++)
			{
				nombresAbsences.push(dataset[i].nombreAbsences);
			}
			
			let result = [nombresAbsences];
			
			return result;
		}	
			
		function getModules()
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
			
			return uniq_modules;
		}
		
		function getEnseignants()
		{
			let enseignants = [];
			
			for(item of data)
			{				
				enseignants.push(item.enseignant);
			}
			
			let uniq_enseignants = _.uniq(enseignants);

			let index = uniq_enseignants.indexOf(" ");

			if (index !== -1) {
				uniq_enseignants.splice(index, 1)
			}
			
			return uniq_enseignants;
		}
	});
	</script>
</body>
</html>