$(document).ready(function(){
	function getNotifications()
	{
		const interval = 10000; //millis
		
		let notifications = $.ajax({
	        type: "GET",
	        url: "/User/GetNotificationsEnseignant",
	        async: true
	    }).success(function(){
	        setTimeout(function(){getNotifications();}, interval);
	    }).parseJson();
		
		console.log(notifications);
	}
	console.log("JesuisuneBite");
	getNotifications();
});
