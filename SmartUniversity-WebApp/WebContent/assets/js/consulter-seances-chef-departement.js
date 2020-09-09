$(document).ready(function () {
	
	let tablePageLength = 25;
	
	let table =  $('#table-seances').DataTable({
	        "sDom": '<"top"f>rt<"bottom"p><"clear">',
			"pageLength": tablePageLength,
	        "oLanguage": {
	        	"oPaginate": {
	        					"sPrevious": "Précédant", 
	        					"sNext": "Suivant", 
	        				 },
				"sSearch": "Chercher: ",
				"sZeroRecords": "Aucune séance ne correspond aux filtres",
	        	},
        	"columnDefs": [
           	    { "orderable": false, "targets": 8 }
           	  ],  
	    });
	
	let selectOptions = ["Module","Jour","Heure","Spécialité","Type","Groupe","Année"];
	
    
    
    function clearDoublesOfSelects()
    {
    	for(selectOption of selectOptions)
    	{
    		let options = $('#select-'+ lowerize(selectOption) +' option');

    		let exist = {};
	        
    		options.each(function() {
	            if (exist[$(this).val()]){
	                $(this).remove();
	            }else{
	                exist[$(this).val()] = true;
	            }
	        });
    	}
    }
    
    
    function sortSelects()
    {
    	for(selectOption of selectOptions)
    	{
    		let options = $('#select-'+ lowerize(selectOption) +' option').not(':first');

    		let arr = options.map(function(_, o) { return { t: $(o).text(), v: o.value }; }).get();
            arr.sort(function(o1, o2) { 
        	  let t1 = o1.t.toLowerCase(), t2 = o2.t.toLowerCase();

        	  return t1 > t2 ? 1 : t1 < t2 ? -1 : 0; 
            });
            options.each(function(i, o) {
	            o.value = arr[i].v;
	            $(o).text(arr[i].t);
            });	
	
    	}    	
    }
   
    function handleFilterOptions()
    {
    	let selects = [];
    	let cols = [];
    	let params;
    	
    	for(selectOption of selectOptions)
    	{
    		
    		selects.push($("#select-" + lowerize(selectOption)));
    		cols.push(table.column(":contains("+selectOption+")"));
    	}
    	
    	for(let i = 0; i < selects.length; i++)
    	{
    		selects[i].on('change', function(){
    			let select = $(this);
    			    			
    			if(selectOptions.includes(select.val()))
    			{
            	    cols[i].search('').draw();
    			}
    			else
    			{
    				cols[i].search(select.val()).draw();
    			}
    		});
    	}
    }
    
    $("#btn-reinit").on('click', function(){
    	table.search( '' ).columns().search( '' ).draw();    
    });

    handleFilterOptions();
    sortSelects();
    clearDoublesOfSelects();

});


function lowerize(string) 
{
	  return string.charAt(0).toLowerCase() + string.slice(1);
}