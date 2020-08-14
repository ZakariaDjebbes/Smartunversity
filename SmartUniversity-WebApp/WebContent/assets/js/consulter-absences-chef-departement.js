$(document).ready(function () {
	
	let tablePageLength = 25;
	
	let table =  $('#table-absences').DataTable({
        "sDom": '<"top"f>rt<"bottom"p><"clear">',
		"pageLength": tablePageLength,
		"fnDrawCallback": function(oSettings) {
	        if ($('#table-historique tr').length < tablePageLength) {
	            $('.dataTables_paginate').hide();
	        }
	    },
        "oLanguage": {
        	"oPaginate": {
        					"sPrevious": "Précédant", 
        					"sNext": "Suivant", 
        				 },
			"sSearch": "Chercher: ",
			"sZeroRecords": "Aucune absence ne correspond aux filtres",
        	},
    	"columnDefs": [
       	    { "orderable": false, "targets": 5 }
       	  ],  
    });
	
	//TODO ajouter les filtres par etat justification...
});

function lowerize(string) 
{
	  return string.charAt(0).toLowerCase() + string.slice(1);
}