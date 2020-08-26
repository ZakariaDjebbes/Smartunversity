package com.data;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;

import com.modele.Notification;
import com.modele.Seance.Etat_Demande;
import com.mysql.jdbc.Statement;

public class DAO_Notification extends DAO_Initialize
{
	public static Notification GetNotification(int id_notification)
	{
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "SELECT * FROM notification WHERE id_notification = ?;";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setInt(1, id_notification);

				try (ResultSet resultSet = statement.executeQuery())
				{
					if (resultSet.next())
					{
						int id_utilisateur = resultSet.getInt(2);
						boolean is_vue = resultSet.getBoolean(3);
						Timestamp ts = resultSet.getTimestamp(4);
						Date date_creation = new Date(ts.getTime());
						Etat_Demande et_demande_notifier = Etat_Demande.valueOf(resultSet.getString(5));
						Notification notification = new Notification(id_notification, id_utilisateur, is_vue,
								date_creation, et_demande_notifier);
						return notification;
					}

					return null;
				}
			}
		} catch (Exception e)
		{
			System.out.println("Connection error in " + Thread.currentThread().getStackTrace()[1].getMethodName()
					+ " >>> " + e.getMessage());
			return null;
		}
	}

	public static ArrayList<Notification> GetNotificationsOfUser(int id_utilisateur)
	{
		ArrayList<Notification> notifications = new ArrayList<Notification>();
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "SELECT * FROM notification WHERE id_utilisateur = ?;";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setInt(1, id_utilisateur);

				try (ResultSet resultSet = statement.executeQuery())
				{
					while (resultSet.next())
					{
						int id_notification = resultSet.getInt(1);
						boolean is_vue = resultSet.getBoolean(3);
						Timestamp ts = resultSet.getTimestamp(4);
						Date date_creation = new Date(ts.getTime());
						Etat_Demande et_demande_notifier = Etat_Demande.valueOf(resultSet.getString(5));

						Notification notification = new Notification(id_notification, id_utilisateur, is_vue,
								date_creation, et_demande_notifier);
						notifications.add(notification);
					}

					return notifications;
				}
			}
		} catch (Exception e)
		{
			System.out.println("Connection error in " + Thread.currentThread().getStackTrace()[1].getMethodName()
					+ " >>> " + e.getMessage());
			return null;
		}
	}

	public static int CreateNotification(int id_utilisateur, Etat_Demande etat)
	{
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "INSERT INTO notification VALUES(NULL, ?, ?, ?, ?);";
			try (PreparedStatement statement = connection.prepareStatement(command, Statement.RETURN_GENERATED_KEYS))
			{
				statement.setInt(1, id_utilisateur);
				statement.setBoolean(2, false);
				statement.setTimestamp(3, new Timestamp(new Date().getTime()));
				statement.setString(4, String.valueOf(etat));
				
				if (statement.executeUpdate() == 1)
				{
					try (ResultSet resultSet = statement.getGeneratedKeys())
					{
						if (resultSet.next())
						{
							return resultSet.getInt(1);
						}

						return -1;
					}
				}

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

	public static boolean DeleteNotification(int id_notification)
	{
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "DELETE FROM notification WHERE id_notification = ? LIMIT 1;";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setInt(1, id_notification);

				return statement.executeUpdate() == 1;
			}
		} catch (Exception e)
		{
			System.out.println("Connection error in " + Thread.currentThread().getStackTrace()[1].getMethodName()
					+ " >>> " + e.getMessage());
			return false;
		}
	}

	public static boolean SetVue(int id_notification, boolean is_vue)
	{
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "UPDATE notification SET is_vue = ? WHERE id_notification = ? LIMIT 1;";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setBoolean(1, is_vue);
				statement.setInt(2, id_notification);

				return statement.executeUpdate() == 1;
			}
		} catch (Exception e)
		{
			System.out.println("Connection error in " + Thread.currentThread().getStackTrace()[1].getMethodName()
					+ " >>> " + e.getMessage());
			return false;
		}
	}
}
