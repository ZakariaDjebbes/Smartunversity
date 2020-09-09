package com.helpers;

import java.util.ArrayList;

import com.modele.Absence;
import com.modele.Etudiant;
import com.modele.Justification;
import com.modele.Module;
import com.modele.Seance;
import com.modele.Seance.Etat_Demande;

public class AbsenceDepartementResponse
{
	private Absence absence = null;
	private ArrayList<Justification> justifications = null;
	private Etudiant etudiant = null;
	private Seance seance = null;
	private Module module = null;
	
	public AbsenceDepartementResponse()
	{
		
	}
	
	public AbsenceDepartementResponse(Absence absence, ArrayList<Justification> justifications, Etudiant etudiant,
			Seance seance, Module module)
	{
		this.absence = absence;
		this.justifications = justifications;
		this.etudiant = etudiant;
		this.seance = seance;
		this.module = module;
	}

	public Absence getAbsence()
	{
		return absence;
	}

	public ArrayList<Justification> getJustifications()
	{
		return justifications;
	}

	public Etudiant getEtudiant()
	{
		return etudiant;
	}

	public Seance getSeance()
	{
		return seance;
	}

	public Module getModule()
	{
		return module;
	}

	public void setAbsence(Absence absence)
	{
		this.absence = absence;
	}

	public void setJustifications(ArrayList<Justification> justifications)
	{
		this.justifications = justifications;
	}

	public void setEtudiant(Etudiant etudiant)
	{
		this.etudiant = etudiant;
	}

	public void setSeance(Seance seance)
	{
		this.seance = seance;
	}

	public void setModule(Module module)
	{
		this.module = module;
	}

	public static AbsenceDepartementResponse GetByNumeroAbsence(ArrayList<AbsenceDepartementResponse> absencesDepartementResponse, int numero_absence)
	{
		AbsenceDepartementResponse result = null;
		for (AbsenceDepartementResponse absence : absencesDepartementResponse)
		{
			if(absence.getAbsence().getNumero_absence() == numero_absence)
			{
				result = absence;
				return result;
			}
		}
		
		return null;
	}
	
	public Justification getLatestJustification()
	{
		for (Justification justification : justifications)
		{
			if(justification.getEtat_justification() == Etat_Demande.valide)
			{
				return justification;
			}
			else if (justification.getEtat_justification() == Etat_Demande.nonTraite)
			{
				return justification;
			}
		}
		
		if(justifications != null && justifications.size() > 0)
		{
			return justifications.get(0);
		}
		else 
		{
			return null;
		}
	}
	
	public boolean isJustifiable()
	{
		for (Justification justification : justifications)
		{
			if(justification.getEtat_justification() == Etat_Demande.valide)
			{
				return false;
			}
			else if (justification.getEtat_justification() == Etat_Demande.nonTraite)
			{
				return false;
			}
		}
		
		return true;
	}
}
