package com.helpers;

import com.modele.Enseignant;
import com.modele.Module;
import com.modele.Seance;

public class StatistiquesResponse
{
	private Seance seance;
	private Module module;
	private Enseignant enseignant;
	private int nombreAbsences;
	
	public StatistiquesResponse()
	{
		
	}

	public StatistiquesResponse(Seance seance, Module module, Enseignant enseignant, int nombreAbsences)
	{
		this.seance = seance;
		this.module = module;
		this.enseignant = enseignant;
		this.nombreAbsences = nombreAbsences;
	}

	public Seance getSeance()
	{
		return seance;
	}

	public Module getModule()
	{
		return module;
	}

	public Enseignant getEnseignant()
	{
		return enseignant;
	}

	public int getNombreAbsences()
	{
		return nombreAbsences;
	}

	public void setSeance(Seance seance)
	{
		this.seance = seance;
	}

	public void setModule(Module module)
	{
		this.module = module;
	}

	public void setEnseignant(Enseignant enseignant)
	{
		this.enseignant = enseignant;
	}

	public void setNombreAbsences(int nombreAbsences)
	{
		this.nombreAbsences = nombreAbsences;
	}
}
