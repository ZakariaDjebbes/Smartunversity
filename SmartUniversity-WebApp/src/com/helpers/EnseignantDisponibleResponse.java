package com.helpers;

import javax.xml.bind.annotation.XmlRootElement;

import com.modele.Enseignant;

@XmlRootElement
public class EnseignantDisponibleResponse
{
	private Enseignant enseignant = null;
	private boolean isDisponible = false;
	
	public EnseignantDisponibleResponse()
	{
		
	}

	public EnseignantDisponibleResponse(Enseignant enseignant, boolean isDisponible)
	{
		this.enseignant = enseignant;
		this.isDisponible = isDisponible;
	}

	public Enseignant getEnseignant()
	{
		return enseignant;
	}

	public boolean isDisponible()
	{
		return isDisponible;
	}

	public void setEnseignant(Enseignant enseignant)
	{
		this.enseignant = enseignant;
	}

	public void setDisponible(boolean isDisponible)
	{
		this.isDisponible = isDisponible;
	}
}
