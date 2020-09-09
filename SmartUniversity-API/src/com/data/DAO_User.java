package com.data;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Date;

import javax.ws.rs.core.Response.Status;

import com.dots.Dot_Create_Utilisateur;
import com.dots.Dot_Login_User;
import com.jsonReaders.MessageReader;
import com.modele.Utilisateur;
import com.modele.Utilisateur.Type_Utilisateur;
import com.rest.exceptions.RequestNotValidException;
import com.utility.Utility;

public class DAO_User extends DAO_Initialize
{
	public static boolean UsernameExists(String username)
	{
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "SELECT * FROM utilisateur WHERE user = ?;";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setString(1, username);

				try (ResultSet resultSet = statement.executeQuery())
				{
					if (resultSet.next())
					{
						return true;
					} else
					{
						return false;
					}

				}
			}
		} catch (Exception e)
		{
			System.out.println("Connection error in " + Thread.currentThread().getStackTrace()[1].getMethodName()
					+ " >>> " + e.getMessage());

			throw new RequestNotValidException(Status.GATEWAY_TIMEOUT, MessageReader.GetNode("server_side_error"));
		}
	}

	public static Utilisateur GetUser(Dot_Login_User userLoginDots)
	{
		Utilisateur resultUtilisateur = null;
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
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

			throw new RequestNotValidException(Status.GATEWAY_TIMEOUT, MessageReader.GetNode("server_side_error"));
		}
	}

	public static Utilisateur GetUserByID(int id)
	{
		Utilisateur resultUtilisateur = null;
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "SELECT * FROM utilisateur WHERE id_utilisateur = ?;";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setInt(1, id);
				;

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

						resultUtilisateur = new Utilisateur(id, user, pass, nom, prenom, adresse, date_n, email,
								telephone, type_utilisateur);
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
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
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

	public static boolean UpdateUserPasswordLess(Utilisateur utilisateur)
	{
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "UPDATE utilisateur SET user = ?, nom = ?, prenom = ?, adresse = ?, email = ?, telephone = ?, date_n = ?, type_utilisateur = ? WHERE id_utilisateur = ? LIMIT 1;";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setString(1, utilisateur.getUser());
				statement.setString(2, utilisateur.getNom());
				statement.setString(3, utilisateur.getPrenom());
				statement.setString(4, utilisateur.getAdresse());
				statement.setString(5, utilisateur.getEmail());
				statement.setString(6, utilisateur.getTelephone());
				statement.setDate(7, new java.sql.Date(utilisateur.getDate().getTime()));
				statement.setString(8, String.valueOf(utilisateur.getUser_type()));
				statement.setInt(9, utilisateur.getId_utilisateur());

				return statement.executeUpdate() == 1;
			}
		} catch (Exception e)
		{
			System.out.println("Connection error in " + Thread.currentThread().getStackTrace()[1].getMethodName()
					+ " >>> " + e.getMessage());
			return false;
		}
	}

	public static int CreateUser(Dot_Create_Utilisateur dot_Create_Utilisateur)
	{
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "INSERT INTO utilisateur VALUES(NULL, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				String username = "";
				String password = "";

				do// prevent duplicates even if the odds are very very very small
				{
					username = Utility.GetUserName(dot_Create_Utilisateur);
				} while (UsernameExists(username));

				password = Utility.GetRandomPassword();

				statement.setString(1, username);
				statement.setString(2, password);
				statement.setString(3, dot_Create_Utilisateur.getNom());
				statement.setString(4, dot_Create_Utilisateur.getPrenom());
				statement.setString(5, dot_Create_Utilisateur.getAdresse());
				statement.setDate(6, new java.sql.Date(dot_Create_Utilisateur.getDate().getTime()));
				statement.setString(7, dot_Create_Utilisateur.getEmail());
				statement.setString(8, dot_Create_Utilisateur.getTelephone());
				statement.setString(9, String.valueOf(dot_Create_Utilisateur.getUser_type()));

				int addedRows = statement.executeUpdate();
				if (addedRows == 1)
				{
					int id_utilisateur = DAO_User.GetUser(new Dot_Login_User(username, password, false))
							.getId_utilisateur();
					return id_utilisateur;
				}

				return -1;
			}
		} catch (Exception e)
		{
			System.out.println("Connection error in " + Thread.currentThread().getStackTrace()[1].getMethodName()
					+ " >>> " + e.getMessage());

			return -1;
		}
	}

	public static boolean DeleteUserByID(int id)
	{
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "DELETE FROM utilisateur WHERE id_utilisateur = ? LIMIT 1;";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setInt(1, id);

				int deletedRows = statement.executeUpdate();

				return deletedRows == 1 ? true : false;
			}
		} catch (Exception e)
		{
			System.out.println("Connection error in " + Thread.currentThread().getStackTrace()[1].getMethodName()
					+ " >>> " + e.getMessage());

			return false;
		}
	}

	public static int CheckUserByEmail(String email)
	{
		int id = 0;
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{

			String command = "SELECT id_utilisateur FROM utilisateur WHERE email = ?;";

			try (PreparedStatement statement = connection.prepareStatement(command))
			{

				statement.setString(1, email);

				try (ResultSet resultSet = statement.executeQuery())
				{
					if (resultSet.next())
					{
						id = resultSet.getInt(1);
						return id;

					} else
					{
						return 0;
					}
				}
			}
		} catch (Exception e)
		{
			System.out.println("Connection error in " + Thread.currentThread().getStackTrace()[1].getMethodName()
					+ " >>> " + e.getMessage());
			return 0;
		}
	}

	public static boolean UpdatePassword(int id, String password)
	{
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "UPDATE utilisateur SET pass = ? WHERE id_utilisateur = ? LIMIT 1;";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setString(1, password);
				statement.setInt(2, id);
				int updatedRows = statement.executeUpdate();

				if (updatedRows == 0)
				{
					return false;
				} else
				{
					return true;
				}
			}
		} catch (Exception e)
		{
			System.out.println("Connection error in " + Thread.currentThread().getStackTrace()[1].getMethodName()
					+ " >>> " + e.getMessage());
			return false;
		}
	}
}
