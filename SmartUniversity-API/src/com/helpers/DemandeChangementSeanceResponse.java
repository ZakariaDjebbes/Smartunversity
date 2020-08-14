package com.helpers;

import javax.xml.bind.annotation.XmlRootElement;

import com.modele.ChangementSeance;
import com.modele.Enseignant;
import com.modele.Module;
import com.modele.Seance;

@XmlRootElement
public class DemandeChangementSeanceResponse
{
	private Enseignant enseignant;
	private ChangementSeance changementSeance;
	private Seance seance;
	private Module module;
	
	public DemandeChangementSeanceResponse()
	{
		
	}
	
	public DemandeChangementSeanceResponse(Enseignant enseignant, Module module, Seance seance, ChangementSeance changementSeance)
	{
		this.enseignant = enseignant;
		this.changementSeance = changementSeance;
		this.seance = seance;
		this.module = module;
	}

	public Enseignant getEnseignant()
	{
		return enseignant;
	}

	public ChangementSeance getChangementSeance()
	{
		return changementSeance;
	}

	public void setEnseignant(Enseignant enseignant)
	{
		this.enseignant = enseignant;
	}

	public void setChangementSeance(ChangementSeance changementSeance)
	{
		this.changementSeance = changementSeance;
	}

	public Seance getSeance()
	{
		return seance;
	}

	public void setSeance(Seance seance)
	{
		this.seance = seance;
	}

	public Module getModule()
	{
		return module;
	}

	public void setModule(Module module)
	{
		this.module = module;
	}
}
