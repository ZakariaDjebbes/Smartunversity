package com.dots;

import javax.xml.bind.annotation.XmlRootElement;

import com.modele.Etudiant.Annee;
import com.modele.Etudiant.Specialite;

@XmlRootElement
public class Dot_Create_Etudiant implements IDot
{
	private Dot_Create_Utilisateur dot_create_utilisateur;
	private Annee annee;
	private Specialite specialite;
	private int groupe;
	
	public Dot_Create_Etudiant()
	{
	}
	
	public Dot_Create_Etudiant(Dot_Create_Utilisateur dot_create_utilisateur, Annee annee, Specialite specialite,
			int groupe)
	{
		this.dot_create_utilisateur = dot_create_utilisateur;
		this.annee = annee;
		this.specialite = specialite;
		this.groupe = groupe;
	}

	public Dot_Create_Utilisateur getDot_create_utilisateur()
	{
		return dot_create_utilisateur;
	}

	public Annee getAnnee()
	{
		return annee;
	}

	public Specialite getSpecialite()
	{
		return specialite;
	}

	public int getGroupe()
	{
		return groupe;
	}

	public void setDot_create_utilisateur(Dot_Create_Utilisateur dot_create_utilisateur)
	{
		this.dot_create_utilisateur = dot_create_utilisateur;
	}

	public void setAnnee(Annee annee)
	{
		this.annee = annee;
	}

	public void setSpecialite(Specialite specialite)
	{
		this.specialite = specialite;
	}

	public void setGroupe(int groupe)
	{
		this.groupe = groupe;
	}
	
	@Override
	public String toString()
	{
		return "Dot_Create_Etudiant [dot_create_utilisateur=" + dot_create_utilisateur + ", annee=" + annee
				+ ", specialite=" + specialite + ", groupe=" + groupe + "]";
	}

	@Override
	public void Validate()
	{
	}
}
