package com.helpers;

import java.util.ArrayList;

import com.modele.Absence;
import com.modele.Etudiant;

public class ReleveAbseneces
{
	private ArrayList<Absence> absences = null;
	private Etudiant etudiant = null;
	
	public ReleveAbseneces(ArrayList<Absence> absences, Etudiant etudiant)
	{
		this.absences = absences;
		this.etudiant = etudiant;
	}

	public ArrayList<Absence> getAbsences()
	{
		return absences;
	}

	public Etudiant getEtudiant()
	{
		return etudiant;
	}

	public void setAbsences(ArrayList<Absence> absences)
	{
		this.absences = absences;
	}

	public void setEtudiant(Etudiant etudiant)
	{
		this.etudiant = etudiant;
	}

	@Override
	public String toString()
	{
		return "ReleveAbseneces [absences=" + absences.size() + ", etudiant=" + etudiant + "]";
	}
}
