package com.data;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.helpers.SeanceDepartementResponse;
import com.modele.Etudiant;
import com.modele.Etudiant.Annee;
import com.modele.Etudiant.Specialite;
import com.modele.Module;
import com.modele.Seance;
import com.modele.Seance.Jour;
import com.modele.Seance.Type_Seance;
import com.modele.Utilisateur.Code_Departement;
import com.utility.Utility;

public class DAO_Seance extends DAO_Initialize
{
	public static ArrayList<Seance> GetSeancesEnseignantByID(int id_enseignant)
	{
		ArrayList<Seance> result = new ArrayList<Seance>();

		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String commandEnseignement = "SELECT * FROM Enseignement WHERE id_enseignant = ?;";
			try (PreparedStatement statement = connection.prepareStatement(commandEnseignement))
			{
				statement.setInt(1, id_enseignant);

				try (ResultSet resultSet = statement.executeQuery())
				{
					while (resultSet.next())
					{
						String code_seance = resultSet.getString(2);

						String commandSeance = "SELECT * FROM Seance WHERE code_seance = ?;";

						try (PreparedStatement seanceStatement = connection.prepareStatement(commandSeance))
						{
							seanceStatement.setString(1, code_seance);

							try (ResultSet seanceResultSet = seanceStatement.executeQuery())
							{
								if (seanceResultSet.next())
								{
									String code_module = seanceResultSet.getString(2);
									Type_Seance type = Type_Seance.valueOf(seanceResultSet.getString(3));
									Annee annee = Annee.valueOf(seanceResultSet.getString(4));
									Specialite specialite = Specialite.valueOf(seanceResultSet.getString(5));
									int section = seanceResultSet.getInt(6);
									int groupe = seanceResultSet.getInt(7);
									Jour jour = Jour.valueOf(seanceResultSet.getString(8));
									String heure = seanceResultSet.getString(9);

									Seance seance = new Seance(code_seance, code_module, type, annee, specialite,
											section, groupe, jour, heure);
									result.add(seance);
								}
							}
						}
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

	public static Seance GetSeanceByCode_Seance(String code_seance)
	{
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			Seance seance = null;
			String command = "SELECT * FROM Seance WHERE code_seance = ?;";

			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setString(1, code_seance);

				try (ResultSet resultSet = statement.executeQuery())
				{
					if (resultSet.next())
					{
						String code_module = resultSet.getString(2);
						Type_Seance type = Type_Seance.valueOf(resultSet.getString(3));
						Annee annee = Annee.valueOf(resultSet.getString(4));
						Specialite specialite = Specialite.valueOf(resultSet.getString(5));
						int section = resultSet.getInt(6);
						int groupe = resultSet.getInt(7);
						Jour jour = Jour.valueOf(resultSet.getString(8));
						String heure = resultSet.getString(9);

						seance = new Seance(code_seance, code_module, type, annee, specialite, section, groupe, jour,
								heure);
					}

					return seance;
				}
			}
		} catch (Exception e)
		{
			System.out.println("Connection error in " + Thread.currentThread().getStackTrace()[1].getMethodName()
					+ " >>> " + e.getMessage());
			return null;
		}
	}
	
	public static ArrayList<SeanceDepartementResponse> GetSeancesByCode_Departement(Code_Departement code_departement) throws Exception
	{
		ArrayList<SeanceDepartementResponse> seances = new ArrayList<SeanceDepartementResponse>();
		ArrayList<Specialite> specialites = Utility.GetSpecialitesOfDepartement(code_departement);
		
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "SELECT * FROM Seance WHERE specialite = ?";

			for (int i = 0; i < specialites.size() - 1; i++)
			{
				command += " || specialite = ?";
			}
			
			command += ";";
						
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				for (int i = 1; i <= specialites.size(); i++)
				{
					statement.setString(i, String.valueOf(specialites.get(i - 1)));
				}

				try (ResultSet resultSet = statement.executeQuery())
				{
					while (resultSet.next())
					{
						String code_seance = resultSet.getString(1);
						String code_module = resultSet.getString(2);
						Type_Seance type = Type_Seance.valueOf(resultSet.getString(3));
						Annee annee = Annee.valueOf(resultSet.getString(4));
						Specialite specialite = Specialite.valueOf(resultSet.getString(5));
						int section = resultSet.getInt(6);
						int groupe = resultSet.getInt(7);
						Jour jour = Jour.valueOf(resultSet.getString(8));
						String heure = resultSet.getString(9);
						
						Seance seance = new Seance(code_seance, code_module, type, annee, specialite, section, groupe, jour,
								heure);
						Module module = DAO_Module.GetMouleByCode(seance.getCode_module());
						seances.add(new SeanceDepartementResponse(module, seance, DAO_Enseignant.GetEnseignantBySeance(seance)));
					}
					
					return seances;
				}
			}
		} catch (Exception e)
		{
			System.out.println("Connection error in " + Thread.currentThread().getStackTrace()[1].getMethodName()
					+ " >>> " + e.getMessage());
			return null;
		}
	}
	
	public static ArrayList<Seance> GetSeancesByEtudiant(int id_etudiant)
	{
		ArrayList<Seance> seances = new ArrayList<Seance>();
		Etudiant etudiant = DAO_Etudiant.GetEtudiantById(id_etudiant);
		
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "SELECT * FROM Seance WHERE specialite = ? AND annee = ? AND groupe = ?;";
		
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setString(1, String.valueOf(etudiant.getSpecialite()));
				statement.setString(2, String.valueOf(etudiant.getAnnee()));
				statement.setInt(3, etudiant.getGroupe());
				
				try (ResultSet resultSet = statement.executeQuery())
				{
					while (resultSet.next())
					{
						String code_seance = resultSet.getString(1);
						String code_module = resultSet.getString(2);
						Type_Seance type = Type_Seance.valueOf(resultSet.getString(3));
						Annee annee = Annee.valueOf(resultSet.getString(4));
						Specialite specialite = Specialite.valueOf(resultSet.getString(5));
						int section = resultSet.getInt(6);
						int groupe = resultSet.getInt(7);
						Jour jour = Jour.valueOf(resultSet.getString(8));
						String heure = resultSet.getString(9);
						
						Seance seance = new Seance(code_seance, code_module, type, annee, specialite, section, groupe, jour,
								heure);
						seances.add(seance);
					}
					
					return seances;
				}
			}
		} catch (Exception e)
		{
			System.out.println("Connection error in " + Thread.currentThread().getStackTrace()[1].getMethodName()
					+ " >>> " + e.getMessage());
			return null;
		}
	}
	
	public static boolean IsEnseignantDisponible(int id_enseignant, String heure, Jour jour)
	{
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "SELECT * FROM Seance NATURAL JOIN enseignement where id_enseignant = ? AND heure = ? AND jour = ?;";

			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setInt(1, id_enseignant);
				statement.setString(2, heure);
				statement.setString(3, String.valueOf(jour));
				
				try (ResultSet resultSet = statement.executeQuery())
				{
					return !resultSet.next();
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
