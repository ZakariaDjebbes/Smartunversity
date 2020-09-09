package com.utility;

import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import com.modele.ChefDepartement;
import com.modele.Enseignant;
import com.modele.Etudiant;
import com.modele.Etudiant.Annee;
import com.modele.Etudiant.Specialite;
import com.modele.ResponsableFormation;
import com.modele.Utilisateur;
import com.modele.Utilisateur.Code_Departement;

public class Utility
{
	public static boolean SameDate(Date date1, Date date2)
	{
		Calendar cal1 = Calendar.getInstance();
		Calendar cal2 = Calendar.getInstance();
		cal1.setTime(date1);
		cal2.setTime(date2);
		boolean sameDay = cal1.get(Calendar.DAY_OF_YEAR) == cal2.get(Calendar.DAY_OF_YEAR) &&
		                  cal1.get(Calendar.YEAR) == cal2.get(Calendar.YEAR);
		
		return sameDay;
	}
	
	public static String generateRandomString(int length)
	{
		final String ALPHABET = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
		SecureRandom random = new SecureRandom();
		StringBuilder builder = new StringBuilder(length);

		for (int i = 0; i < length; i++)
		{
			builder.append(ALPHABET.charAt(random.nextInt(ALPHABET.length())));
		}

		return builder.toString();
	}
	
	public static ArrayList<Specialite> GetSpecialitesOfAnnee(Annee annee)
	{
		ArrayList<Specialite> specialites = new ArrayList<Specialite>();
		
		switch (annee)
		{
		case L1:
			specialites.add(Specialite.MI);
			break;
		case L2:
			specialites.add(Specialite.MI);
			break;
		case L3:
			specialites.add(Specialite.GL);
			specialites.add(Specialite.SI);
			specialites.add(Specialite.SCI);
			specialites.add(Specialite.TI);
			break;
		case M1: case M2:
			specialites.add(Specialite.GL);
			specialites.add(Specialite.RSD);
			specialites.add(Specialite.STIW);
			specialites.add(Specialite.STIC);
			break;
		default:
			return null;
		}
		
		return specialites;
	}
	
	public static Code_Departement GetDepartementOfUser(Utilisateur utilisateur)
	{
		switch (utilisateur.getUser_type())
		{
		case chefDepartement:
			return ((ChefDepartement)utilisateur).getCode_departement();
		case enseignant:
			return ((Enseignant)utilisateur).getCode_departement();
		case etudiant:
			return ((Etudiant)utilisateur).getCode_departement();
		case responsableFormation:
			return ((ResponsableFormation)utilisateur).getCode_departement();
		default:
			return null;
		}
	}
}
