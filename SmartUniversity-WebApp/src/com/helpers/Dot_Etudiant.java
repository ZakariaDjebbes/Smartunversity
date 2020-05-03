package com.helpers;

import java.util.ArrayList;

import com.modele.Absence;
import com.modele.Etudiant;

public class Dot_Etudiant
{
	private Etudiant etudiant = null;
	private ArrayList<Absence> absences = null;
	
	public Dot_Etudiant(Etudiant etudiant, ArrayList<Absence> absences)
	{
		this.etudiant = etudiant;
		this.absences = absences;
	}

	public Etudiant getEtudiant()
	{
		return etudiant;
	}

	public ArrayList<Absence> getAbsences()
	{
		return absences;
	}

	public void setEtudiant(Etudiant etudiant)
	{
		this.etudiant = etudiant;
	}

	public void setAbsences(ArrayList<Absence> absences)
	{
		this.absences = absences;
	}
}
