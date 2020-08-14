$(document).ready(function () {
    $('#btn-download-excel').on('click', function(e){
        $("#table-relever").table2excel({
            exclude: ".noExport",
            name: "Relever d'absences",
            filename: "relever-absences-etudiant-excel",
        });
    });
	
    $("#btn-download-csv").on('click', function(){
    	$('#table-relever').table2csv();
    });
});