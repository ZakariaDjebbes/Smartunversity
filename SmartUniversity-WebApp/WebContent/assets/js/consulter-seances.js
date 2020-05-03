$(document).ready(function () {
	//marquer la présence handlers
	$(".marquer-presence").submit(function (event) {
		let $form = $(this);
		let submitButton = $(this).find("input[type=submit]:focus");
		let disabledTime = 6;

		submitButton.prop("disabled",true);
		setTimeout(function () {
			submitButton.prop('disabled', false);
		}, disabledTime * 1000);
		startSubmitTimer(disabledTime - 1,submitButton);

		$.post($form.attr("action"),$form.serialize(),function (response) {
				alertify.set(
					'notifier',
					'position',
					'top-center');
				alertify.set(
					'notifier',
					'delay',
					3);
				if (response == "true") 
				{
					alertify.success("Présence marqué!");
				} else 
				{
					alertify.error("Une erreur s'est produite.");
				}
			});
		event.preventDefault();
	});

	//Oprations handler
	let button_marquer = $(".button-marquer");
	let button_releve = $(".button-releve");
	let button_exclus = $(".button-exclus");
	let button_changement = $(".button-changement");
	
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
	}
});

function startSubmitTimer(duration, submit) {
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
