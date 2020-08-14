package com.helpers;

import com.modele.Module;
import com.modele.Enseignant;
import com.modele.Seance;

public class SeanceDepartementResponse
{
	private Seance seance = null;
	private Enseignant enseignant = null;
	private Module module = null;
	
	public SeanceDepartementResponse()
	{
		
	}

	public SeanceDepartementResponse(Module module, Seance seance, Enseignant enseignant)
	{
		this.seance = seance;
		this.enseignant = enseignant;
		this.module = module;
	}

	public Seance getSeance()
	{
		return seance;
	}

	public Enseignant getEnseignant()
	{
		return enseignant;
	}

	public Module getModule()
	{
		return module;
	}
	
	public void setSeance(Seance seance)
	{
		this.seance = seance;
	}

	public void setEnseignant(Enseignant enseignant)
	{
		this.enseignant = enseignant;
	}
	
	public void setModule(Module module)
	{
		this.module = module;
	}
}
