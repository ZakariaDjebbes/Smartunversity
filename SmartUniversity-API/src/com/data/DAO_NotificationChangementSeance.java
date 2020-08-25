package com.data;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.modele.NotificationChangementSeance;
import com.modele.Seance.Etat_Demande;

public class DAO_NotificationChangementSeance extends DAO_Initialize
{
	public static int CreateNotificationChangement(String code_seance, int id_utilisateur, Etat_Demande etat)
	{
		int id_notification = DAO_Notification.CreateNotification(id_utilisateur, etat);

		if (id_notification == -1)
		{
			return -1;
		}

		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{

			String command = "INSERT INTO notificationChangementSeance VALUES(?, ?);";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setInt(1, id_notification);
				statement.setString(2, code_seance);

				if (statement.executeUpdate() == 1)
					return id_notification;
				else
					return -1;
			}
		} catch (Exception e)
		{
			System.out.println("Connection error in " + Thread.currentThread().getStackTrace()[1].getMethodName()
					+ " >>> " + e.getMessage());
			return -1;
		}
	}

	public static ArrayList<NotificationChangementSeance> GetNotificationsOfUser(int id_utilisateur)
	{
		ArrayList<NotificationChangementSeance> result = new ArrayList<NotificationChangementSeance>();

		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "SELECT * FROM notificationChangementSeance WHERE id_notification IN (SELECT id_notification FROM notification WHERE id_utilisateur = ?);";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setInt(1, id_utilisateur);

				try (ResultSet resultSet = statement.executeQuery())
				{
					while (resultSet.next())
					{
						int id_notification = resultSet.getInt(1);
						String code_seance = resultSet.getString(2);
						result.add(new NotificationChangementSeance(DAO_Notification.GetNotification(id_notification),
								DAO_ChangementSeance.GetChangementSeance(code_seance)));
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
