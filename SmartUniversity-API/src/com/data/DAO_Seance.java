package com.data;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.modele.Seance;
import com.modele.Etudiant.Annee;
import com.modele.Etudiant.Specialite;
import com.modele.Seance.Etat_Seance;
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
				
				try(ResultSet resultSet = statement.executeQuery())
				{
					while (resultSet.next())
					{
						String code_seance = resultSet.getString(2);
						
						String commandSeance = "SELECT * FROM Seance WHERE code_seance = ?";
						
						try(PreparedStatement seanceStatement = connection.prepareStatement(commandSeance))
						{
							seanceStatement.setString(1, code_seance);
							
							try(ResultSet seanceResultSet = seanceStatement.executeQuery())
							{
								if(seanceResultSet.next())
								{
									String code_module = seanceResultSet.getString(2);
									Type_Seance type = Type_Seance.valueOf(seanceResultSet.getString(3));
									Annee annee = Annee.valueOf(seanceResultSet.getString(4));
									Specialite specialite = Specialite.valueOf(seanceResultSet.getString(5));
									int section = seanceResultSet.getInt(6);
									int groupe = seanceResultSet.getInt(7);
									Jour jour = Jour.valueOf(seanceResultSet.getString(8));
									String heure = seanceResultSet.getString(9);
									Etat_Seance etat_seance = Etat_Seance.valueOf(seanceResultSet.getString(10));
									
									Seance seance = new Seance(code_seance, code_module, type, annee,
											specialite, section, groupe, jour, heure, etat_seance);
									result.add(seance);
								}
							}
						}
					}
					
					return result;
				}
			}
		} 
		catch (Exception e)
		{
			System.out.println("Connection error in " + Thread.currentThread().getStackTrace()[1].getMethodName()
					+ " >>> " + e.getMessage());
			return null;
		}
	}
}
