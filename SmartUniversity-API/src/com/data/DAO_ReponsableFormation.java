package com.data;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;

import com.modele.Enseignant;
import com.modele.ResponsableFormation;
import com.modele.Utilisateur;

public class DAO_ReponsableFormation extends DAO_Initialize
{
	public static ResponsableFormation GetReponsableFormation(Utilisateur utilisateur)
	{
		ResponsableFormation result = null;
		Enseignant enseignant = DAO_Enseignant.GetEnseignant(utilisateur);

		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "SELECT * FROM responsableFormation WHERE id_responsable_formation = ?;";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setInt(1, utilisateur.getId_utilisateur());

				try (ResultSet resultSet = statement.executeQuery())
				{
					if (resultSet.next())
					{
						Date date_nomination = resultSet.getDate(2);
						result = new ResponsableFormation(utilisateur, enseignant, date_nomination);
						return result;
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

	public static int CreateresponsableFormation(int id)
	{
		if (id == -1)
		{
			return -1;
		}
		
		if (id != -1)
		{
			try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
			{
				String command = "INSERT INTO ResponsableFormation VALUES(?, ?);";
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
	
	public static ArrayList<ResponsableFormation> GetAllReponsableFormation()
	{
		ArrayList<ResponsableFormation> result = new ArrayList<ResponsableFormation>();
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "SELECT * FROM responsableFormation;";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				try (ResultSet resultSet = statement.executeQuery())
				{
					while (resultSet.next())
					{
						int id_responsable_formation = resultSet.getInt(1);
						Date date_nomination = resultSet.getDate(2);
						ResponsableFormation responsableFormation = new ResponsableFormation(
								DAO_User.GetUserByID(id_responsable_formation),
								DAO_Enseignant.GetEnseignantById(id_responsable_formation), date_nomination);
						result.add(responsableFormation);
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
