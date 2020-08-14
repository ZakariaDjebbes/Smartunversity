package com.helpers;

import javax.xml.bind.annotation.XmlRootElement;

import com.modele.Enseignant;
import com.modele.Module;
import com.modele.Seance;
import com.modele.SeanceSupp;

@XmlRootElement
public class DemandeSeanceSuppResponse
{
	private Enseignant enseignant;
	private SeanceSupp seanceSupp;
	private Seance seance;
	private Module module;
	
	public DemandeSeanceSuppResponse()
	{
		
	}

	public DemandeSeanceSuppResponse(Enseignant enseignant, Module module, Seance seance, SeanceSupp seanceSupp)
	{
		this.enseignant = enseignant;
		this.seanceSupp = seanceSupp;
		this.seance = seance;
		this.module = module;
	}

	public Enseignant getEnseignant()
	{
		return enseignant;
	}

	public SeanceSupp getSeanceSupp()
	{
		return seanceSupp;
	}

	public void setEnseignant(Enseignant enseignant)
	{
		this.enseignant = enseignant;
	}

	public void setSeanceSupp(SeanceSupp seanceSupp)
	{
		this.seanceSupp = seanceSupp;
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
