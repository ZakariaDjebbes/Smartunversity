package com.data;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.dots.Dots_Create_User;
import com.dots.Dots_Login_User;
import com.modele.User;
import com.modele.User.User_Type;

public class DAO_User extends DAO_Initialize
{
	public static User GetUser(Dots_Login_User userLoginDots)
	{
		User resultUtilisateur = null;
		try (Connection connection = DriverManager.getConnection(dbURL, dbLogin, dbPassword))
		{
			String command = "SELECT * FROM User WHERE username = ? AND password = BINARY ?;";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setString(1, userLoginDots.getUsername());
				statement.setString(2, userLoginDots.getPassword());

				try (ResultSet resultSet = statement.executeQuery())
				{
					if (resultSet.next())
					{
						int id = resultSet.getInt(1);
						String username = resultSet.getString(2);
						String user_password = resultSet.getString(3);
						String first_name = resultSet.getString(4);
						String last_name = resultSet.getString(5);
						User_Type user_type = User_Type.valueOf(resultSet.getString(6));

						resultUtilisateur = new User(id, username, user_password, first_name, last_name, user_type);
					} else
					{
						return null;
					}

					return resultUtilisateur;
				}
			}
		} catch (Exception e)
		{
			System.out.println("Connection error in "+ Thread.currentThread().getStackTrace()[1].getMethodName() +">>> " + e.getMessage());
			return null;
		}
	}

	public static boolean CreateUser(Dots_Create_User userCreateDots)
	{
		try (Connection connection = DriverManager.getConnection(dbURL, dbLogin, dbPassword))
		{
			String command = "INSERT INTO USER VALUES (NULL, ?, ?, ?, ?, ?)";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setString(1, userCreateDots.getUsername());
				statement.setString(2, userCreateDots.getPassword());
				statement.setString(3, userCreateDots.getFirst_name());
				statement.setString(4, userCreateDots.getLast_name());
				statement.setString(5, userCreateDots.getUser_type().toString());

				int modifs = statement.executeUpdate();

				return modifs == 0 ? false : true;
			}
		} catch (Exception e)
		{
			System.out.println("Connection error in "+ Thread.currentThread().getStackTrace()[1].getMethodName() +">>> " + e.getMessage());
			return false;
		}
	}
	
	public static boolean UserExists(String username)
	{
		try (Connection connection = DriverManager.getConnection(dbURL, dbLogin, dbPassword))
		{
			String command = "SELECT * FROM User WHERE username = ?;";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setString(1, username);

				try (ResultSet resultSet = statement.executeQuery())
				{
					if (resultSet.next())
					{
						return true;
					} else
					{
						return false;
					}
				}
			}
		} catch (Exception e)
		{
			System.out.println("Connection error in "+ Thread.currentThread().getStackTrace()[1].getMethodName() +">>> " + e.getMessage());
			return false;
		}
	}
}
