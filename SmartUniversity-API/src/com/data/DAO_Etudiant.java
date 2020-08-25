package com.data;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;

import com.dots.Dot_Create_Etudiant;
import com.modele.Etudiant;
import com.modele.Etudiant.Annee;
import com.modele.Etudiant.Etat_Etudiant;
import com.modele.Etudiant.Specialite;
import com.modele.Utilisateur;
import com.modele.Utilisateur.Code_Departement;
import com.modele.Utilisateur.Type_Utilisateur;
import com.utility.Utility;

public class DAO_Etudiant extends DAO_Initialize
{
	public static ArrayList<Etudiant> GetEtudiants(Annee annee, Specialite specialite, int groupe)
	{
		ArrayList<Etudiant> result = new ArrayList<Etudiant>();
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "SELECT * FROM utilisateur, etudiant WHERE id_utilisateur = id_etudiant AND annee = ? AND specialite = ? AND groupe = ?;";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setString(1, String.valueOf(annee));
				statement.setString(2, String.valueOf(specialite));
				statement.setInt(3, groupe);

				try (ResultSet resultSet = statement.executeQuery())
				{
					while (resultSet.next())
					{
						// Utilisateur
						int id_utilisateur = resultSet.getInt(1);
						String nom = resultSet.getString(4);
						String prenom = resultSet.getString(5);
						String adresse = resultSet.getString(6);
						Date date_n = (Date) resultSet.getDate(7);
						String email = resultSet.getString(8);
						String telephone = resultSet.getString(9);
						Type_Utilisateur type_utilisateur = Type_Utilisateur.valueOf(resultSet.getString(10));

						Utilisateur utilisateur = new Utilisateur(id_utilisateur, "", "", nom, prenom, adresse, date_n,
								email, telephone, type_utilisateur);

						// Etudiant
						int section = resultSet.getInt(14);
						Etat_Etudiant etat_etudiant = Etat_Etudiant.valueOf(resultSet.getString(16));
						Code_Departement code_departement = Code_Departement.valueOf(resultSet.getString(17));

						Etudiant etudiant = new Etudiant(utilisateur, annee, specialite, section, groupe, etat_etudiant,
								code_departement);

						result.add(etudiant);
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

	public static boolean UpdateEtudiant(Etudiant etudiant)
	{
		if (DAO_User.UpdateUserPasswordLess(etudiant))
		{
			try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
			{
				String command = "UPDATE etudiant SET annee = ?, specialite = ?, groupe = ?, etat = ?, code_departement = ? WHERE id_etudiant = ? LIMIT 1;";
				try (PreparedStatement statement = connection.prepareStatement(command))
				{
					statement.setString(1, String.valueOf(etudiant.getAnnee()));
					statement.setString(2, String.valueOf(etudiant.getSpecialite()));
					statement.setInt(3, etudiant.getGroupe());
					statement.setString(4, String.valueOf(etudiant.getEtat_etudiant()));
					statement.setString(5, String.valueOf(Utility.GetDepartementOfSpecialite(etudiant.getSpecialite())));
					statement.setInt(6, etudiant.getId_utilisateur());
					
					return statement.executeUpdate() == 1;
				}
			} catch (Exception e)
			{
				System.out.println("Connection error in " + Thread.currentThread().getStackTrace()[1].getMethodName()
						+ " >>> " + e.getMessage());
				return false;
			}
		} else
		{
			return false;
		}
	}

	public static ArrayList<Etudiant> GetAllEtudiants()
	{
		ArrayList<Etudiant> result = new ArrayList<Etudiant>();
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "SELECT * FROM utilisateur, etudiant WHERE id_utilisateur = id_etudiant;";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				try (ResultSet resultSet = statement.executeQuery())
				{
					while (resultSet.next())
					{
						// Utilisateur
						int id_utilisateur = resultSet.getInt(1);
						String user = resultSet.getString(2);
						String nom = resultSet.getString(4);
						String prenom = resultSet.getString(5);
						String adresse = resultSet.getString(6);
						Date date_n = (Date) resultSet.getDate(7);
						String email = resultSet.getString(8);
						String telephone = resultSet.getString(9);
						Type_Utilisateur type_utilisateur = Type_Utilisateur.valueOf(resultSet.getString(10));

						Utilisateur utilisateur = new Utilisateur(id_utilisateur, user, "", nom, prenom, adresse,
								date_n, email, telephone, type_utilisateur);

						// Etudiant
						int section = resultSet.getInt(14);
						Annee annee = Annee.valueOf(resultSet.getString(12));
						Specialite specialite = Specialite.valueOf(resultSet.getString(13));
						int groupe = resultSet.getInt(15);
						Etat_Etudiant etat_etudiant = Etat_Etudiant.valueOf(resultSet.getString(16));
						Code_Departement code_departement = Code_Departement.valueOf(resultSet.getString(17));

						Etudiant etudiant = new Etudiant(utilisateur, annee, specialite, section, groupe, etat_etudiant,
								code_departement);

						result.add(etudiant);
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

	public static Etudiant GetEtudiantById(int id_etudiant)
	{
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "SELECT * FROM utilisateur, etudiant WHERE id_utilisateur = id_etudiant AND id_etudiant = ?;";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setInt(1, id_etudiant);
				try (ResultSet resultSet = statement.executeQuery())
				{
					if (resultSet.next())
					{
						// Utilisateur
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

						Utilisateur utilisateur = new Utilisateur(id_utilisateur, user, pass, nom, prenom, adresse,
								date_n, email, telephone, type_utilisateur);

						// Etudiant
						Annee annee = Annee.valueOf(resultSet.getString(12));
						Specialite specialite = Specialite.valueOf(resultSet.getString(13));
						int section = resultSet.getInt(14);
						int groupe = resultSet.getInt(15);
						Etat_Etudiant etat_etudiant = Etat_Etudiant.valueOf(resultSet.getString(16));
						Code_Departement code_departement = Code_Departement.valueOf(resultSet.getString(17));

						Etudiant etudiant = new Etudiant(utilisateur, annee, specialite, section, groupe, etat_etudiant,
								code_departement);

						return etudiant;
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

	public static int CreateEtudiant(Dot_Create_Etudiant dot_Create_Etudiant)
	{
		int id = DAO_User.CreateUser(dot_Create_Etudiant.getDot_create_utilisateur());

		if (id == -1)
		{
			return -1;
		}

		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "INSERT INTO etudiant VALUES(?, ?, ?, ?, ?, ?, ?);";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setInt(1, id);
				statement.setString(2, String.valueOf(dot_Create_Etudiant.getAnnee()));
				statement.setString(3, String.valueOf(dot_Create_Etudiant.getSpecialite()));
				statement.setInt(4, 0);
				statement.setInt(5, dot_Create_Etudiant.getGroupe());
				statement.setString(6, String.valueOf(Etat_Etudiant.actif));
				statement.setString(7,
						String.valueOf(Utility.GetDepartementOfSpecialite(dot_Create_Etudiant.getSpecialite())));

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
	}

	public static boolean SetEtatEtudiant(int id_etudiant, Etat_Etudiant etat_etudiant)
	{
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "UPDATE etudiant SET etat = ? WHERE id_etudiant = ? LIMIT 1;";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setString(1, String.valueOf(etat_etudiant));
				statement.setInt(2, id_etudiant);

				return statement.executeUpdate() == 1;
			}
		} catch (Exception e)
		{
			System.out.println("Connection error in " + Thread.currentThread().getStackTrace()[1].getMethodName()
					+ " >>> " + e.getMessage());
			return false;
		}
	}
}
