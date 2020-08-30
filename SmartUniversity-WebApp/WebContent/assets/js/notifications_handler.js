$(document).ready(function(){
	let interval = 10000;
	let badge = $("#notificationsBadge");
	let divNotifs = $("#append-notifications");
	let dropdownNotifs = $("#div-dropdown-notifications");
	let idsNewNotifications = [];

	function DeleteNotification(id)
	{
		let response = $.ajax({
	        type: "GET",
	        url: "/SmartUniversity-WebApp/User/DeleteNotification",
	        data: { 
	            id_notification	: id
	          },
	        async: false,
	        success: function () { 
	        },
	        dataType:'json',
	        error: function() {
	        }
	    });
	}
	
	function setNotificationVue(id_notifications)
	{
		for(id of id_notifications)
		{		
			let response = $.ajax({
		        type: "GET",
		        url: "/SmartUniversity-WebApp/User/SetNotificationVue",
		        data: { 
		            id_notification	: id
		          },
		        async: false,
		        success: function () { 
		        },
		        dataType:'json',
		        error: function() {
		        }
		    });
		}
	}
	
	function updateNotifications(interval = 0)
	{
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
	        dataType:'json',
	        error: function() {
				badge.removeClass();
				badge.addClass("badge badge-primary");
	    		badge.html(0);
	    		divNotifs.empty();
	    		divNotifs.append(getEmptyTemplate());
	        }
	    });
	}
	
	function getNotifications()
	{
		let response = $.ajax({
	        type: "GET",
	        url: "/SmartUniversity-WebApp/User/GetNotificationsEnseignant",
	        async: true,
	        success: function () { 
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
	        dataType:'json',
	        error: function() {
				badge.removeClass();
				badge.addClass("badge badge-primary");
	    		badge.html(0);
	    		divNotifs.empty();
	    		divNotifs.append(getEmptyTemplate());
	        }
	    });
	}
	
	updateNotifications(interval);
	
	dropdownNotifs.on("shown.bs.dropdown",function (){
		getNotifications();
	});
	
	dropdownNotifs.on("hidden.bs.dropdown",function (){
		setNotificationVue(idsNewNotifications);
		getNotifications();
	});

	$("body").on('click',".delete_notification", function(e){
		e.preventDefault();
		let id = $(this).data("id");
		DeleteNotification(id);
		getNotifications();
	});
	
	function handleNotifications(notifications)
	{
		divNotifs.empty();
		idsNewNotifications = [];
		let notificationsChangement = notifications.notificationsChangement;
		let notificationsSupp = notifications.notificationsSupp;
		let notificationsAll = notificationsChangement.concat(notificationsSupp);
		let numberOfNotifs = notificationsAll.length;
		
		notificationsAll.sort(function(a,b){
			  return new Date(b.date_creation) - new Date(a.date_creation);
			});
		
		for(item of notificationsAll)
		{
			let template;
		
			let text = getNotificationText(item);
			let date = formatDate(getNotificationDate(item));
			let isVue = item.is_vue;
			let id = item.id_notification;
			
			template = getTemplate(text, date, getNotificationCode(item), id, isVue);
			
			if(!item.is_vue)
				idsNewNotifications.push(item.id_notification);
		
			divNotifs.append(template);
		}
		
		//set the number of notifs and the color of the badge
		badge.html(idsNewNotifications.length);
		badge.removeClass();
		if(idsNewNotifications.length == 0)
			badge.addClass("badge badge-primary");
		else
			badge.addClass("badge badge-danger");
		
		console.log(notificationsAll);
	}
	
	function getTemplate(text, date, code, id, isVue)
	{
		let template;
		if(!isVue)
		{
			 template = 
				'<div class="dropdown-item dropdown-notification" >'
			+		'<div class="notification-read">'
			+			'<sup><span class="badge badge-danger mr-2">Nouveau</span></sup>' 
			+			'<a href="" class="delete_notification" data-id="' +id+ '"><i class="fa fa-times" aria-hidden="true"></i></a>'
			+		'</div>'
			+		'<div class="notifications-body">'
			+			'<a href="/SmartUniversity-WebApp/User/ConsulterSeanceEnseignant?code-seance=' + code + '" class="nav-link notification-texte">'
			+				'' + text + ''
			+			'</a>'
			+			'<p class="notification-date text-muted">'
			+				'<i class="fa fa-clock-o" aria-hidden="true"></i> ' + date + ''
			+			'</p>'
			+		'</div>'
			+	'</div>';
		}
		else
		{
			template = 
				'<div class="dropdown-item dropdown-notification" >'
			+		'<div class="notification-read">'
			+			'<a href="" class="delete_notification" data-id="' +id+ '"><i class="fa fa-times" aria-hidden="true"></i></a>'
			+		'</div>'
			+		'<div class="notifications-body">'
			+			'<a href="/SmartUniversity-WebApp/User/ConsulterSeanceEnseignant?code-seance=' + code + '" class="nav-link notification-texte">'
			+				'' + text + ''
			+			'</a>'
			+			'<p class="notification-date text-muted">'
			+				'<i class="fa fa-clock-o" aria-hidden="true"></i> ' + date + ''
			+			'</p>'
			+		'</div>'
			+	'</div>';
		}

		
		return template;
	}

	function getEmptyTemplate()
	{
		let template = 
							'<div class="dropdown-item dropdown-notification" >'
						+		'<div class="notifications-body">'
						+			'<div href="" class="notification-texte">'
						+				'Vous n\'avez aucune notification pour le moment'
						+			'</div>'
						+		'</div>'
						+	'</div>';
		
		return template;
	}
	
	function getNotificationText(notification)
	{
		let n_data;
		let etat = notification.etat_demande_notifier;
		if(notification.seanceSupp)
		{
			return "Séance supplémentaire " + capitalizeFirstLetter(etat);
		}
		else
		{
			return "Changement d'horaire " + capitalizeFirstLetter(etat);
		}
	}
	
	function getNotificationCode(notification)
	{
		if(notification.seanceSupp)
		{
			return notification.seanceSupp.code_seance;
		}
		else
		{
			return notification.changementSeance.code_seance;
		}
	}
	
	function getNotificationDate(notification)
	{
		return notification.date_creation;
	}
	
	function capitalizeFirstLetter(string) 
	{
		  return string.charAt(0).toUpperCase() + string.slice(1);
	}

	function formatDate(date)
	{
		let nDate = new Date(date);
		
		return nDate.getFullYear() + '-' +('0' + (nDate.getMonth()+1)).slice(-2)+ '-' +  ('0' + nDate.getDate()).slice(-2) + ' | '+nDate.getHours()+ ':'+('0' + (nDate.getMinutes())).slice(-2);
	}
	
	$("body").on('click', '.dropdown-item', function (e) {
		  e.stopPropagation();
      })
});
