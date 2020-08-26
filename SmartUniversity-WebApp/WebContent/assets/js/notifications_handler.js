$(document).ready(function(){
	function getNotifications()
	{
		const interval = 10000; //millis
		
		let response = $.ajax({
	        type: "GET",
	        url: "/SmartUniversity-WebApp/User/GetNotificationsEnseignant",
	        async: true,
	        success: function () { 
		        setTimeout(function(){getNotifications();}, interval);
		        if(response.status === 200)
		        {
		        	let notifications = response.responseJSON;
		        	handleNotifications(notifications);
			        
		        }
		        else 
		        {
		        	console.log("Error");
				}
	        },
	        dataType:'json'
	    });
	}
	getNotifications();
	
	function handleNotifications(notifications)
	{
		let divNotifs = $("#append-notifications");
		console.log(notifications);
	}
	
	function getTemplate()
	{
		let template = 
							'<a class="dropdown-item dropdown-notification" href="#">'
						+		'<div class="notification-read">'
						+			'<sup><span class="badge badge-danger">Nouveau</span></sup>' 
						+			'<i class="fa fa-times" aria-hidden="true"></i>'
						+		'</div>'
						+		'<div class="notifications-body">'
						+			'<p class="notification-texte">'
						+				'Séance supplémentaire <span class="text-success">accepté</span>'
						+			'</p>'
						+			'<p class="notification-date text-muted">'
						+				'<i class="fa fa-clock-o" aria-hidden="true"></i> 10 Juin à 15:30'
						+			'</p>'
						+		'</div>'
						+	'</a>';
		
		return template;
	}
});
