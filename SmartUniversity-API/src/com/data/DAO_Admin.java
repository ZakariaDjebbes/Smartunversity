package com.data;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Date;

import com.modele.Admin;
import com.modele.Utilisateur;
import com.modele.Utilisateur.Type_Utilisateur;

public class DAO_Admin extends DAO_Initialize
{
	public static Admin GetAdminById(int id_admin)
	{
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "SELECT * FROM utilisateur, admin WHERE id_utilisateur = id_admin AND id_admin = ?;";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setInt(1, id_admin);
				try(ResultSet resultSet = statement.executeQuery())
				{
					if(resultSet.next())
					{
						//Utilisateur
						int id_utilisateur = resultSet.getInt(1);
						String user = resultSet.getString(2);
						String pass = resultSet.getString(3);
						String nom = resultSet.getString(4);
						String prenom = resultSet.getString(5);
						String adresse = resultSet.getString(6);
						Date date_n = (Date) resultSet.getDate(7);
						String email = resultSet.getString(8);
						String telephone = resultSet.getString(9);
						Type_Utilisateur type_utilisateur = Type_Utilisateur.valueOf(resultSet.getString(10));
						
						Utilisateur utilisateur = new Utilisateur(id_utilisateur, user, pass, nom, prenom, adresse, date_n, email, telephone, type_utilisateur);
						
						//Etudiant
						Date date_nomination = resultSet.getDate(12);
						
						Admin admin = new Admin(utilisateur, date_nomination);
						
						return admin;
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
