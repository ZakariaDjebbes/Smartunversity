package com.dots;

import javax.ws.rs.core.Response.Status;
import javax.xml.bind.annotation.XmlRootElement;

import com.data.DAO_Enseignant;
import com.data.DAO_Seance;
import com.rest.exceptions.RequestNotValidException;
import com.utility.JsonReader;

@XmlRootElement
public class Dot_Affecter_Seance implements IDot
{
	private String code_seance = null;
	private int id_enseignant = 0;
	
	public Dot_Affecter_Seance()
	{
		
	}
	
	public Dot_Affecter_Seance(String code_seance, int id_enseignant)
	{
		this.code_seance = code_seance;
		this.id_enseignant = id_enseignant;
	}

	public String getCode_seance()
	{
		return code_seance;
	}

	public int getId_enseignant()
	{
		return id_enseignant;
	}

	public void setCode_seance(String code_seance)
	{
		this.code_seance = code_seance;
	}

	public void setId_enseignant(int id_enseignant)
	{
		this.id_enseignant = id_enseignant;
	}

	@Override
	public void Validate()
	{
		//s'assurer que l'enseignant et la seance existent
		
		if(DAO_Enseignant.GetEnseignantById(id_enseignant) == null)
		{
			throw new RequestNotValidException(Status.BAD_REQUEST, JsonReader.GetNode("teacher_not_exist"));
		}
		
		if(DAO_Seance.GetSeanceByCode_Seance(code_seance) == null)
		{
			throw new RequestNotValidException(Status.BAD_REQUEST, JsonReader.GetNode("session_not_exist"));			
		}
		
		//s'assurer que l'enseignant est libre pour ce jour et cet heure
		
		if(!DAO_Enseignant.IsEnseignantLibre(id_enseignant, code_seance))
		{
			throw new RequestNotValidException(Status.BAD_REQUEST, JsonReader.GetNode("teacher_unavailable_day_hour"));
		}
	}
}
