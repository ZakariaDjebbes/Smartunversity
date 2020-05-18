package com.data;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.dots.Dot_Create_SeanceSupp;
import com.helpers.Utility;
import com.modele.Seance.Etat_Demande;
import com.modele.Seance.Jour;
import com.modele.SeanceSupp;

public class DAO_SeanceSupp extends DAO_Initialize
{
	public static boolean CreateSeanceSupp(Dot_Create_SeanceSupp seanceSupp)
	{
		try (Connection connection = DriverManager.getConnection(dbURL, dbLogin, dbPassword))
		{
			String command = "INSERT INTO SeanceSupp VALUES(?, NULL, ?, ?, ?);";

			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				String code_seance = null;
				do
				{
					code_seance = Utility.generateRandomString(10);
				} while (DAO_Seance.GetSeanceByCode_Seance(code_seance) != null);

				// 1
				statement.setString(1, seanceSupp.getCode_seance());
				statement.setString(2, String.valueOf(seanceSupp.getJour()));
				statement.setString(3, String.valueOf(seanceSupp.getHeure()));
				statement.setString(4, Etat_Demande.nonTraite.toString());

				return statement.executeUpdate() == 1;
			}
		} catch (Exception e)
		{
			System.out.println("Connection error in " + Thread.currentThread().getStackTrace()[1].getMethodName()
					+ " >>> " + e.getMessage());
			return false;
		}
	}

	public static ArrayList<SeanceSupp> GetSeancesSupp(String code_seance)
	{
		ArrayList<SeanceSupp> result = new ArrayList<SeanceSupp>();
		try (Connection connection = DriverManager.getConnection(dbURL, dbLogin, dbPassword))
		{	
			String command = "SELECT * FROM SeanceSupp WHERE code_seance = ?;";

			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setString(1, code_seance);

				try (ResultSet resultSet = statement.executeQuery())
				{
					while(resultSet.next())
					{
						int code_seance_supp = resultSet.getInt(2);
						Jour jour = Jour.valueOf(resultSet.getString(3));
						String heure = resultSet.getString(4);
						Etat_Demande etat_seance = Etat_Demande.valueOf(resultSet.getString(5));
						
						SeanceSupp seanceSupp = new SeanceSupp(code_seance, code_seance_supp, jour, heure, etat_seance);
						
						result.add(seanceSupp);
					}

					return result;
				}
			}
		} catch (Exception e)
		{
			System.out.println("Connection error in " + Thread.currentThread().getStackTrace()[1].getMethodName()
					+ " >>> " + e.getMessage());
			return null;
		}
	}
	
	public static boolean DeleteSeanceSupp(String code_seance, int code_seance_supp)
	{
		try (Connection connection = DriverManager.getConnection(dbURL, dbLogin, dbPassword))
		{
			String command = "DELETE FROM SeanceSupp WHERE code_seance = ? AND code_seance_supp = ? LIMIT 1;";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setString(1, code_seance);
				statement.setInt(2, code_seance_supp);
				
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
