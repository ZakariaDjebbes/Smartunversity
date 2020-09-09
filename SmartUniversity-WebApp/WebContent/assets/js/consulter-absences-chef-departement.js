$(document).ready(function () {
	
	let tablePageLength = 25;
	
	let table =  $('#table-absences').dataTable({
        "sDom": '<"top"f>rt<"bottom"p><"clear">',
		"pageLength": tablePageLength,
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
	
	$('input:checkbox[name="justification"]').on('change', function() {
		filterByJustification();
	});
	
	function filterByJustification() 
	{
		  //build a filter string with an or(|) condition
		  let justifications = $('input:checkbox[name="justification"]:checked').map(function() {
			  return '^' + this.value + '\$';
		  }).get().join('|');
		  //now filter in column 2, with no regex, no smart filtering, no inputbox,not case sensitive
		  table.fnFilter(justifications, 2, true, false, false, false);
	}
});

function lowerize(string) 
{
	  return string.charAt(0).toLowerCase() + string.slice(1);
}