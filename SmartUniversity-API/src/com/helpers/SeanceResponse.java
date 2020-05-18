package com.helpers;

import java.util.ArrayList;

import javax.xml.bind.annotation.XmlRootElement;

import com.modele.ChangementSeance;
import com.modele.Module;
import com.modele.Seance;
import com.modele.SeanceSupp;

@XmlRootElement
public class SeanceResponse
{
	private ArrayList<EtudiantResponse> etudiants = null;
	private Module module = null;
	private Seance seance = null;
	private ChangementSeance changementSeance = null;
	private ArrayList<SeanceSupp> seancesSupp = null;
	
	public SeanceResponse(ArrayList<EtudiantResponse> etudiants, Module module, Seance seance,
			ChangementSeance changementSeance, ArrayList<SeanceSupp> seancesSupp)
	{
		this.etudiants = etudiants;
		this.module = module;
		this.seance = seance;
		this.changementSeance = changementSeance;
		this.seancesSupp = seancesSupp;
	}
	
	public SeanceResponse()
	{
		
	}

	public ArrayList<EtudiantResponse> getEtudiants()
	{
		return etudiants;
	}

	public Module getModule()
	{
		return module;
	}

	public Seance getSeance()
	{
		return seance;
	}

	public ChangementSeance getChangementSeance()
	{
		return changementSeance;
	}
	
	public ArrayList<SeanceSupp> getSeancesSupp()
	{
		return seancesSupp;
	}

	public void setSeancesSupp(ArrayList<SeanceSupp> seancesSupp)
	{
		this.seancesSupp = seancesSupp;
	}

	public void setEtudiants(ArrayList<EtudiantResponse> etudiants)
	{
		this.etudiants = etudiants;
	}

	public void setModule(Module module)
	{
		this.module = module;
	}

	public void setSeance(Seance seance)
	{
		this.seance = seance;
	}

	public void setChangementSeance(ChangementSeance changementSeance)
	{
		this.changementSeance = changementSeance;
	}
}
