package com.helpers;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

import com.modele.Etudiant;
import com.modele.Module;
import com.modele.Seance;

public class Dot_Seance
{
	private Seance seance = null;
	private Module module = null;
	private ArrayList<Dot_Etudiant> dot_etudiants = null;

	public Dot_Seance(Seance seance, Module module, ArrayList<Dot_Etudiant> etudiants)
	{
		this.seance = seance;
		this.module = module;
		this.dot_etudiants = etudiants;
	}

	public Seance getSeance()
	{
		return seance;
	}

	public Module getModule()
	{
		return module;
	}

	public void setSeance(Seance seance)
	{
		this.seance = seance;
	}

	public void setModule(Module module)
	{
		this.module = module;
	}
	
	public ArrayList<Dot_Etudiant> getDot_Etudiants()
	{
		Collections.sort(dot_etudiants, new Comparator<Dot_Etudiant>()
		{

			@Override
			public int compare(Dot_Etudiant etudiant1, Dot_Etudiant etudiant2)
			{
				return etudiant1.getEtudiant().getNom().compareTo(etudiant2.getEtudiant().getNom());
			}
		});
		
		return dot_etudiants;
	}

	public void setDot_Etudiants(ArrayList<Dot_Etudiant> etudiants)
	{
		this.dot_etudiants = etudiants;
	}
	
	public static Dot_Seance GetSeanceByCode_Seance(ArrayList<Dot_Seance> seances, String code_seance)
	{
		Dot_Seance seance = null;
		
		for (Dot_Seance dot_Seance : seances)
		{
			if(dot_Seance.getSeance().getCode_seance().equals(code_seance))
			{
				seance = dot_Seance;
				break;
			}
		}
		
		return seance;
	}

	public ArrayList<Etudiant> GetEtudiants()
	{
		ArrayList<Etudiant> etudiants = new ArrayList<Etudiant>();
		
		for (Dot_Etudiant dot_Etudiant : dot_etudiants)
		{
			etudiants.add(dot_Etudiant.getEtudiant());
		}
		
		return etudiants;
	}
	
	@Override
	public String toString()
	{
		return "Dot_Seance [seance=" + seance + ", module=" + module + ", etudiants=" + dot_etudiants + "]";
	}
}