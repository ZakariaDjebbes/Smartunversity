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
	private ArrayList<Etudiant> etudiants = null;

	public Dot_Seance(Seance seance, Module module, ArrayList<Etudiant> etudiants)
	{
		this.seance = seance;
		this.module = module;
		this.etudiants = etudiants;
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
	
	public ArrayList<Etudiant> getEtudiants()
	{
		Collections.sort(etudiants, new Comparator<Etudiant>()
		{

			@Override
			public int compare(Etudiant etudiant1, Etudiant etudiant2)
			{
				return etudiant1.getNom().compareTo(etudiant2.getNom());
	}
		});
		
		return etudiants;
	}

	public void setEtudiants(ArrayList<Etudiant> etudiants)
	{
		this.etudiants = etudiants;
	}
}
