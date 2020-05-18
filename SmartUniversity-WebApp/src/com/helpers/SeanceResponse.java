package com.helpers;

import java.util.ArrayList;
import java.util.Collections;

import com.modele.ChangementSeance;
import com.modele.Etudiant.Annee;
import com.modele.Etudiant.Specialite;
import com.modele.Module;
import com.modele.Seance;
import com.modele.SeanceSupp;
import com.modele.Seance.Jour;
import com.modele.Seance.Type_Seance;

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
	
	public static ArrayList<String> getUniqueModules(ArrayList<SeanceResponse> seances)
	{
		ArrayList<String> result = new ArrayList<String>();
		
		for (SeanceResponse seance : seances)
		{
			if(!result.contains(seance.getModule().getNom()))
			{
				result.add(seance.getModule().getNom());
			}
		}
		
		return result;
	}
	
	public static ArrayList<Integer> getUniqueGroupes(ArrayList<SeanceResponse> seances)
	{
		ArrayList<Integer> result = new ArrayList<Integer>();
		
		for (SeanceResponse seance : seances)
		{
			if(!result.contains(seance.getSeance().getGroupe()))
			{
				result.add(seance.getSeance().getGroupe());
			}
		}
		
		Collections.sort(result);
		
		return result;
	}
	
	public static ArrayList<String> getUniqueJours(ArrayList<SeanceResponse> seances)
	{
		ArrayList<Jour> result = new ArrayList<Jour>();
		
		for (SeanceResponse seance : seances)
		{
			if(!result.contains(seance.getSeance().getJour()))
			{
				result.add(seance.getSeance().getJour());
			}
		}	
		
		Collections.sort(result);
		
		ArrayList<String> strings = new ArrayList<String>();
		
		for (Jour jour : result)
		{
			String str = String.valueOf(jour);
			strings.add(str.substring(0, 1).toUpperCase() + str.substring(1));
		}
		
		return strings;
	}
	
	public static ArrayList<Annee> getUniqueAnnees(ArrayList<SeanceResponse> seances)
	{
		ArrayList<Annee> result = new ArrayList<Annee>();
		
		for (SeanceResponse seance : seances)
		{
			if(!result.contains(seance.getSeance().getAnnee()))
			{
				result.add(seance.getSeance().getAnnee());
			}
		}	
		
		Collections.sort(result);
		
		return result;
	}
	
	public static ArrayList<Specialite> getUniqueSpecialites(ArrayList<SeanceResponse> seances)
	{
		ArrayList<Specialite> result = new ArrayList<Specialite>();
		
		for (SeanceResponse seance : seances)
		{
			if(!result.contains(seance.getSeance().getSpecialite()))
			{
				result.add(seance.getSeance().getSpecialite());
			}
		}	
		
		Collections.sort(result);
		
		return result;
	}
	
	public static ArrayList<String> getUniqueHeures(ArrayList<SeanceResponse> seances)
	{
		ArrayList<String> result = new ArrayList<String>();
		
		for (SeanceResponse seance : seances)
		{
			if(!result.contains(seance.getSeance().getHeure()))
			{
				result.add(seance.getSeance().getHeure());
			}
		}	
		
		Collections.sort(result);
		
		return result;
	}
	
	public static ArrayList<Type_Seance> getUniqueTypes(ArrayList<SeanceResponse> seances)
	{
		ArrayList<Type_Seance> result = new ArrayList<Type_Seance>();
		
		for (SeanceResponse seance : seances)
		{
			if(!result.contains(seance.getSeance().getType()))
			{
				result.add(seance.getSeance().getType());
			}
		}	
		
		Collections.sort(result);
		
		return result;
	}
}
