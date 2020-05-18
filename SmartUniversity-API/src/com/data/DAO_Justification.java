package com.data;

import java.io.InputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.dots.Dot_Create_Justification;
import com.modele.Justification;
import com.modele.Seance.Etat_Demande;

public class DAO_Justification extends DAO_Initialize
{
	public static boolean CreateJustification(Dot_Create_Justification detailJustification, InputStream fichier)
	{
		try (Connection connection = DriverManager.getConnection(dbURL, dbLogin, dbPassword))
		{
			String command = "INSERT INTO Justification VALUES(NULL, ?, ?, ?, ?);";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setInt(1, detailJustification.getNumero_absence());
				statement.setBlob(2, fichier);
				statement.setDate(3, new Date(detailJustification.getDate_justification().getTime()));
				statement.setString(4, String.valueOf(Etat_Demande.nonTraite));
				
				return statement.executeUpdate() == 1 ? true : false;
			}
		} catch (Exception e)
		{
			System.out.println("Connection error in " + Thread.currentThread().getStackTrace()[1].getMethodName()
					+ " >>> " + e.getMessage());
			return false;
		} 
	}
	
	public static Justification GetJustificationByAbsence(int numero_absence)
	{
		try (Connection connection = DriverManager.getConnection(dbURL, dbLogin, dbPassword))
		{
			String command = "SELECT * FROM Justification WHERE numero_absence = ?;";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setInt(1, numero_absence);

				try (ResultSet resultSet = statement.executeQuery())
				{
					if (resultSet.next())
					{
						int numero_justification = resultSet.getInt(1);
						Blob blob = resultSet.getBlob(3);
						byte[] fichier =  blob.getBytes(1, (int) blob.length());
						Date date_justification = (Date) resultSet.getDate(4);
						Etat_Demande etat_demande = Etat_Demande.valueOf(resultSet.getString(5));
						Justification justification = new Justification(numero_justification, numero_absence, 
								fichier, date_justification, etat_demande);
						
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
}
