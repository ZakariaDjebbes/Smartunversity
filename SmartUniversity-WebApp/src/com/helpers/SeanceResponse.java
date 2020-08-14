package com.helpers;

import java.util.ArrayList;

import com.modele.ChangementSeance;
import com.modele.Module;
import com.modele.Seance;
import com.modele.SeanceSupp;

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
	
	public static SeanceResponse GetByCodeSeance(ArrayList<SeanceResponse> seancesResponse, String code_seance)
	{
		SeanceResponse result = null;
		for (SeanceResponse seanceResponse : seancesResponse)
		{
			if(seanceResponse.getSeance().getCode_seance().equals(code_seance))
			{
				result = seanceResponse;
				return result;
			}
		}
		
		return null;
	}
	
	public boolean hasEtudiantsExclus()
	{
		int result = 0;
		if(etudiants != null)
		{
			for (EtudiantResponse etudiantResponse : etudiants)
			{
				if(etudiantResponse.isExclus())
				{
					result++;
				}
			}
		}
		
		return result > 0;
	}
	
	public boolean hasAbsences()
	{	
		if(etudiants != null)
		{
			for (EtudiantResponse etudiantResponse : etudiants)
			{
				if(etudiantResponse.getNombreAbsences() > 0)
				{
					return true;
				}
			}
		}
		
		return false;
	}
	
	public boolean hasEtudiants()
	{
		if(etudiants != null && etudiants.size() > 0)
			return true;
		
		return false;
	}
}
