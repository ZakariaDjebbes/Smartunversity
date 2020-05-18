package com.data;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.dots.Dot_Create_ChangementSeance;
import com.modele.ChangementSeance;
import com.modele.Seance.Etat_Demande;
import com.modele.Seance.Jour;

public class DAO_ChangementSeance extends DAO_Initialize
{
	public static ChangementSeance GetChangementSeance(String code_seance)
	{		
		ChangementSeance changementSeance = null;
		try (Connection connection = DriverManager.getConnection(dbURL, dbLogin, dbPassword))
		{
			String command = "SELECT * FROM ChangementSeance WHERE code_seance = ?;";
			
			try(PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setString(1, code_seance);
				
				try(ResultSet resultSet = statement.executeQuery())
				{
					if(resultSet.next())
					{
						Jour nouveau_jour = Jour.valueOf(resultSet.getString(2));
						String nouvelle_heure = resultSet.getString(3);
						Etat_Demande etat_demande = Etat_Demande.valueOf(resultSet.getString(4));
						
						changementSeance = new ChangementSeance(code_seance, nouveau_jour, nouvelle_heure, etat_demande);
					}
					
					return changementSeance;
				}
			}
			
		}
		catch (Exception e)
		{
			System.out.println("Connection error in "+ Thread.currentThread().getStackTrace()[1].getMethodName() +" >>> " + e.getMessage());
			return null;
		}
	}
	
	public static boolean CreateChangementSeance(Dot_Create_ChangementSeance dot_Create_ChangementSeance)
	{
		try (Connection connection = DriverManager.getConnection(dbURL, dbLogin, dbPassword))
		{
			String command = "INSERT INTO changementSeance(code_seance, nouveau_jour, nouvelle_heure) VALUES(?, ?, ?);";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setString(1, dot_Create_ChangementSeance.getCode_seance());
				statement.setString(2, String.valueOf(dot_Create_ChangementSeance.getNouveau_jour()));
				statement.setString(3, dot_Create_ChangementSeance.getNouvelle_heure());

				return statement.executeUpdate() == 1 ? true : false;
			}
		} 
		catch (Exception e)
		{
			System.out.println("Connection error in " + Thread.currentThread().getStackTrace()[1].getMethodName()
					+ " >>> " + e.getMessage());
			return false;
		}
	}

	public static boolean DeleteChangementSeance(String code_seance)
	{
		try (Connection connection = DriverManager.getConnection(dbURL, dbLogin, dbPassword))
		{
			String command = "DELETE FROM changementSeance WHERE code_seance = ? LIMIT 1;";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setString(1, code_seance);
		
				int deletedRows = statement.executeUpdate();

				return deletedRows == 1? true : false;
			}
		} 
		catch (Exception e)
		{
			System.out.println("Connection error in " + Thread.currentThread().getStackTrace()[1].getMethodName()
					+ " >>> " + e.getMessage());
			return false;
		}
	}
}
