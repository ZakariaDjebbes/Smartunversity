$(document).ready(function () {
	let table =  $('#table-etudiants').DataTable({
        "sDom": 'B<"top"f>rt<"bottom"lp><"clear">',
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
       	buttons: [
            { 
            	extend: 'excelHtml5', 
            	className: 'btn-outline-success', text:'Excel <i class="fa fa-file-excel"></i>', 
            	exportOptions : {
            		columns: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], 
                },
                init: function(api, node, config) {
                    $(node).removeClass('btn-secondary')
                }
            },
            { 
            	extend: 'pdfHtml5', 
            	className: 'btn-outline-danger', 
            	text:'PDF <i class="fa fa-file-pdf"></i>', 
            	exportOptions : {
            		columns: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
            	},
            	orientation: 'landscape', 
            	pageSize: 'LEGAL',
                init: function(api, node, config) {
                    $(node).removeClass('btn-secondary')
                }
            },
            { 
            	extend: 'csvHtml5', 
            	className: 'btn-outline-secondary', 
            	text:'CSV <i class="fa fa-table"></i>', 
            	exportOptions : {
            		columns: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
            	},
                init: function(api, node, config) {
                    $(node).removeClass('btn-secondary')
                }
            },
            ]
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