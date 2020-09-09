package com.data;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Calendar;

import com.dots.Dot_Create_Justification;
import com.dots.Dot_Justification_Android;
import com.modele.Justification;
import com.modele.Seance.Etat_Demande;

public class DAO_Justification extends DAO_Initialize
{
	public static boolean CreateJustification(Dot_Create_Justification detailJustification, InputStream fichier)
	{
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "INSERT INTO Justification VALUES(NULL, ?, ?, ?, ?, ?);";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setInt(1, detailJustification.getNumero_absence());
				statement.setBlob(2, fichier);
				statement.setString(3, detailJustification.getExtension());
				statement.setDate(4, new Date(detailJustification.getDate_justification().getTime()));
				statement.setString(5, String.valueOf(Etat_Demande.nonTraite));

				return statement.executeUpdate() == 1 ? true : false;
			}
		} catch (Exception e)
		{
			System.out.println("Connection error in " + Thread.currentThread().getStackTrace()[1].getMethodName()
					+ " >>> " + e.getMessage());
			return false;
		}
	}

	public static boolean CreateJustification(Dot_Justification_Android justification)
	{
		java.sql.Date date = new java.sql.Date(Calendar.getInstance().getTime().getTime());
		InputStream imageStream = new ByteArrayInputStream(justification.getImage());

		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "INSERT INTO Justification VALUES(NULL, ?, ?, ?, ?, ?);";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setInt(1, justification.getNumero_absence());
				statement.setBlob(2, imageStream);
				statement.setString(3, justification.getExtension());
				statement.setDate(4, date);
				statement.setString(5, String.valueOf(Etat_Demande.nonTraite));

				return statement.executeUpdate() == 1 ? true : false;
			}
		} catch (Exception e)
		{
			System.out.println("Connection error in " + Thread.currentThread().getStackTrace()[1].getMethodName()
					+ " >>> " + e.getMessage());
			return false;
		}
	}

	public static ArrayList<Justification> GetJustificationsByAbsence(int numero_absence)
	{
		ArrayList<Justification> justifications = new ArrayList<Justification>();

		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "SELECT * FROM Justification WHERE numero_absence = ?;";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setInt(1, numero_absence);

				try (ResultSet resultSet = statement.executeQuery())
				{
					while (resultSet.next())
					{
						int numero_justification = resultSet.getInt(1);
						Blob blob = resultSet.getBlob(3);
						byte[] fichier = blob.getBytes(1, (int) blob.length());
						String extension = resultSet.getString(4);
						Date date_justification = (Date) resultSet.getDate(5);
						Etat_Demande etat_demande = Etat_Demande.valueOf(resultSet.getString(6));
						Justification justification = new Justification(numero_justification, numero_absence, fichier,
								extension, date_justification, etat_demande);

						justifications.add(justification);

					}

					return justifications;
				}
			}
		} catch (Exception e)
		{
			System.out.println("Connection error in " + Thread.currentThread().getStackTrace()[1].getMethodName()
					+ " >>> " + e.getMessage());
			return null;
		}
	}

	public static Justification GetJustificationByAbsence(int numero_absence, int numero_justification)
	{
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "SELECT * FROM justification WHERE numero_absence = ? AND numero_justification = ?";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setInt(1, numero_absence);
				statement.setInt(2, numero_justification);

				try (ResultSet resultSet = statement.executeQuery())
				{
					if (resultSet.next())
					{
						Blob blob = resultSet.getBlob(3);
						byte[] fichier = blob.getBytes(1, (int) blob.length());
						String extension = resultSet.getString(4);
						Date date_justification = (Date) resultSet.getDate(5);
						Etat_Demande etat_demande = Etat_Demande.valueOf(resultSet.getString(6));
						Justification justification = new Justification(numero_justification, numero_absence, fichier,
								extension, date_justification, etat_demande);

						return justification;
					} else
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

	public static boolean DeleteJustificationByNumero(int numero_absence, int numero_justification)
	{
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "DELETE FROM Justification WHERE numero_absence = ? and numero_justification = ? LIMIT 1;";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setInt(1, numero_absence);
				statement.setInt(2, numero_justification);

				return statement.executeUpdate() == 1;
			}
		} catch (Exception e)
		{
			System.out.println("Connection error in " + Thread.currentThread().getStackTrace()[1].getMethodName()
					+ " >>> " + e.getMessage());
			return false;
		}
	}

	public static boolean SetJustificationState(Etat_Demande etat_justification, int numero_absence,
			int numero_justification)
	{
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "UPDATE justification SET etat = ? WHERE numero_absence = ? AND numero_justification = ? LIMIT 1;";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setString(1, String.valueOf(etat_justification));
				statement.setInt(2, numero_absence);
				statement.setInt(3, numero_justification);

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
