package com.data;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import com.dots.Dot_Create_Absence;

public class DAO_Absence extends DAO_Initialize
{
	public static boolean AddAbsence(Dot_Create_Absence absence)
	{
		try (Connection connection = DriverManager.getConnection(dbURL, dbLogin, dbPassword))
		{
			String command = "INSERT INTO Absence VALUES(?, ?, NULL, ?);";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setString(1, absence.getCode_seance());
				statement.setInt(2, absence.getId_etudiant());
				statement.setDate(3, new Date(absence.getDate_absence().getTime()));
				
				return statement.executeUpdate() == 1? true : false;
			}
		} catch (Exception e)
		{
			System.out.println("Connection error in " + Thread.currentThread().getStackTrace()[1].getMethodName()
					+ " >>> " + e.getMessage());
			return false;
		}
	}
}
