package com.data;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.modele.Enseignant;
import com.modele.Utilisateur;
import com.modele.Utilisateur.Code_Departement;

public class DAO_Enseignant extends DAO_Initialize
{
	public static Enseignant GetEnseignant(Utilisateur user)
	{		
		Enseignant resultEnseignant = null;
		try (Connection connection = DriverManager.getConnection(dbURL, dbLogin, dbPassword))
		{
			String command = "SELECT * FROM enseignant WHERE id_enseignant = ?;";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setInt(1, user.getId_utilisateur());

				try (ResultSet resultSet = statement.executeQuery())
				{
					if (resultSet.next())
					{
						String grade = resultSet.getString(2);
						Code_Departement code_departement = Code_Departement.valueOf(resultSet.getString(3));
						resultEnseignant = new Enseignant(user, grade, code_departement);
						return resultEnseignant;				
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
