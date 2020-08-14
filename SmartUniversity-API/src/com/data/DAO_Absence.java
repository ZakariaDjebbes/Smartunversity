package com.data;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.dots.Dot_Create_Absence;
import com.modele.Absence;
import com.modele.Utilisateur.Code_Departement;

public class DAO_Absence extends DAO_Initialize
{
	public static boolean CreateAbsence(Dot_Create_Absence absence)
	{
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
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

		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
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

		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
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

	public static Absence GetAbsenceByNumero(int numero_absence)
	{
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "SELECT * FROM Absence WHERE numero_absence = ?;";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setInt(1, numero_absence);

				try (ResultSet resultSet = statement.executeQuery())
				{
					if (resultSet.next())
					{
						int id_etudiant = resultSet.getInt(2);
						String code_seance = resultSet.getString(1);
						Date date = resultSet.getDate(4);
						Absence absence = new Absence(numero_absence, code_seance, id_etudiant, date);
						return absence;
					}
					
					return null;
				}
			}
		}
		catch(Exception e)
		{
			System.out.println("Connection error in " + Thread.currentThread().getStackTrace()[1].getMethodName()
					+ " >>> " + e.getMessage());
			return null;
		}
	}
	
	public static ArrayList<Absence> GetAbsencesOfEtudiant(int id_etudiant)
	{
		ArrayList<Absence> absences = new ArrayList<Absence>();

		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "SELECT * FROM Absence WHERE id_etudiant = ?;";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setInt(1, id_etudiant);

				try (ResultSet resultSet = statement.executeQuery())
				{
					while (resultSet.next())
					{
						String code_seance = resultSet.getString(1);
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
	
	public static boolean DeleteAbsenceByNumero(int numero_absence)
	{
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "DELETE FROM Absence WHERE numero_absence = ? LIMIT 1;";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setInt(1, numero_absence);

				return statement.executeUpdate() == 1;
			}
		}
		catch(Exception e)
		{
			System.out.println("Connection error in " + Thread.currentThread().getStackTrace()[1].getMethodName()
					+ " >>> " + e.getMessage());
			return false;
		}
	}
	
	public static ArrayList<Absence> GetAbsencesByDepartement(Code_Departement code_departement)
	{
		ArrayList<Absence> absences = new ArrayList<Absence>();

		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "SELECT * FROM Absence NATURAL JOIN Etudiant WHERE code_departement = ?;";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setString(1, String.valueOf(code_departement));

				try (ResultSet resultSet = statement.executeQuery())
				{
					while (resultSet.next())
					{
						String code_seance = resultSet.getString(2);
						int id_etudiant = resultSet.getInt(1);
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
