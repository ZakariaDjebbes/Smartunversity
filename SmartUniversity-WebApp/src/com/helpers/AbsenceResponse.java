package com.helpers;

import java.util.ArrayList;

import com.modele.Absence;
import com.modele.Justification;
import com.modele.Seance.Etat_Demande;

public class AbsenceResponse
{
	private Absence absence = null;
	private boolean isJustifier = false;
	private ArrayList<Justification> justifications = null;
	
	public AbsenceResponse(Absence absence, boolean isJustifier, ArrayList<Justification> justifications)
	{
		this.absence = absence;
		this.isJustifier = isJustifier;
		this.justifications = justifications;
	}
	
	public AbsenceResponse()
	{
		
	}

	public Absence getAbsence()
	{
		return absence;
	}

	public boolean isJustifier()
	{
		return isJustifier;
	}

	public boolean CheckNonTraite()
	{
		if(justifications == null) return false;
			
		for (Justification justification : justifications)
		{
			if(justification.getEtat_justification() == Etat_Demande.nonTraite) return true;
		}
		
		return false;
	}
	
	public boolean CheckRefuse()
	{
		if(justifications == null) return false;
		
		for (Justification justification : justifications)
		{
			if(justification.getEtat_justification() == Etat_Demande.refuse) return true;
		}
		
		return false;
	}

	public ArrayList<Justification> getJustifications()
	{
		return justifications;
	}

	public void setAbsence(Absence absence)
	{
		this.absence = absence;
	}

	public void setJustifier(boolean isJustifier)
	{
		this.isJustifier = isJustifier;
	}

	public void setJustifications(ArrayList<Justification> justifications)
	{
		this.justifications = justifications;
	}
	
	public Justification getJustificationValide()
	{
		if(justifications != null)
		{
			for (Justification justification : justifications)
			{
				if(justification.getEtat_justification() == Etat_Demande.valide)
				{
					return justification;
				}
			}
		}		
		return null;
	}
	
	public boolean hasJustification()
	{
		return justifications != null;
	}
	
	public Justification GetLastJustificationByEtat()
	{
		Justification result = null;
		
		for (Justification justification : justifications)
		{
			if(justification.getEtat_justification() == Etat_Demande.valide)
			{
				return justification;
			}
			else
			{
				if(justification.getEtat_justification() == Etat_Demande.nonTraite)
				{
					result = justification;
				}
				else
				{
					if(result == null) result = justification;
				}
			}
		}
		
		return result;
	}
	
	public static AbsenceResponse GetAbsenceByNumero(ArrayList<AbsenceResponse> absencesResponse, int numero_absence)
	{
		for (AbsenceResponse absenceResponse : absencesResponse)
		{
			if(absenceResponse.getAbsence().getNumero_absence() == numero_absence)
			{
				return absenceResponse;
			}
		}
		
		return null;
	}

	@Override
	public String toString()
	{
		return "AbsenceResponse [absence=" + absence.getNumero_absence() + ", isJustifier=" + isJustifier + ", justifications="
				+ justifications + "]";
	}
}
