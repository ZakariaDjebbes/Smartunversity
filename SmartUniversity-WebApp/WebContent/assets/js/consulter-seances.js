$(document).ready(function () {
	
	let tablePageLength = 25;
	
	//data table
    let table =  $('#table-seances').DataTable({
    	"sDom": '<"pull-right"f><"top">rt<"bottom">p<"clear">',
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
			"sZeroRecords": "Aucune séance ne correspond aux filtres",
        	},
    	"columnDefs": [
       	    { "orderable": false, "targets": 7 }
       	  ],      	
    });
    
    
    //filter options
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

	//Oprations handler
	let button_marquer = $(".button-marquer");
	let button_releve = $(".button-releve");
	let button_exclus = $(".button-exclus");
	let button_changement = $(".button-changement");
	let button_seance_supp = $(".button-seance-supp");
	
	button_marquer.click(function(){
		let button = $(this);
		let current = button.prop("value");
		let type = "marquer";	
		
		toggleButton(button);
		toggleOperation(current, type);
	});

	button_releve.click(function(){
		let button = $(this);
		let current = button.prop("value");
		let type = "releve";

		toggleButton(button);
		toggleOperation(current, type);
	});
	 
	button_exclus.click(function(){
		let button = $(this);
		let current = button.prop("value");
		let type = "exclus";
		
		toggleButton(button);
		toggleOperation(current, type);
	});

	button_changement.click(function(){
		let button = $(this);
		let current = button.prop("value");
		let type = "changement";
		
		toggleButton(button);
		toggleOperation(current, type);
	});

	button_seance_supp.click(function(){
		let button = $(this);
		let current = button.prop("value");
		let type = "seance-supp";
		
		toggleButton(button);
		toggleOperation(current, type);
	});
	
	function toggleButton(button)
	{
		if(button.hasClass('active'))
		{
			button.removeClass('active');
		}
		else
		{	
			disactivateButtons();
			button.addClass('active');
		}
	}

	function disactivateButtons()
	{
		button_changement.removeClass('active');
		button_marquer.removeClass('active');
		button_releve.removeClass('active');
		button_exclus.removeClass('active');
		button_seance_supp.removeClass('active');
	}

	function toggleOperation(current, type)
	{
		let previous = null;
		
		if($("#content-marquer-" + current).is(":visible"))
		{
			previous = "marquer";
		}
		else if($("#content-exclus-" + current).is(":visible"))
		{
			previous = "exclus";
		}
		else if($("#content-releve-" + current).is(":visible"))
		{
			previous = "releve";
		}
		else if($("#content-changement-" + current).is(":visible"))
		{
			previous = "changement";
		}
		else if($("#content-seance-supp-" + current).is(":visible"))
		{
			previous ="seance-supp";
		}
		
		let target = $("#content-" + type + "-" + current);

		if(previous == null)
		{	
			target.fadeIn("fast");
		}
		else
		{
			if(previous == type)
			{
				target.fadeOut("fast");
			}
			else
			{
				$("#content-" + previous + "-" + current).fadeOut("fast", function(){
				target.fadeIn("fast");
				});
			}
		}
	}});
	
	function startSubmitTimer(duration, submit) 
	{
		let timer = duration, minutes, seconds;
		let initialValue = submit.prop('value');
	
		let interval = setInterval(function () {
			minutes = parseInt(timer / 60, 10);
			seconds = parseInt(timer % 60, 10);
	
			minutes = minutes < 10 ? "0" + minutes : minutes;
			seconds = seconds < 10 ? "0" + seconds : seconds;
	
			submit.prop('value', initialValue + '(' + seconds + ')');
	
			if (--timer < 0) {
				clearInterval(interval);
				submit.prop('value', initialValue);
			}
		}, 1000);
	}
	
	function lowerize(string) 
	{
		  return string.charAt(0).toLowerCase() + string.slice(1);
	}