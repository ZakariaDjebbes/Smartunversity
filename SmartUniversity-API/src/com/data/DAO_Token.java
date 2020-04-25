package com.data;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DAO_Token extends DAO_Initialize
{
	public static boolean CreateOrUpdateToken(int id, String token)
	{
		try (Connection connection = DriverManager.getConnection(dbURL, dbLogin, dbPassword))
		{
			String command = "SELECT * FROM Token Where id_utilisateur = ?;";
			try(PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setInt(1, id);
				try(ResultSet resultSet = statement.executeQuery())
				{
					if(resultSet.next())
					{
						String updateCommand = "UPDATE Token SET token = ? WHERE id_utilisateur = ? LIMIT 1;";
						
						try(PreparedStatement updateStatement = connection.prepareStatement(updateCommand))
						{
							updateStatement.setString(1, token);
							updateStatement.setInt(2, id);
							
							return updateStatement.executeUpdate() == 1 ? true : false;
						}
						
					} 
					else 
					{
						String createCommand = "INSERT INTO Token VALUES (?, ?);";
						
						try(PreparedStatement createStatement = connection.prepareStatement(createCommand))
						{
							createStatement.setInt(1, id);
							createStatement.setString(2, token);
							
							return createStatement.executeUpdate() == 1 ? true : false;
						}
					}
				}
			}
		} catch (Exception e)
		{
			System.out.println("Connection error in "+ Thread.currentThread().getStackTrace()[1].getMethodName() +" >>> " + e.getMessage());
			return false;
		}
	}
	
	public static boolean CheckToken(String token)
	{
		try (Connection connection = DriverManager.getConnection(dbURL, dbLogin, dbPassword))
		{
			String command = "SELECT * FROM Token Where token = ?;";
			try(PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setString(1, token);;
				try(ResultSet resultSet = statement.executeQuery())
				{
					if(resultSet.next())
					{
						return true;
					}
					
					return false;
				}
			}
		} catch (Exception e)
		{
			System.out.println("Connection error in "+ Thread.currentThread().getStackTrace()[1].getMethodName() +" >>> " + e.getMessage());
			return false;
		}		
	}
}
