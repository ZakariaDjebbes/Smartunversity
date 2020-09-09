package com.data;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.dots.Dot_CongeAcademique_Android;
import com.dots.Dot_Create_CongeAcademique;
import com.helpers.DemandeCongeAcademiqueResponse;
import com.modele.CongeAcademique;
import com.modele.Etudiant;
import com.modele.Etudiant.Etat_Etudiant;
import com.modele.Seance.Etat_Demande;
import com.modele.Utilisateur.Code_Departement;

public class DAO_CongeAcademique extends DAO_Initialize
{
	public static CongeAcademique GetCongeAcademiqueByCode(int numero_conge_academique)
	{
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "SELECT * FROM congeAcademique WHERE numero_conge_academique = ?;";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setInt(1, numero_conge_academique);

				try (ResultSet resultSet = statement.executeQuery())
				{
					if (resultSet.next())
					{
						int id_etudiant = resultSet.getInt(2);
						Blob blob = resultSet.getBlob(3);
						byte[] fichier = blob.getBytes(1, (int) blob.length());
						String extension = resultSet.getString(4);
						Etat_Demande etat_demande = Etat_Demande.valueOf(resultSet.getString(5));

						CongeAcademique congeAcademique = new CongeAcademique(numero_conge_academique, id_etudiant,
								fichier, extension, etat_demande);
						return congeAcademique;
					}

					return null;
				}
			}
		} catch (Exception e)
		{
			System.out.println("Connection error in " + Thread.currentThread().getStackTrace()[1].getMethodName()
					+ " >>> " + e.getMessage());
			return null;
		}
	}

	public static CongeAcademique GetCongeAcademiqueByEtudiant(int id_etudiant)
	{
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "SELECT * FROM congeAcademique WHERE id_etudiant = ?;";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setInt(1, id_etudiant);

				try (ResultSet resultSet = statement.executeQuery())
				{
					if (resultSet.next())
					{
						int numero_conge_academique = resultSet.getInt(1);
						Blob blob = resultSet.getBlob(3);
						byte[] fichier = blob.getBytes(1, (int) blob.length());
						String extension = resultSet.getString(4);
						Etat_Demande etat_demande = Etat_Demande.valueOf(resultSet.getString(5));

						CongeAcademique congeAcademique = new CongeAcademique(numero_conge_academique, id_etudiant,
								fichier, extension, etat_demande);
						return congeAcademique;
					}

					return null;
				}
			}
		} catch (Exception e)
		{
			System.out.println("Connection error in " + Thread.currentThread().getStackTrace()[1].getMethodName()
					+ " >>> " + e.getMessage());
			return null;
		}
	}

	public static boolean CreateCongeAcademique(Dot_Create_CongeAcademique detailCongeAcademique, InputStream fichier)
	{
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "INSERT INTO CongeAcademique VALUES(NULL, ?, ?, ?, ?);";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setInt(1, detailCongeAcademique.getId_etudiant());
				statement.setBlob(2, fichier);
				statement.setString(3, detailCongeAcademique.getExtension());
				statement.setString(4, String.valueOf(Etat_Demande.nonTraite));

				return statement.executeUpdate() == 1 ? true : false;
			}
		} catch (Exception e)
		{
			System.out.println("Connection error in " + Thread.currentThread().getStackTrace()[1].getMethodName()
					+ " >>> " + e.getMessage());
			return false;
		}
	}

	public static boolean CreateCongeAcademique(Dot_CongeAcademique_Android conge_academique)
	{
		InputStream imageStream = new ByteArrayInputStream(conge_academique.getImage());

		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "INSERT INTO CongeAcademique VALUES(NULL, ?, ?, ?, ?);";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setInt(1, conge_academique.getId_etudiant());
				statement.setBlob(2, imageStream);
				statement.setString(3, conge_academique.getExtension());
				statement.setString(4, String.valueOf(Etat_Demande.nonTraite));

				return statement.executeUpdate() == 1 ? true : false;
			}
		} catch (Exception e)
		{
			System.out.println("Connection error in " + Thread.currentThread().getStackTrace()[1].getMethodName()
					+ " >>> " + e.getMessage());
			return false;
		}
	}

	public static ArrayList<DemandeCongeAcademiqueResponse> GetDemandesCongeAcademiqueOfDepartement(
			Code_Departement code_departement)
	{
		ArrayList<DemandeCongeAcademiqueResponse> result = new ArrayList<DemandeCongeAcademiqueResponse>();

		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "SELECt * FROM congeacademique AS C, etudiant AS E WHERE C.id_etudiant = E.id_etudiant AND code_departement = ?;";

			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setString(1, String.valueOf(code_departement));

				try (ResultSet resultSet = statement.executeQuery())
				{
					while (resultSet.next())
					{
						int numero_conge_academique = resultSet.getInt(1);
						Blob blob = resultSet.getBlob(3);
						byte[] fichier = blob.getBytes(1, (int) blob.length());
						String extension = resultSet.getString(4);
						Etat_Demande etat_demande = Etat_Demande.valueOf(resultSet.getString(5));
						int id_etudiant = resultSet.getInt(2);

						Etudiant etudiant = DAO_Etudiant.GetEtudiantById(id_etudiant);
						CongeAcademique congeAcademique = new CongeAcademique(numero_conge_academique, id_etudiant,
								fichier, extension, etat_demande);
						DemandeCongeAcademiqueResponse demande = new DemandeCongeAcademiqueResponse(congeAcademique,
								etudiant);

						result.add(demande);
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

	public static boolean SetEtatDemande(Etat_Demande etat_seance, int numero_conge_academique)
	{
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "UPDATE congeAcademique SET etat = ? WHERE numero_conge_academique = ? LIMIT 1;";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setString(1, String.valueOf(etat_seance));
				statement.setInt(2, numero_conge_academique);

				return statement.executeUpdate() == 1;
			}
		} catch (Exception e)
		{
			System.out.println("Connection error in " + Thread.currentThread().getStackTrace()[1].getMethodName()
					+ " >>> " + e.getMessage());
			return false;
		}
	}

	public static boolean AcceptCongeAcademique(int numero_conge_academique, int id_etudiant)
	{
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "UPDATE congeAcademique SET etat = ? WHERE numero_conge_academique = ? LIMIT 1;";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setString(1, String.valueOf(Etat_Demande.valide));
				statement.setInt(2, numero_conge_academique);

				if (!DAO_Etudiant.SetEtatEtudiant(id_etudiant, Etat_Etudiant.bloque))
				{
					return false;
				}

				return statement.executeUpdate() == 1;
			}
		} catch (Exception e)
		{
			System.out.println("Connection error in " + Thread.currentThread().getStackTrace()[1].getMethodName()
					+ " >>> " + e.getMessage());
			return false;
		}
	}

	public static boolean RefuserCongeAcademique(int numero_conge_academique, int id_etudiant)
	{
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "UPDATE congeAcademique SET etat = ? WHERE numero_conge_academique = ? LIMIT 1;";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setString(1, String.valueOf(Etat_Demande.refuse));
				statement.setInt(2, numero_conge_academique);

				if (!DAO_Etudiant.SetEtatEtudiant(id_etudiant, Etat_Etudiant.actif))
				{
					return false;
				}

				return statement.executeUpdate() == 1;
			}
		} catch (Exception e)
		{
			System.out.println("Connection error in " + Thread.currentThread().getStackTrace()[1].getMethodName()
					+ " >>> " + e.getMessage());
			return false;
		}
	}

	public static boolean DeleteCongeAcademique(int numero_conge_academique)
	{
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "DELETE FROM congeAcademique WHERE numero_conge_academique = ?;";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setInt(1, numero_conge_academique);

				return statement.executeUpdate() == 1 ? true : false;
			}
		} catch (Exception e)
		{
			System.out.println("Connection error in " + Thread.currentThread().getStackTrace()[1].getMethodName()
					+ " >>> " + e.getMessage());
			return false;
		}
	}
}
