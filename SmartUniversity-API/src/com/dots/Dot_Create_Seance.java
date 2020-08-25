package com.dots;

import javax.ws.rs.core.Response.Status;

import com.data.DAO_Module;
import com.data.DAO_Seance;
import com.modele.Etudiant.Annee;
import com.modele.Etudiant.Specialite;
import com.modele.Seance.Jour;
import com.modele.Seance.Type_Seance;
import com.rest.exceptions.RequestNotValidException;
import com.utility.JsonReader;

public class Dot_Create_Seance implements IDot
{
	private String code_module;
	private Jour jour;
	private String heure;
	private Annee annee;
	private Specialite specialite;
	private int groupe;
	private Type_Seance type_seance;
	
	public Dot_Create_Seance()
	{
	}
	
	public Dot_Create_Seance(String code_module, Jour jour, String heure, Annee annee, Specialite specialite, int groupe,
			Type_Seance type_seance)
	{
		this.code_module = code_module;
		this.jour = jour;
		this.heure = heure;
		this.annee = annee;
		this.specialite = specialite;
		this.groupe = groupe;
		this.type_seance = type_seance;
	}

	public String getCode_module()
	{
		return code_module;
	}

	public Jour getJour()
	{
		return jour;
	}

	public String getHeure()
	{
		return heure;
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

	public Type_Seance getType_seance()
	{
		return type_seance;
	}

	public void setCode_module(String code_module)
	{
		this.code_module = code_module;
	}

	public void setJour(Jour jour)
	{
		this.jour = jour;
	}

	public void setHeure(String heure)
	{
		this.heure = heure;
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

	public void setType_seance(Type_Seance type_seance)
	{
		this.type_seance = type_seance;
	}

	@Override
	public void Validate()
	{
		if(DAO_Module.GetMouleByCode(code_module) == null)
		{
			throw new RequestNotValidException(Status.BAD_REQUEST, JsonReader.GetNode("module_not_exist"));
		}
		
		if(!DAO_Seance.IsSeanceDisponible(jour, heure, groupe, annee, specialite))
		{
			throw new RequestNotValidException(Status.BAD_REQUEST, JsonReader.GetNode("session_occupied"));
		}
	}
}
