package com.data;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.dots.Dot_Create_Seance;
import com.helpers.Utility;
import com.modele.Etudiant.Annee;
import com.modele.Etudiant.Specialite;
import com.modele.Seance;
import com.modele.Seance.Jour;
import com.modele.Seance.Type_Seance;

public class DAO_Seance extends DAO_Initialize
{
	public static ArrayList<Seance> GetSeancesEnseignantByID(int id_enseignant)
	{
		ArrayList<Seance> result = new ArrayList<Seance>();

		try (Connection connection = DriverManager.getConnection(dbURL, dbLogin, dbPassword))
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
		try (Connection connection = DriverManager.getConnection(dbURL, dbLogin, dbPassword))
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

	public static boolean CreateSeance(Dot_Create_Seance seance)
	{
		try (Connection connection = DriverManager.getConnection(dbURL, dbLogin, dbPassword))
		{
			String command = "INSERT INTO Seance VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?); INSERT INTO Enseignement VALUES(?, ?);";

			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				String code_seance = null;
				do
				{
					code_seance = Utility.generateRandomString(10);
				} while (DAO_Seance.GetSeanceByCode_Seance(code_seance) != null);

				//1
				statement.setString(1, code_seance);
				statement.setString(2, seance.getCode_module());
				statement.setString(3, String.valueOf(seance.getType()));
				statement.setString(4, String.valueOf(seance.getAnnee()));
				statement.setString(5, String.valueOf(seance.getSpecialite()));
				statement.setInt(6, seance.getSection());
				statement.setInt(7, seance.getGroupe());
				statement.setString(8, String.valueOf(seance.getJour()));
				statement.setString(9, seance.getHeure());
				//2
				statement.setInt(10, seance.getId_enseignant());
				statement.setString(11, code_seance);

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
