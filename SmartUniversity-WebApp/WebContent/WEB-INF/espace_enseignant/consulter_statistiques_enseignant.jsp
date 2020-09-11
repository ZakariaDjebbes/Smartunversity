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
<title><fmt:message key="pages.stats.title_enseignant"></fmt:message> - NTIC</title>
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
						<h2 class="text-success"><fmt:message key="pages.stats.title_enseignant"></fmt:message></h2>
						<p><fmt:message key="pages.stats.subtitle"></fmt:message></p>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<form>
						<div class="form-group">
							<label for="module"><fmt:message key="labels.module"></fmt:message></label>
							<select class="form-control" id="module">
								<option value="all-modules"><fmt:message key="pages.stats.all_modules"></fmt:message></option>
							</select>
						</div>
						<div class="d-none" id="groupes-d-div">
							<div class="form-group">
								<label for="groupe"><fmt:message key="labels.group"></fmt:message></label>
								<select class="form-control" id="groupe">
									<option value="all-groupes"><fmt:message key="pages.stats.all_groups"></fmt:message></option>
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
									<option class="d-none" value="stat-groupe"><fmt:message key="pages.stats.per_group"></fmt:message></option>
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
			const byDay = "jour";
			const byHour = "heure";
			const byGroup = "groupe";
			const byModule= "module";
			const titleByDay = '<fmt:message key="pages.stats.per_day_title"></fmt:message>';
			const titleByHour = '<fmt:message key="pages.stats.per_hour_title"></fmt:message>';
			const titleByGroup = '<fmt:message key="pages.stats.per_group_title"></fmt:message>';
			const titleByModule = '<fmt:message key="pages.stats.per_module_title"></fmt:message>';
			let moduleSelect = $("#module");
			let groupeSelect = $("#groupe");
			let statTypeSelect = $("#stat-type");
			let chartTypeSelect = $("#chart-type");
			let statGroupOption = $("option[value='stat-groupe']");
			let statModuleOption = $("option[value='stat-module']");			
			let heures = ["8:30", "10:00", "11:30", "13:00", "14:30"];
			
			let jours = [
				<c:forEach var="jour" items="${jours}">
				"${jour.getValue(cookie['lang'].value)}",
				</c:forEach>
			];
			
			let data = [
				<c:forEach var="seance" items="${sessionScope.seances}">
				{
					module: "${seance.getModule().getNom()}",
					code_module: "${seance.getModule().getCode_module()}",
					jour: "${seance.getSeance().getJour().getValue(cookie['lang'].value)}",
					heure: "${seance.getSeance().getHeure()}",
					groupe: ${seance.getSeance().getGroupe()},
					nombre_absences: ${seance.GetNombreAbsences()},
					nombre_absences_justifier: ${seance.GetNombreAbsencesJustifier()},
					nombre_absences_non_justifier: ${seance.GetNombreAbsencesNonJustifier()}
				},
				</c:forEach>
			];
			let current_data = data;
			let current_chart_type = byDay;
			let current_module = "all-modules";

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
		        	{
		                label: '<fmt:message key="labels.nombre_justifier"></fmt:message>',
		                backgroundColor:'rgba(152, 232, 146, 0.2)',
			            borderColor: 'rgba(152, 232, 146, 1)',
			            borderWidth: 1,
			            barPercentage: 0.5,
			            data:[]
		        	},
		        	{
		                label: '<fmt:message key="labels.nombre_non_justifier"></fmt:message>',
		                backgroundColor: 'rgba(255, 99, 132, 0.2)',
			            borderColor: 'rgba(255,99,132,1)',
			            borderWidth: 1,
			            barPercentage: 0.5,
			            data:[]
		            }   
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
			
			updateChart(chart, getDatasetAbsences(current_data, byDay), titleByDay, jours);
			setModules(data, moduleSelect);
			
			moduleSelect.on('change', function(){
				let value = this.value;
				let displayDiv = $("#groupes-d-div");
				statTypeSelect.prop('selectedIndex',0);
				current_module = value;

				if(value == "all-modules")
				{
					displayDiv.addClass("d-none");
					statGroupOption.addClass("d-none");
					statModuleOption.removeClass("d-none");
					current_data = data;
				}
				else
				{
					setGroupes(data, value, groupeSelect);
					displayDiv.removeClass("d-none");
					statGroupOption.removeClass("d-none");
					statModuleOption.addClass("d-none");
					current_data = getDataOfModule(data, value);
				}

				updateChartByValue("stat-jour");		
			});
			
			groupeSelect.on('change', function(){
				let value = this.value;
				
				if(value == "all-groupes")
				{
					statGroupOption.removeClass("d-none");
					current_data = getDataOfModule(data, current_module);
				}
				else
				{
					statGroupOption.addClass("d-none");
					current_data = getDataOfGroup(data, current_module, value);
				}
				
				updateChartByValue("stat-jour");		
			});
			
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
					updateChart(chart, getDatasetAbsences(current_data, byDay), titleByDay, jours);
					break;
				case "stat-heure":
					updateChart(chart, getDatasetAbsences(current_data, byHour), titleByHour, heures);
					break;
				case "stat-module":
					let modules = getModules();
					let codes = [];
					
					for(module of modules)
					{
						codes.push(module.code);
					}
					updateChart(chart, getDatasetAbsences(current_data, byModule), titleByModule, codes);

					break;
				case "stat-groupe":
					let groups = getGroupsOfModule(current_module);
					updateChart(chart, getDatasetAbsences(current_data, byGroup), titleByGroup, groups);
					break;
				}
			}
			
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
			
			function setModules(data, select)
			{	
				let modules = getModules();
				
				for(module of modules)
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
						
			function getDatasetAbsences(data, by)
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
					case byHour: 
						for(heure of heures)
						{
							let nombreAbsences = 0;
							let nombreAbsencesJustifier = 0;
							let nombreAbsencesNonJustifier = 0;
							
							for(item of data)
							{
								if(item.heure == heure)
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
							let nombreAbsencesJustifier = 0;
							let nombreAbsencesNonJustifier = 0;
							
							for(item of data)
							{
								if(item.code_module == code)
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
					case byGroup: 
						let groups = getGroupsOfModule(current_module)
						
						for(group of groups)
						{
							let nombreAbsences = 0;
							let nombreAbsencesJustifier = 0;
							let nombreAbsencesNonJustifier = 0;
							
							for(item of data)
							{
								if(item.groupe == group)
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
		
		function getDataOfModule(data, code)
		{
			let result = [];
			
			for(item of data)
			{
				if(item.code_module == code)
				{
					result.push(item);
				}				
			}
			
			return result;
		}
		
		function getDataOfGroup(data, code, group)
		{
			let result = [];
			
			for(item of data)
			{
				if(item.code_module == code && item.groupe == group)
				{
					result.push(item);
				}				
			}
			
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
		
		function getGroupsOfModule(code)
		{
			let groups = [];
			
			for(item of data)
			{
				if(item.code_module == code)
				{
					groups.push(item.groupe);
				}
			}
			
			let uniq_groupes = _.uniq(groups);
			
			uniq_groupes.sort(function(a, b) {
				  return a - b;
				});
			
			return uniq_groupes;
		}
	});
	</script>
</body>
</html>