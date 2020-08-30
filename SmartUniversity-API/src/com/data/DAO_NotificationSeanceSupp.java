package com.data;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.modele.NotificationSeanceSupp;
import com.modele.Seance.Etat_Demande;

public class DAO_NotificationSeanceSupp extends DAO_Initialize
{
	public static int CreateNotificationSupp(int code_seance_supp, int id_utilisateur, Etat_Demande etat)
	{
		int id_notification = DAO_Notification.CreateNotification(id_utilisateur, etat);
		
		if(id_notification == -1)
		{
			return -1;
		}
		
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			
			String command = "INSERT INTO notificationseancesupp VALUES(?, ?);";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setInt(1, id_notification);
				statement.setInt(2, code_seance_supp);
				
				if(statement.executeUpdate() == 1) return id_notification;
				else return -1;
			}
		}
		catch(Exception e)
		{
			System.out.println("Connection error in " + Thread.currentThread().getStackTrace()[1].getMethodName()
					+ " >>> " + e.getMessage());
			return -1;
		}
	}
	
	public static ArrayList<NotificationSeanceSupp> GetNotificationsSuppOfUser(int id_utilisateur)
	{
		ArrayList<NotificationSeanceSupp> result = new ArrayList<NotificationSeanceSupp>();

		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "SELECT * FROM notificationSeanceSupp WHERE id_notification IN (SELECT id_notification FROM notification WHERE id_utilisateur = ?);";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setInt(1, id_utilisateur);

				try (ResultSet resultSet = statement.executeQuery())
				{
					while (resultSet.next())
					{
						int id_notification = resultSet.getInt(1);
						int code_seance_supp = resultSet.getInt(2);
						result.add(new NotificationSeanceSupp(DAO_Notification.GetNotification(id_notification),
								DAO_SeanceSupp.GetSeanceSupp(code_seance_supp)));
					}

					return result;
				}
			}
		} catch (Exception e)
		{
			System.out.println("Connection error in " + Thread.currentThread().getStackTrace()[1].getMethodName()
					+ " >>> " + e.getMessage());
			return null;
		}
	}
}
