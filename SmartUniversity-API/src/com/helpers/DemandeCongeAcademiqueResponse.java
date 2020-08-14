package com.helpers;

import javax.xml.bind.annotation.XmlRootElement;

import com.modele.CongeAcademique;
import com.modele.Etudiant;

@XmlRootElement
public class DemandeCongeAcademiqueResponse
{
	private CongeAcademique congeAcademique;
	private Etudiant etudiant;
	
	public DemandeCongeAcademiqueResponse()
	{
		
	}
	
	public DemandeCongeAcademiqueResponse(CongeAcademique congeAcademique, Etudiant etudiant)
	{
		this.congeAcademique = congeAcademique;
		this.etudiant = etudiant;
	}

	public CongeAcademique getCongeAcademique()
	{
		return congeAcademique;
	}

	public Etudiant getEtudiant()
	{
		return etudiant;
	}

	public void setCongeAcademique(CongeAcademique congeAcademique)
	{
		this.congeAcademique = congeAcademique;
	}

	public void setEtudiant(Etudiant etudiant)
	{
		this.etudiant = etudiant;
	}
}
