package com.dots;

import javax.xml.bind.annotation.XmlRootElement;

import com.modele.Etudiant.Annee;
import com.modele.Etudiant.Specialite;
import com.modele.Seance.Jour;
import com.modele.Seance.Type_Seance;

@XmlRootElement
public class Dot_Create_Seance
{
	private String code_module = null;
	private Type_Seance type;
	private Annee annee;
	private Specialite specialite;
	private int section = 0;
	private int groupe = 0;
	private Jour jour;
	private String heure = null;
	private int id_enseignant = 0;
	
	public Dot_Create_Seance()
	{

	}

	public Dot_Create_Seance(String code_module, Type_Seance type, Annee annee, Specialite specialite, int section,
			int groupe, Jour jour, String heure, int id_enseignant)
	{
		this.code_module = code_module;
		this.type = type;
		this.annee = annee;
		this.specialite = specialite;
		this.section = section;
		this.groupe = groupe;
		this.jour = jour;
		this.heure = heure;
		this.id_enseignant = id_enseignant;
	}

	public String getCode_module()
	{
		return code_module;
	}

	public Type_Seance getType()
	{
		return type;
	}

	public Annee getAnnee()
	{
		return annee;
	}

	public Specialite getSpecialite()
	{
		return specialite;
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

	public void setCode_module(String code_module)
	{
		this.code_module = code_module;
	}

	public void setType(Type_Seance type)
	{
		this.type = type;
	}

	public void setAnnee(Annee annee)
	{
		this.annee = annee;
	}

	public void setSpecialite(Specialite specialite)
	{
		this.specialite = specialite;
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
	
	public int getId_enseignant()
	{
		return id_enseignant;
	}

	public void setId_enseignant(int id_enseignant)
	{
		this.id_enseignant = id_enseignant;
	}
}
