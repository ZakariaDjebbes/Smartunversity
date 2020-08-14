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

}
