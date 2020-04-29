package com.data;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Date;

import com.dots.Dots_Login_User;
import com.modele.Utilisateur;
import com.modele.Utilisateur.Type_Utilisateur;

public class DAO_User extends DAO_Initialize
{
	public static Utilisateur GetUser(Dots_Login_User userLoginDots)
	{
		Utilisateur resultUtilisateur = null;
		try (Connection connection = DriverManager.getConnection(dbURL, dbLogin, dbPassword))
		{
			String command = "SELECT * FROM utilisateur WHERE user = ? AND pass = BINARY ?;";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setString(1, userLoginDots.getUser());
				statement.setString(2, userLoginDots.getPass());

				try (ResultSet resultSet = statement.executeQuery())
				{
					if (resultSet.next())
					{
						int id = resultSet.getInt(1);
						String nom = resultSet.getString(4);
						String prenom = resultSet.getString(5);
						String adresse = resultSet.getString(6);
						Date date_n = (Date) resultSet.getDate(7);
						String email = resultSet.getString(8);
						String telephone = resultSet.getString(9);
						Type_Utilisateur type_utilisateur = Type_Utilisateur.valueOf(resultSet.getString(10));

						resultUtilisateur = new Utilisateur(id, userLoginDots.getUser(), userLoginDots.getPass(), nom,
								prenom, adresse, date_n, email, telephone, type_utilisateur);
						return resultUtilisateur;
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

	public static Utilisateur GetUserByID(int id)
	{
		Utilisateur resultUtilisateur = null;
		try (Connection connection = DriverManager.getConnection(dbURL, dbLogin, dbPassword))
		{
			String command = "SELECT * FROM utilisateur WHERE id_utilisateur = ?;";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setInt(1, id);;

				try (ResultSet resultSet = statement.executeQuery())
				{
					if (resultSet.next())
					{
						String user = resultSet.getString(2);
						String pass = resultSet.getString(3);
						String nom = resultSet.getString(4);
						String prenom = resultSet.getString(5);
						String adresse = resultSet.getString(6);
						Date date_n = (Date) resultSet.getDate(7);
						String email = resultSet.getString(8);
						String telephone = resultSet.getString(9);
						Type_Utilisateur type_utilisateur = Type_Utilisateur.valueOf(resultSet.getString(10));

						resultUtilisateur = new Utilisateur(id, user, pass, nom,
								prenom, adresse, date_n, email, telephone, type_utilisateur);
						return resultUtilisateur;
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
	
	public static int UpdateUser(Utilisateur utilisateur)
	{
		try (Connection connection = DriverManager.getConnection(dbURL, dbLogin, dbPassword))
		{
			String command = "UPDATE utilisateur SET user = ?, pass = ?, nom = ?, prenom = ?, adresse = ?, email = ?, telephone = ?, date_n = ?, type_utilisateur = ? WHERE id_utilisateur = ? LIMIT 1;";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setString(1, utilisateur.getUser());
				statement.setString(2, utilisateur.getPass());
				statement.setString(3, utilisateur.getNom());
				statement.setString(4, utilisateur.getPrenom());
				statement.setString(5, utilisateur.getAdresse());
				statement.setString(6, utilisateur.getEmail());
				statement.setString(7, utilisateur.getTelephone());
				statement.setDate(8, new java.sql.Date(utilisateur.getDate().getTime()));
				statement.setString(9, String.valueOf(utilisateur.getUser_type()));
				statement.setInt(10, utilisateur.getId_utilisateur());

				int updatedRows = statement.executeUpdate();

				return updatedRows;
			}
		} catch (Exception e)
		{
			System.out.println("Connection error in " + Thread.currentThread().getStackTrace()[1].getMethodName()
					+ " >>> " + e.getMessage());
			return 0;
		}
	}
	
	public static boolean DeleteUserByID(int id)
	{
		try (Connection connection = DriverManager.getConnection(dbURL, dbLogin, dbPassword))
		{
			String command = "DELETE FROM utilisateur WHERE id_utilisateur = ? LIMIT 1;";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setInt(1, id);
		
				int deletedRows = statement.executeUpdate();

				return deletedRows == 1? true : false;
			}
		} catch (Exception e)
		{
			System.out.println("Connection error in " + Thread.currentThread().getStackTrace()[1].getMethodName()
					+ " >>> " + e.getMessage());
			return false;
		}
	}
}
