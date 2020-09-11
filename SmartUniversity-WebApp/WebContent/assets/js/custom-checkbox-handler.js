$(document).ready(function() {
	let checkedText = "Present";
	let uncheckedText = "Absent";
	
	$(".checkbox-input").change(function()
	{
		let checkbox = $(this);
		let isChecked = checkbox.prop("checked");
		
		if(isChecked) 
		{
			checkbox.next().text(checkedText);
	    }
		else
		{
			checkbox.next().text(uncheckedText);
		}	
	});
});