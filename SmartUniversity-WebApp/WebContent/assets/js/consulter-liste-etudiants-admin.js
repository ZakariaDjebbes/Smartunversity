$(document).ready(function () {
	let table =  $('#table-etudiants').DataTable({
        "sDom": '<"top"f>rt<"bottom"lp><"clear">',
        "oLanguage": {
        	"oPaginate": {
        					"sPrevious": "Précédant", 
        					"sNext": "Suivant", 
        				 },
			"sSearch": "Chercher: ",
			"sZeroRecords": "Aucun compte étudiant",
        	},
        "bAutoWidth": false,
    	"columnDefs": [
       	    { "orderable": false, "targets": 12 }
       	  ],  
    });
	
	$('input[type="checkbox"].display-cb:not(:checked)').each(function(){
	    let colIndex = parseInt($(this).attr('data-target'));
	    table.column(colIndex).visible(false);
	});
	
	$('input[type="checkbox"].display-cb').on('change', function(e) {

	    let colIndex = parseInt($(this).attr('data-target'));
	   
	    // Toggle the visibility
	    table.column(colIndex).visible(!table.column(colIndex).visible());
	});
});