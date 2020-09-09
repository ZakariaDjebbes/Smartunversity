$(document).ready(function () {

	//Keep the current tab open on page reloaded
	$(function() { 
		  $('a[data-toggle="pill"]').on('click', function (e) {
		    //save the latest tab; use cookies if you like 'em better:
		    localStorage.setItem('lastTab', $(e.target).attr('href'));
		  });

		  //go to the latest tab, if it exists:
		  let lastTab = localStorage.getItem('lastTab');

		  if (lastTab) 
		  {
		    $('a[href="'+lastTab+'"]').click();
		  }
		  else
		  {
			  $('a[data-toggle="pill"]:first').tab('show');  
		  }
		});
	
	//datatable table-presence	
	let tablePresencePageLength = 35;
	
	let tablePresence =  $('#table-presence').DataTable({
	        "sDom": '<"top"f>rt<"bottom"p><"clear">',
			"pageLength": tablePresencePageLength,
	        "oLanguage": {
	        	"oPaginate": {
	        					"sPrevious": "Précédant", 
	        					"sNext": "Suivant", 
	        				 },
				"sSearch": "Chercher: ",
				"sZeroRecords": "Aucun étudiant n'a été trouver.",
	        	},
        	"columnDefs": [
           	    { "orderable": false, "targets": 3 }
           	  ],  
	    });	
	
	//datatable table-etudiants-exclus
	
	let tableEtudiantsExclusPageLength = 35;
	
	let tableEtudiantsExclus =  $('#table-etudiants-exclus').DataTable({
        "sDom": 'B<"top"f>rt<"bottom"p><"clear">',
		"pageLength": tableEtudiantsExclusPageLength,
        "oLanguage": {
        	"oPaginate": {
        					"sPrevious": "Précédant", 
        					"sNext": "Suivant", 
        				 },
			"sSearch": "Chercher: ",
			"sZeroRecords": "Aucun étudiant n'a été trouver.",
        	},
            buttons: [
                { extend: 'excelHtml5', className: 'btn btn-outline-success', text:'Excel <i class="fa fa-file-excel-o"></i>' },
                { extend: 'pdfHtml5', className: 'btn btn-outline-danger', text:'PDF <i class="fa fa-file-pdf-o"></i>' },
                { extend: 'csvHtml5', className: 'btn btn-outline-secondary', text:'CSV <i class="fa fa-table"></i>'},
            ]
    });	
	
	//datatable table-seances-supp
	
	let tableSeancesSuppPageLength = 10;
	
	let tableSeancesSupp =  $('#table-seances-supp').DataTable({
        "sDom": '<"top">rt<"bottom"p><"clear">',
		"pageLength": tableSeancesSuppPageLength,
        "oLanguage": {
        	"oPaginate": {
        					"sPrevious": "Précédant", 
        					"sNext": "Suivant", 
        				 },
			"sSearch": "Chercher: ",
        	},
    	"columnDefs": [
       	    { "orderable": false, "targets": 3 }
       	  ],  
    });	
	
	//telecharger table-etudiants-exclus au format excel
    $('#telecharger-etudiants-exclus-excel').on('click', function(e){
        $("#table-etudiants-exclus").table2excel({
            exclude: ".noExport",
            name: "Etudiants exclus",
            filename: "etudiants-exclus-to-excel",
        });
    });
	
    $("#telecharger-etudiants-exclus-csv").on('click', function(){
    	$('#table-etudiants-exclus').table2csv();
    });
});