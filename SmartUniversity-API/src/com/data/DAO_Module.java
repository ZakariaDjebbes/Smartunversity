package com.data;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.modele.Module;

public class DAO_Module extends DAO_Initialize
{
	public static Module GetMouleByCode(String code_module)
	{
		try (Connection connection = DriverManager.getConnection(dbURL, dbLogin, dbPassword))
		{
			String command = "SELECT * FROM Module WHERE code_module = ?;";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setString(1, code_module);

				try (ResultSet resultSet = statement.executeQuery())
				{
					if (resultSet.next())
					{
						String nom = resultSet.getString(2);
						
						return new Module(code_module, nom);
					} 
					else
					{
						return null;
					}

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
