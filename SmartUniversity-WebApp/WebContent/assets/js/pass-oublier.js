$(document).ready(function(){
	let error_alert = $("#error-alert");
	let code_group = $("#code-group");
	let pass_group = $("#pass-group");
	let result_alert = $("#result-alert");
	let can_send = true;
	
	error_alert.hide();
	code_group.hide();
	pass_group.hide();
	result_alert.hide();
	
	function SendEmail(email)
	{		
		can_send = false;

		$("#email-submit").prop("disabled", true);
		$("#email-submit > i").show("fast");
		
		let call = $.ajax({
	        type: "POST",
	        url: "/SmartUniversity-WebApp/MotDePasseOublier",
	        async: true,
	        data:{
	        	"email" : email
	        },
	        success: function (response) {
	        	if(response === "")
	        	{
	        		showCodeGroup();	
	        	}
	        	else
	        	{
	        		setMessage(response);
	        	}
	        	can_send = true;
	        	$("#email-submit").prop("disabled", false);
	        	$("#email-submit > i").hide("fast");
	        },
	        dataType:'text',
	        error: function() {
        		can_send = true;
        		$("#email-submit").prop("disabled", false);
	        	$("#email-submit > i").hide("fast");
	        }
	    });
	}
	
	function SendCode(code)
	{		
		can_send = false;
		$("#code-submit").prop("disabled", true);
		$("#code-submit > i").show("fast");
		
		let call = $.ajax({
	        type: "GET",
	        url: "/SmartUniversity-WebApp/ModifierMotDePasse",
	        async: true,
	        data:{
	        	"code" : code
	        },
	        success: function (response) {
	        	if(response === "")
	        	{
	        		showPassGroup();	
	        	}
	        	else
	        	{
	        		setMessage(response);
	        	}
	        	
        		can_send = true;
        		$("#code-submit").prop("disabled", false);
	        	$("#code-submit > i").hide("fast");
	        },
	        dataType:'text',
	        error: function() {
	        	can_send = true;
	    		$("#code-submit").prop("disabled", false);
	        	$("#code-submit > i").hide("fast");
	        }
	    });
	}
	
	function SendPass(pass)
	{		
		can_send = false;
		$("#pass-submit").prop("disabled", true);
		$("#pass-submit > i").show("fast");
		
		let call = $.ajax({
	        type: "POST",
	        url: "/SmartUniversity-WebApp/ModifierMotDePasse",
	        async: true,
	        data:{
	        	"pass" : pass
	        },
	        success: function (response) {
	        	setResult(response);
        		can_send = true;
        		$("#pass-submit").prop("disabled", false);
        		$("#pass-submit > i").hide("fast");
	        },
	        dataType:'text',
	        error: function() {
	        	can_send = true;
        		$("#pass-submit").prop("disabled", false);
	    		$("#pass-submit > i").hide("fast");
	        }
	    });
	}
	
	$("#email-submit").on('click', function(e){
	    e.preventDefault();
	    let email = $("#email").val();
	    if(can_send)
	    {
		    SendEmail(email);
	    }
	});
	
	$("#code-submit").on('click', function(e){
	    e.preventDefault();
	    let code = $("#code").val();
	    if(can_send)
	    {
		    SendCode(code);
	    }
	});
	
	$("#pass-submit").on('click', function(e)
	{
		e.preventDefault();
	    let pass = $("#pass").val();
	    if(can_send)
	    {
		    SendPass(pass);
	    }
	});
	
	function showCodeGroup()
	{
		error_alert.hide("fast");
		$("#email-group").hide("fast", function(){
			code_group.show("fast");
		});
	}
	
	function showPassGroup()
	{
		error_alert.hide("fast");
		code_group.hide("fast", function(){
			pass_group.show("fast");
		});
	}
	
	function setMessage(message)
	{
		error_alert.html(message);
		error_alert.show("fast");
	}
	
	function setResult(result)
	{
		result_alert.html(result);
		result_alert.show("fast");
	}
});