$(document).ready(function () {
	
	let tableDemandesEnseignantsPageLength = 25;
	
	let tableDemandesEnseignants =  $('#table-demandes-enseignants').dataTable({
        "sDom": '<"top"f>rt<"bottom"p><"clear">',
		"pageLength": tableDemandesEnseignantsPageLength,
		"fnDrawCallback": function(oSettings) {
	        if ($('#table-historique tr').length < tableDemandesEnseignantsPageLength) {
	            $('.dataTables_paginate').hide();
	        }
	    },
        "oLanguage": {
        	"oPaginate": {
        					"sPrevious": "Précédant", 
        					"sNext": "Suivant", 
        				 },
			"sSearch": "Chercher: ",
			"sZeroRecords": "Il n'y a aucune actuellement demande",
        	},
    	"columnDefs": [
       	    { "orderable": false, "targets": 4 },
       	    { "orderable": false, "targets": 2 }
       	  ],  
    });
	
	$('input:checkbox[name="type_demande_enseignant"], input:checkbox[name="etat_demande_enseignant"]').on('change', function() {
		filterTableEnseignants();
	});
	
	function filterTableEnseignants() 
	{
		  //build a filter string with an or(|) condition
		  let typesDemande = $('input:checkbox[name="type_demande_enseignant"]:checked').map(function() {
			  return '^' + this.value + '\$';
		  }).get().join('|');
		  //now filter in column 2, with no regex, no smart filtering, no inputbox,not case sensitive
		  tableDemandesEnseignants.fnFilter(typesDemande, 1, true, false, false, false);
		  
		  //build a filter string with an or(|) condition
		  let etatsDemandes = $('input:checkbox[name="etat_demande_enseignant"]:checked').map(function() {
			  return '^' + this.value + '\$';
		  }).get().join('|');
		  //now filter in column 2, with no regex, no smart filtering, no inputbox,not case sensitive
		  tableDemandesEnseignants.fnFilter(etatsDemandes, 3, true, false, false, false);
	}
	
	let tableDemandesEtudiantsPageLength = 25;
	
	let tableDemandesEtudiants =  $('#table-demandes-etudiants').dataTable({
        "sDom": '<"top"f>rt<"bottom"p><"clear">',
		"pageLength": tableDemandesEtudiantsPageLength,
		"fnDrawCallback": function(oSettings) {
	        if ($('#table-historique tr').length < tableDemandesEtudiantsPageLength) {
	            $('.dataTables_paginate').hide();
	        }
	    },
        "oLanguage": {
        	"oPaginate": {
        					"sPrevious": "Précédant", 
        					"sNext": "Suivant", 
        				 },
			"sSearch": "Chercher: ",
			"sZeroRecords": "Il n'y a aucune actuellement demande",
        	},
    	"columnDefs": [
       	    { "orderable": false, "targets": 1 },
       	    { "orderable": false, "targets": 3 }
       	  ],  
    });
	
	$('input:checkbox[name="etat_demande_etudiant"]').on('change', function() {
		filterTableEtudiants();
	});
	
	function filterTableEtudiants() 
	{
		  //build a filter string with an or(|) condition
		  let etatsDemandes = $('input:checkbox[name="etat_demande_etudiant"]:checked').map(function() {
			  return '^' + this.value + '\$';
		  }).get().join('|');
		  //now filter in column 2, with no regex, no smart filtering, no inputbox,not case sensitive
		  tableDemandesEtudiants.fnFilter(etatsDemandes, 2, true, false, false, false);
	}
});

function lowerize(string) 
{
	  return string.charAt(0).toLowerCase() + string.slice(1);
}