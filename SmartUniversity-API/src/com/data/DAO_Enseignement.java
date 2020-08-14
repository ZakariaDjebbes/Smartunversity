package com.data;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import com.dots.Dot_Affecter_Seance;

public class DAO_Enseignement extends DAO_Initialize
{
	public static boolean DesaffecterSeance(String code_seance)
	{
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "DELETE FROM enseignement WHERE code_seance = ? LIMIT 1;";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setString(1, code_seance);
				
				boolean isDone =  statement.executeUpdate() == 1;
				
				if(isDone)
				{
					DAO_SeanceSupp.DeleteSeancesSupp(code_seance);
					DAO_ChangementSeance.DeleteChangementSeance(code_seance);
				}
				
				return isDone;
			}
		}
		catch(Exception e)
		{
			System.out.println("Connection error in " + Thread.currentThread().getStackTrace()[1].getMethodName()
					+ " >>> " + e.getMessage());
			return false;
		}
	}
	
	public static boolean AffecterSeance(Dot_Affecter_Seance dot_Affecter_Seance)
	{
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "INSERT INTO enseignement VALUES (?, ?)";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setInt(1, dot_Affecter_Seance.getId_enseignant());
				statement.setString(2, dot_Affecter_Seance.getCode_seance());
				boolean isDone =  statement.executeUpdate() == 1;
				
				return isDone;
			}
		}
		catch(Exception e)
		{
			System.out.println("Connection error in " + Thread.currentThread().getStackTrace()[1].getMethodName()
					+ " >>> " + e.getMessage());
			return false;
		}
	}
}
