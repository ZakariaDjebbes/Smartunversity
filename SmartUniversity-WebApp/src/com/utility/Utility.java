package com.utility;

import java.util.Calendar;
import java.util.Date;

import com.modele.ChefDepartement;
import com.modele.Enseignant;
import com.modele.Etudiant;
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
			return null;
		default:
			return null;
		}
	}
}
