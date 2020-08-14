package com.dots;

import java.util.ArrayList;

import javax.ws.rs.core.Response.Status;

import com.data.DAO_ChangementSeance;
import com.data.DAO_Enseignant;
import com.data.DAO_Seance;
import com.data.DAO_SeanceSupp;
import com.modele.Enseignant;
import com.modele.Seance;
import com.modele.Seance.Jour;
import com.modele.SeanceSupp;
import com.rest.exceptions.RequestNotValidException;
import com.utility.JsonReader;

public class Dot_Create_SeanceSupp implements IDot
{
	private String code_seance = null;
	private Jour jour;
	private String heure = null;
	
	public Dot_Create_SeanceSupp()
	{
	}
	
	public Dot_Create_SeanceSupp(String code_seance, Jour jour, String heure)
	{
		this.code_seance = code_seance;
		this.jour = jour;
		this.heure = heure;
	}

	public String getCode_seance()
	{
		return code_seance;
	}

	public Jour getJour()
	{
		return jour;
	}

	public String getHeure()
	{
		return heure;
	}

	public void setCode_seance(String code_seance)
	{
		this.code_seance = code_seance;
	}

	public void setJour(Jour jour)
	{
		this.jour = jour;
	}

	public void setHeure(String heure)
	{
		this.heure = heure;
	}

	@Override
	public void Validate()
	{
		//TODO ensure that the group / speciality / section exist

		Seance seance = DAO_Seance.GetSeanceByCode_Seance(code_seance);
		Enseignant enseignant = DAO_Enseignant.GetEnseignantBySeance(seance);		
		
		if(seance == null)
		{			
			throw new RequestNotValidException(Status.BAD_REQUEST,
					JsonReader.GetNode("session_not_exist"));
		}
		
		ArrayList<SeanceSupp> others = DAO_SeanceSupp.GetSeancesSupp(code_seance);
		
		if(seance.getJour().equals(jour) && seance.getHeure().equals(heure))
		{
			throw new RequestNotValidException(Status.BAD_REQUEST,
					JsonReader.GetNode("same_as_main"));
		}
		
		for (SeanceSupp seanceSupp : others)
		{
			if(seanceSupp.getJour().equals(jour) && seanceSupp.getHeure().equals(heure))
			{
				throw new RequestNotValidException(Status.BAD_REQUEST, 
						JsonReader.GetNode("additional_already_exist"));
			}
		}
		
		if(!DAO_Seance.IsEnseignantDisponible(enseignant.getId_utilisateur(), heure, jour))
		{
			throw new RequestNotValidException(Status.NOT_ACCEPTABLE, 
					JsonReader.GetNode("have_session"));
		}
		
		if(!DAO_ChangementSeance.IsEnseignantDisponible(enseignant.getId_utilisateur(), heure, jour))
		{
			throw new RequestNotValidException(Status.NOT_ACCEPTABLE, 
					JsonReader.GetNode("teacher_have_other_request"));
		}
		
		if(!DAO_SeanceSupp.IsEnseignantDisponible(enseignant.getId_utilisateur(), heure, jour))
		{
			throw new RequestNotValidException(Status.NOT_ACCEPTABLE, 
					JsonReader.GetNode("teacher_have_other_request"));
		}
		
		//TODO check if groupe is disponible
	}
}