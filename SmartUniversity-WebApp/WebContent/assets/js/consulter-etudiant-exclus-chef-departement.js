$(document).ready(function(){
let tablePageLength = 30;
	
	let table = $('#table-etudiants-exclus').dataTable({
        "sDom": 'B<"top"f>rt<"bottom"p><"clear">',
		"pageLength": tablePageLength,
        "oLanguage": {
        	"oPaginate": {
        					"sPrevious": "Précédant", 
        					"sNext": "Suivant", 
        				 },
			"sSearch": "Chercher: ",
			"sZeroRecords": "Aucun étudiant exclu",
        	},
            buttons: [
                { extend: 'excelHtml5', className: 'btn btn-outline-success', text:'Excel <i class="fa fa-file-excel-o"></i>' },
                { extend: 'pdfHtml5', className: 'btn btn-outline-danger', text:'PDF <i class="fa fa-file-pdf-o"></i>' },
                { extend: 'csvHtml5', className: 'btn btn-outline-secondary', text:'CSV <i class="fa fa-table"></i>'},
            ]
    });
	
	$('#btn-download-excel').on('click', function(e){
		$('#table-etudiants-exclus').table2excel({
            exclude: ".noExport",
            name: "Liste des étudiants exclus",
            filename: "etudiants-exclus-excel",
        });
    });
	
    $("#btn-download-csv").on('click', function(){
    	$('#table-etudiants-exclus').table2csv();
    });
});