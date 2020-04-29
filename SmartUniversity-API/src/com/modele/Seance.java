package com.modele;

import javax.persistence.Entity;
import javax.xml.bind.annotation.XmlRootElement;

import com.modele.Etudiant.Annee;
import com.modele.Etudiant.Specialite;

@XmlRootElement
@Entity
public class Seance
{
	public enum Type_Seance
	{
		TD,
		TP
	}
	
	public enum Jour
	{
		dimanche,
		lundi,
		mardi,
		mercredi,
		jeudi
	}
	
	public enum Etat_Seance
	{
		valide,
		refuse,
		nonTraite
	}
	
	private String code_seance = null;
	private String code_module = null;
	private Type_Seance type;
	private Annee annee;
	private Specialite specialite;
	private int section = 0;
	private int groupe = 0;
	private Jour jour;
	private String heure = null;
	private Etat_Seance etat_seance;

	public Seance()
	{
		
	}

	public Seance(String code_seance, String code_module, Type_Seance type, Annee annee, Specialite specialite,
			int section, int groupe, Jour jour, String heure, Etat_Seance etat_seance)
	{
		this.code_seance = code_seance;
		this.code_module = code_module;
		this.type = type;
		this.annee = annee;
		this.specialite = specialite;
		this.section = section;
		this.groupe = groupe;
		this.jour = jour;
		this.heure = heure;
		this.etat_seance = etat_seance;
	}

	public String getCode_seance()
	{
		return code_seance;
	}

	public String getCode_module()
	{
		return code_module;
	}

	public Type_Seance getType()
	{
		return type;
	}

	public int getSection()
	{
		return section;
	}

	public int getGroupe()
	{
		return groupe;
	}

	public Jour getJour()
	{
		return jour;
	}

	public String getHeure()
	{
		return heure;
	}

	public Etat_Seance getEtat_seance()
	{
		return etat_seance;
	}

	public void setCode_seance(String code_seance)
	{
		this.code_seance = code_seance;
	}

	public void setCode_module(String code_module)
	{
		this.code_module = code_module;
	}

	public void setType(Type_Seance type)
	{
		this.type = type;
	}

	public void setSection(int section)
	{
		this.section = section;
	}

	public void setGroupe(int groupe)
	{
		this.groupe = groupe;
	}

	public void setJour(Jour jour)
	{
		this.jour = jour;
	}

	public void setHeure(String heure)
	{
		this.heure = heure;
	}

	public void setEtat_seance(Etat_Seance etat_seance)
	{
		this.etat_seance = etat_seance;
	}

	public Annee getAnnee()
	{
		return annee;
	}

	public Specialite getSpecialite()
	{
		return specialite;
	}

	public void setAnnee(Annee annee)
	{
		this.annee = annee;
	}

	public void setSpecialite(Specialite specialite)
	{
		this.specialite = specialite;
	}
}
