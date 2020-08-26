package com.helpers;

import java.util.ArrayList;

import javax.xml.bind.annotation.XmlRootElement;

import com.modele.NotificationChangementSeance;
import com.modele.NotificationSeanceSupp;

@XmlRootElement
public class NotificationResponse
{
	private ArrayList<NotificationSeanceSupp> notificationsSupp;
	private ArrayList<NotificationChangementSeance> notificationsChangement;
	
	public NotificationResponse()
	{
		
	}

	public NotificationResponse(ArrayList<NotificationSeanceSupp> notificationsSupp,
			ArrayList<NotificationChangementSeance> notificationsChangement)
	{
		this.notificationsSupp = notificationsSupp;
		this.notificationsChangement = notificationsChangement;
	}

	public ArrayList<NotificationSeanceSupp> getNotificationsSupp()
	{
		return notificationsSupp;
	}

	public ArrayList<NotificationChangementSeance> getNotificationsChangement()
	{
		return notificationsChangement;
	}

	public void setNotificationsSupp(ArrayList<NotificationSeanceSupp> notificationsSupp)
	{
		this.notificationsSupp = notificationsSupp;
	}

	public void setNotificationsChangement(ArrayList<NotificationChangementSeance> notificationsChangement)
	{
		this.notificationsChangement = notificationsChangement;
	}
}
