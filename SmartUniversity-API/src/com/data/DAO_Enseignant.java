package com.data;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;

import com.helpers.EnseignantDisponibleResponse;
import com.modele.Enseignant;
import com.modele.Seance;
import com.modele.Seance.Jour;
import com.modele.Utilisateur;
import com.modele.Utilisateur.Code_Departement;
import com.modele.Utilisateur.Type_Utilisateur;
import com.utility.Utility;

public class DAO_Enseignant extends DAO_Initialize
{
	public static Enseignant GetEnseignant(Utilisateur utilisateur)
	{		
		Enseignant resultEnseignant = null;
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "SELECT * FROM enseignant WHERE id_enseignant = ?;";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setInt(1, utilisateur.getId_utilisateur());

				try (ResultSet resultSet = statement.executeQuery())
				{
					if (resultSet.next())
					{
						String grade = resultSet.getString(2);
						Code_Departement code_departement = Code_Departement.valueOf(resultSet.getString(3));
						resultEnseignant = new Enseignant(utilisateur, grade, code_departement);
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
	
	public static Enseignant GetEnseignantById(int id_enseignant)
	{		
		Enseignant resultEnseignant = null;
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "SELECT * FROM enseignant WHERE id_enseignant = ?;";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setInt(1, id_enseignant);

				try (ResultSet resultSet = statement.executeQuery())
				{
					if (resultSet.next())
					{
						String grade = resultSet.getString(2);
						Code_Departement code_departement = Code_Departement.valueOf(resultSet.getString(3));
						resultEnseignant = new Enseignant(DAO_User.GetUserByID(id_enseignant), grade, code_departement);
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
	
	public static Enseignant GetEnseignantBySeance(Seance seance)
	{
		Enseignant resultEnseignant = null;
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "SELECT * FROM Enseignant Where id_enseignant = (SELECT id_enseignant FROM enseignement WHERE code_seance = ?);";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setString(1, seance.getCode_seance());

				try (ResultSet resultSet = statement.executeQuery())
				{	
					if (resultSet.next())
					{
						int id_enseignant = resultSet.getInt(1);
						String grade = resultSet.getString(2);
						Code_Departement code_departement = Code_Departement.valueOf(resultSet.getString(3));
						resultEnseignant = new Enseignant(DAO_User.GetUserByID(id_enseignant), grade, code_departement);
						
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
	
	public static ArrayList<EnseignantDisponibleResponse> GetEnseignantsDisponiblesForSeance(Code_Departement code_departement, Jour jour, String heure)
	{
		ArrayList<EnseignantDisponibleResponse> result = new ArrayList<EnseignantDisponibleResponse>();
		ArrayList<Code_Departement> codes = Utility.GetAvailabeDepartementsOfDepartement(code_departement);
		
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String departemensCommand = " AND (code_departement = ?";
			
			for (int i = 1; i < codes.size(); i++)
			{
				departemensCommand += " OR code_departement =?";
			}
			
			departemensCommand += ");";
			
			String commandEnseignantsDispo = "SELECT * FROM utilisateur as U, enseignant AS E WHERE E.id_enseignant = U.id_utilisateur AND id_enseignant NOT IN (SELECT id_enseignant FROM enseignant AS E NATURAL JOIN enseignement AS EN NATURAL JOIN seance AS S WHERE jour = ? AND heure = ?)" + departemensCommand;
			
			try (PreparedStatement statement = connection.prepareStatement(commandEnseignantsDispo))
			{

				statement.setString(1, String.valueOf(jour));
				statement.setString(2, heure);
				for (int i = 0; i < codes.size(); i++)
				{
					statement.setString(3 + i, String.valueOf(codes.get(i)));
				}

				try (ResultSet resultSet = statement.executeQuery())
				{	
					while (resultSet.next())
					{
						int id = resultSet.getInt(1);
						String nom = resultSet.getString(4);
						String prenom = resultSet.getString(5);
						String adresse = resultSet.getString(6);
						Date date_n = (Date) resultSet.getDate(7);
						String email = resultSet.getString(8);
						String telephone = resultSet.getString(9);
						Type_Utilisateur type_utilisateur = Type_Utilisateur.valueOf(resultSet.getString(10));
						String grade = resultSet.getString(12);
						Code_Departement r_code_departement = Code_Departement.valueOf(resultSet.getString(13));
						
						Utilisateur utilisateur = new Utilisateur(id, "", "", nom, prenom, adresse, date_n, email, telephone, type_utilisateur);
						Enseignant enseignant = new Enseignant(utilisateur, grade, r_code_departement);
						result.add(new EnseignantDisponibleResponse(enseignant, true));
					} 		
				}
			}
			
			String commandEnseignantsNotDispo = "SELECT * FROM utilisateur as U, enseignant AS E WHERE E.id_enseignant = U.id_utilisateur AND id_enseignant IN (SELECT id_enseignant FROM enseignant AS E NATURAL JOIN enseignement AS EN NATURAL JOIN seance AS S WHERE jour = ? AND heure = ?)" + departemensCommand;
			
			try (PreparedStatement statement = connection.prepareStatement(commandEnseignantsNotDispo))
			{
				statement.setString(1, String.valueOf(jour));
				statement.setString(2, heure);
				for (int i = 0; i < codes.size(); i++)
				{
					statement.setString(3 + i, String.valueOf(codes.get(i)));
				}

				try (ResultSet resultSet = statement.executeQuery())
				{	
					while (resultSet.next())
					{
						int id = resultSet.getInt(1);
						String nom = resultSet.getString(4);
						String prenom = resultSet.getString(5);
						String adresse = resultSet.getString(6);
						Date date_n = (Date) resultSet.getDate(7);
						String email = resultSet.getString(8);
						String telephone = resultSet.getString(9);
						Type_Utilisateur type_utilisateur = Type_Utilisateur.valueOf(resultSet.getString(10));
						String grade = resultSet.getString(12);
						Code_Departement r_code_departement = Code_Departement.valueOf(resultSet.getString(13));
						
						Utilisateur utilisateur = new Utilisateur(id, "", "", nom, prenom, adresse, date_n, email, telephone, type_utilisateur);
						Enseignant enseignant = new Enseignant(utilisateur, grade, r_code_departement);
						result.add(new EnseignantDisponibleResponse(enseignant, false));
					} 		
				}
			}
			
			return result;
		}
		catch (Exception e)
		{
			System.out.println("Connection error in "+ Thread.currentThread().getStackTrace()[1].getMethodName() +" >>> " + e.getMessage());
			return null;
		}
	}
	
	public static boolean IsEnseignantLibre(int id_enseignant, String code_seance)
	{
		Seance seance = DAO_Seance.GetSeanceByCode_Seance(code_seance);
		
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "SELECT * FROM utilisateur as U, enseignant AS E WHERE E.id_enseignant = U.id_utilisateur \r\n" + 
					"AND id_enseignant NOT IN (SELECT id_enseignant FROM enseignant AS E NATURAL JOIN enseignement AS EN NATURAL JOIN seance AS S WHERE jour = ? AND heure = ?) AND id_enseignant = ?";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setString(1, String.valueOf(seance.getJour()));
				statement.setString(2, seance.getHeure());
				statement.setInt(3, id_enseignant);
				
				
				try (ResultSet resultSet = statement.executeQuery())
				{	
					if (resultSet.next())
					{
						return true;				
					} 
					else
					{
						return false;
					}

				}
			}
		}
		catch (Exception e)
		{
			System.out.println("Connection error in "+ Thread.currentThread().getStackTrace()[1].getMethodName() +" >>> " + e.getMessage());
			return false;
		}
	}
}
