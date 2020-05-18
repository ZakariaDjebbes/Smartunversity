package com.dots;

import java.util.ArrayList;

import javax.ws.rs.core.Response.Status;

import com.data.DAO_Seance;
import com.data.DAO_SeanceSupp;
import com.helpers.RequestReponse;
import com.modele.Seance;
import com.modele.Seance.Jour;
import com.modele.SeanceSupp;
import com.rest.exceptions.RequestNotValidException;

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
		if(DAO_Seance.GetSeanceByCode_Seance(code_seance) == null)
		{			
			throw new RequestNotValidException(Status.BAD_REQUEST, new RequestReponse("Cannot create additional seances for a non existing seance"));
		}
		
		Seance seance = DAO_Seance.GetSeanceByCode_Seance(code_seance);
		ArrayList<SeanceSupp> others = DAO_SeanceSupp.GetSeancesSupp(code_seance);
		
		if(seance.getJour().equals(jour) && seance.getHeure().equals(heure))
		{
			throw new RequestNotValidException(Status.BAD_REQUEST, new RequestReponse("Cannot create additional seances with the same hour and day of its main seance"));
		}
		
		for (SeanceSupp seanceSupp : others)
		{
			if(seanceSupp.getJour().equals(jour) && seanceSupp.getHeure().equals(heure))
			{
				throw new RequestNotValidException(Status.BAD_REQUEST, new RequestReponse("An additional seance with this day and this hour for this seance already exists"));
			}
		}
	}
}