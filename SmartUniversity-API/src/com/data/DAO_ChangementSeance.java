package com.data;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.dots.Dot_Create_ChangementSeance;
import com.helpers.DemandeChangementSeanceResponse;
import com.modele.ChangementSeance;
import com.modele.Enseignant;
import com.modele.Module;
import com.modele.Seance;
import com.modele.Seance.Etat_Demande;
import com.modele.Seance.Jour;
import com.modele.Utilisateur.Code_Departement;

public class DAO_ChangementSeance extends DAO_Initialize
{
	public static ChangementSeance GetChangementSeance(String code_seance)
	{
		ChangementSeance changementSeance = null;
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "SELECT * FROM ChangementSeance WHERE code_seance = ?;";

			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setString(1, code_seance);

				try (ResultSet resultSet = statement.executeQuery())
				{
					if (resultSet.next())
					{
						Jour nouveau_jour = Jour.valueOf(resultSet.getString(2));
						String nouvelle_heure = resultSet.getString(3);
						Etat_Demande etat_demande = Etat_Demande.valueOf(resultSet.getString(4));

						changementSeance = new ChangementSeance(code_seance, nouveau_jour, nouvelle_heure,
								etat_demande);
					}

					return changementSeance;
				}
			}

		} catch (Exception e)
		{
			System.out.println("Connection error in " + Thread.currentThread().getStackTrace()[1].getMethodName()
					+ " >>> " + e.getMessage());
			return null;
		}
	}

	public static boolean CreateChangementSeance(Dot_Create_ChangementSeance dot_Create_ChangementSeance)
	{
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "INSERT INTO changementSeance(code_seance, nouveau_jour, nouvelle_heure) VALUES(?, ?, ?);";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setString(1, dot_Create_ChangementSeance.getCode_seance());
				statement.setString(2, String.valueOf(dot_Create_ChangementSeance.getNouveau_jour()));
				statement.setString(3, dot_Create_ChangementSeance.getNouvelle_heure());

				return statement.executeUpdate() == 1 ? true : false;
			}
		} catch (Exception e)
		{
			System.out.println("Connection error in " + Thread.currentThread().getStackTrace()[1].getMethodName()
					+ " >>> " + e.getMessage());
			return false;
		}
	}

	public static boolean DeleteChangementSeance(String code_seance)
	{
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "DELETE FROM changementSeance WHERE code_seance = ? LIMIT 1;";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setString(1, code_seance);

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

	public static ArrayList<DemandeChangementSeanceResponse> GetChangementSeanceOfEnseignants(
			Code_Departement code_departement)
	{
		ArrayList<DemandeChangementSeanceResponse> result = new ArrayList<DemandeChangementSeanceResponse>();

		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "SELECT * FROM changementseance NATURAL JOIN enseignement NATURAL JOIN enseignant, utilisateur WHERE id_utilisateur = id_enseignant AND code_departement = ?;";

			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setString(1, String.valueOf(code_departement));

				try (ResultSet resultSet = statement.executeQuery())
				{
					while (resultSet.next())
					{
						int id_enseignant = resultSet.getInt(1);
						String code_seance = resultSet.getString(2);
						Jour nouveau_jour = Jour.valueOf(resultSet.getString(3));
						String nouvelle_heure = resultSet.getString(4);
						Etat_Demande etat_seance = Etat_Demande.valueOf(resultSet.getString(5));

						ChangementSeance changementSeance = new ChangementSeance(code_seance, nouveau_jour,
								nouvelle_heure, etat_seance);
						Enseignant enseignant = DAO_Enseignant.GetEnseignantById(id_enseignant);
						Seance seance = DAO_Seance.GetSeanceByCode_Seance(code_seance);
						Module module = DAO_Module.GetMouleByCode(seance.getCode_module());

						result.add(new DemandeChangementSeanceResponse(enseignant, module, seance, changementSeance));
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

	public static boolean SetEtatDemande(Etat_Demande etat_demande, String code_seance)
	{
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "UPDATE changementSeance SET etat_demande = ? WHERE code_seance = ? LIMIT 1;";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setString(1, String.valueOf(etat_demande));
				statement.setString(2, code_seance);

				return statement.executeUpdate() == 1;
			}
		} catch (Exception e)
		{
			System.out.println("Connection error in " + Thread.currentThread().getStackTrace()[1].getMethodName()
					+ " >>> " + e.getMessage());
			return false;
		}
	}

	public static boolean ChangerSeance(ChangementSeance changementSeance)
	{
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "UPDATE seance SET heure = ?, jour = ? WHERE code_seance = ? LIMIT 1;";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setString(1, changementSeance.getHeure());
				statement.setString(2, String.valueOf(changementSeance.getNouveau_jour()));
				statement.setString(3, changementSeance.getCode_seance());		
			
				return statement.executeUpdate() == 1;
			}
		} catch (Exception e)
		{
			System.out.println("Connection error in " + Thread.currentThread().getStackTrace()[1].getMethodName()
					+ " >>> " + e.getMessage());
			return false;
		}

	}

	public static boolean IsEnseignantDisponible(int id_enseignant, String heure, Jour jour)
	{
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "SELECT * FROM changementseance NATURAL JOIN enseignement WHERE id_enseignant = ? AND nouvelle_heure = ? AND nouveau_jour = ?;";

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
