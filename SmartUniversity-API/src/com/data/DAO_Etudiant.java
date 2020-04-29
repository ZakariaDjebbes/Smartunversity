package com.data;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;

import com.modele.Etudiant;
import com.modele.Utilisateur;
import com.modele.Etudiant.Annee;
import com.modele.Etudiant.Etat_Etudiant;
import com.modele.Etudiant.Specialite;
import com.modele.Utilisateur.Code_Departement;
import com.modele.Utilisateur.Type_Utilisateur;

public class DAO_Etudiant extends DAO_Initialize
{
	public static ArrayList<Etudiant> GetEtudiants(Annee annee, Specialite specialite, int groupe)
	{
		ArrayList<Etudiant> result = new ArrayList<Etudiant>();
		try (Connection connection = DriverManager.getConnection(dbURL, dbLogin, dbPassword))
		{
			String command = "SELECT * FROM utilisateur, etudiant WHERE id_utilisateur = id_etudiant AND annee = ? AND specialite = ? AND groupe = ?;";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setString(1, String.valueOf(annee));
				statement.setString(2, String.valueOf(specialite));
				statement.setInt(3, groupe);
				
				try(ResultSet resultSet = statement.executeQuery())
				{
					while(resultSet.next())
					{
						//Utilisateur
						int id_utilisateur = resultSet.getInt(1);
						String nom = resultSet.getString(4);
						String prenom = resultSet.getString(5);
						String adresse = resultSet.getString(6);
						Date date_n = (Date) resultSet.getDate(7);
						String email = resultSet.getString(8);
						String telephone = resultSet.getString(9);
						Type_Utilisateur type_utilisateur = Type_Utilisateur.valueOf(resultSet.getString(10));
						
						Utilisateur utilisateur = new Utilisateur(id_utilisateur, "", "", nom, prenom, adresse, date_n, email, telephone, type_utilisateur);
						
						//Etudiant
						int section = resultSet.getInt(14);
						Etat_Etudiant etat_etudiant = Etat_Etudiant.valueOf(resultSet.getString(16));
						Code_Departement code_departement = Code_Departement.valueOf(resultSet.getString(17));
						
						Etudiant etudiant = new Etudiant(utilisateur, annee, specialite, section, groupe, etat_etudiant, code_departement);
						
						result.add(etudiant);
					}
					
						return result;
				}
			}
		}
		catch (Exception e)
		{
			System.out.println("Connection error in "+ Thread.currentThread().getStackTrace()[1].getMethodName() +" >>> " + e.getMessage());
			return null;
		}
	}
}
