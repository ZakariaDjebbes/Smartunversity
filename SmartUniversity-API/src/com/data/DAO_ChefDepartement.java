package com.data;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Date;

import com.modele.ChefDepartement;
import com.modele.Enseignant;
import com.modele.Utilisateur;

public class DAO_ChefDepartement extends DAO_Initialize
{

	public static Utilisateur GetChefDepartement(Utilisateur utilisateur)
	{
		ChefDepartement resultChefDepartement = null;
		Enseignant enseignant = DAO_Enseignant.GetEnseignant(utilisateur);
		
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "SELECT * FROM ChefDepartement WHERE id_chef_departement = ?;";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setInt(1, utilisateur.getId_utilisateur());

				try (ResultSet resultSet = statement.executeQuery())
				{
					if (resultSet.next())
					{
						Date date_nomination = resultSet.getDate(2);
						resultChefDepartement = new ChefDepartement(utilisateur, enseignant, date_nomination);
						return resultChefDepartement;				
					} 
					else
					{
						return null;
					}

				}
			}
		}
		catch (Exception e)
		{
			System.out.println("Connection error in "+ Thread.currentThread().getStackTrace()[1].getMethodName() +" >>> " + e.getMessage());
			return null;
		}
	}
}
