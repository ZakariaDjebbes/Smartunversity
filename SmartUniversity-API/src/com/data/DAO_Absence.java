package com.data;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.dots.Dot_Create_Absence;
import com.modele.Absence;

public class DAO_Absence extends DAO_Initialize
{
	public static boolean CreateAbsence(Dot_Create_Absence absence)
	{
		try (Connection connection = DriverManager.getConnection(dbURL, dbLogin, dbPassword))
		{
			String command = "INSERT INTO Absence VALUES(?, ?, NULL, ?);";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setString(1, absence.getCode_seance());
				statement.setInt(2, absence.getId_etudiant());
				statement.setDate(3, new Date(absence.getDate_absence().getTime()));

				return statement.executeUpdate() == 1 ? true : false;
			}
		} catch (Exception e)
		{
			System.out.println("Connection error in " + Thread.currentThread().getStackTrace()[1].getMethodName()
					+ " >>> " + e.getMessage());
			return false;
		}
	}

	public static ArrayList<Absence> GetAbsencesOfStudentBySeance(String code_seance, int id_etudiant)
	{
		ArrayList<Absence> absences = new ArrayList<Absence>();

		try (Connection connection = DriverManager.getConnection(dbURL, dbLogin, dbPassword))
		{
			String command = "SELECT * FROM Absence WHERE code_seance = ? AND id_etudiant = ?;";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setString(1, code_seance);
				statement.setInt(2, id_etudiant);

				try (ResultSet resultSet = statement.executeQuery())
				{
					while (resultSet.next())
					{
						int numero_absence = resultSet.getInt(3);
						Date date_absence = resultSet.getDate(4);

						Absence absence = new Absence(numero_absence, code_seance, id_etudiant, date_absence);
						absences.add(absence);
					}

					return absences;
				}
			}
		} catch (Exception e)
		{
			System.out.println("Connection error in " + Thread.currentThread().getStackTrace()[1].getMethodName()
					+ " >>> " + e.getMessage());
			return null;
		}
	}

	public static ArrayList<Absence> GetAbsencesOfSeance(String code_seance)
	{
		ArrayList<Absence> absences = new ArrayList<Absence>();

		try (Connection connection = DriverManager.getConnection(dbURL, dbLogin, dbPassword))
		{
			String command = "SELECT * FROM Absence WHERE code_seance = ?;";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setString(1, code_seance);
		
				try (ResultSet resultSet = statement.executeQuery())
				{
					while (resultSet.next())
					{
						int id_etudiant = resultSet.getInt(2);
						int numero_absence = resultSet.getInt(3);
						Date date_absence = resultSet.getDate(4);

						Absence absence = new Absence(numero_absence, code_seance, id_etudiant, date_absence);
						absences.add(absence);
					}

					return absences;
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
