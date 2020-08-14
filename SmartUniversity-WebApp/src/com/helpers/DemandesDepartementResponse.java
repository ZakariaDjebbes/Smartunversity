package com.helpers;

import java.util.ArrayList;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class DemandesDepartementResponse
{
	ArrayList<DemandeSeanceSuppResponse> demandesSeanceSuppResponse;
	ArrayList<DemandeChangementSeanceResponse> demandesChangementSeanceResponse;
	ArrayList<DemandeCongeAcademiqueResponse> demandesCongeAcademiqueResponse;
	
	public DemandesDepartementResponse()
	{
		
	}

	public DemandesDepartementResponse(ArrayList<DemandeSeanceSuppResponse> demandesSeanceSuppResponse,
			ArrayList<DemandeChangementSeanceResponse> demandesChangementSeanceResponse,
			ArrayList<DemandeCongeAcademiqueResponse> demandesEtudiantsResponse)
	{
		this.demandesSeanceSuppResponse = demandesSeanceSuppResponse;
		this.demandesChangementSeanceResponse = demandesChangementSeanceResponse;
		this.demandesCongeAcademiqueResponse = demandesEtudiantsResponse;
	}

	public ArrayList<DemandeSeanceSuppResponse> getDemandesSeanceSuppResponse()
	{
		return demandesSeanceSuppResponse;
	}

	public ArrayList<DemandeChangementSeanceResponse> getDemandesChangementSeanceResponse()
	{
		return demandesChangementSeanceResponse;
	}

	public ArrayList<DemandeCongeAcademiqueResponse> getDemandesCongeAcademiqueResponse()
	{
		return demandesCongeAcademiqueResponse;
	}

	public void setDemandesSeanceSuppResponse(ArrayList<DemandeSeanceSuppResponse> demandesSeanceSuppResponse)
	{
		this.demandesSeanceSuppResponse = demandesSeanceSuppResponse;
	}

	public void setDemandesChangementSeanceResponse(
			ArrayList<DemandeChangementSeanceResponse> demandesChangementSeanceResponse)
	{
		this.demandesChangementSeanceResponse = demandesChangementSeanceResponse;
	}

	public void setDemandesCongeAcademiqueResponse(
			ArrayList<DemandeCongeAcademiqueResponse> demandesCongeAcademiqueResponse)
	{
		this.demandesCongeAcademiqueResponse = demandesCongeAcademiqueResponse;
	}

	public DemandeSeanceSuppResponse GetDemandeSeanceSuppByCodeSeanceSupp(int codeSeanceSupp)
	{
		for (DemandeSeanceSuppResponse demande : demandesSeanceSuppResponse)
		{
			if(demande.getSeanceSupp().getCode_seance_supp() == codeSeanceSupp)
			{
				return demande;
			}
		}
		
		return null;
	}
	
	public DemandeChangementSeanceResponse GetDemandeChangementByCodeSeance(String code_seance)
	{
		for (DemandeChangementSeanceResponse demande : demandesChangementSeanceResponse)
		{
			if(demande.getChangementSeance().getCode_seance().equals(code_seance))
			{
				return demande;
			}
		}
		
		return null;
	}
	
	public DemandeCongeAcademiqueResponse GetDemandeCongeAcademique(int numero_conge_academique)
	{
		for (DemandeCongeAcademiqueResponse demande : demandesCongeAcademiqueResponse)
		{
			if(demande.getCongeAcademique().getNumero_conge_academique() == numero_conge_academique)
			{
				return demande;
			}
		}
		
		return null;
	}
}
