package com.data;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;

import javax.ws.rs.core.Response.Status;

import com.modele.ChefDepartement;
import com.modele.Enseignant;
import com.modele.Utilisateur;
import com.modele.Utilisateur.Code_Departement;
import com.rest.exceptions.RequestNotValidException;
import com.utility.JsonReader;

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
	
	public static ChefDepartement GetChefDepartementOfDepartement(Code_Departement code_departement)
	{
		ChefDepartement result = null;
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "SELECT * FROM ChefDepartement, enseignant WHERE id_enseignant = id_chef_departement AND code_departement = ?;";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setString(1, String.valueOf(code_departement));

				try (ResultSet resultSet = statement.executeQuery())
				{
					if(resultSet.next())
					{	
						int id_chef_departement = resultSet.getInt(1);
						Date date = resultSet.getDate(2);
						
						Utilisateur utilisateur = DAO_User.GetUserByID(id_chef_departement);
						Enseignant enseignant = DAO_Enseignant.GetEnseignant(utilisateur);
						result = new ChefDepartement(utilisateur, enseignant, date);
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

	public static int CreateChefDepartement(int id)
	{
		if (id == -1)
		{
			return -1;
		}
		
		Enseignant enseignant = DAO_Enseignant.GetEnseignantById(id);
		
		if(GetChefDepartementOfDepartement(enseignant.getCode_departement()) != null)
		{
			throw new RequestNotValidException(Status.BAD_REQUEST, JsonReader.GetNode("departement_has_chef"));
		}
		
		if (id != -1)
		{
			try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
			{
				String command = "INSERT INTO ChefDepartement VALUES(?, ?);";
				try (PreparedStatement statement = connection.prepareStatement(command))
				{
					statement.setInt(1, id);
					statement.setDate(2, new java.sql.Date(new Date().getTime()));

					int addedRows = statement.executeUpdate();

					if (addedRows == 1)
					{
						return id;
					}

					return -1;
				}
			} catch (Exception e)
			{
				System.out.println("Connection error in " + Thread.currentThread().getStackTrace()[1].getMethodName()
						+ " >>> " + e.getMessage());

				return -1;
			}
		} else
		{
			return -1;
		}
	}

	public static ArrayList<ChefDepartement> GetAllChefDepartements()
	{
		ArrayList<ChefDepartement> result = new ArrayList<ChefDepartement>();
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "SELECT * FROM chefDepartement;";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				try (ResultSet resultSet = statement.executeQuery())
				{
					while (resultSet.next())
					{
						int id_chefDepartement = resultSet.getInt(1);
						Date date_nomination = resultSet.getDate(2);
						ChefDepartement chefDepartement = new ChefDepartement(DAO_User.GetUserByID(id_chefDepartement),
								DAO_Enseignant.GetEnseignantById(id_chefDepartement), date_nomination);
						result.add(chefDepartement);
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
}
