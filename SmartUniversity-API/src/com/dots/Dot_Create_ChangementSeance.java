package com.dots;

import javax.ws.rs.core.Response.Status;
import javax.xml.bind.annotation.XmlRootElement;

import com.data.DAO_ChangementSeance;
import com.data.DAO_Seance;
import com.helpers.RequestReponse;
import com.helpers.Utility;
import com.modele.Seance;
import com.modele.Seance.Jour;
import com.rest.exceptions.RequestNotValidException;

@XmlRootElement
public class Dot_Create_ChangementSeance implements IDot
{
	private String code_seance = null;
	private Jour nouveau_jour = null;
	private String nouvelle_heure = null;
	
	public Dot_Create_ChangementSeance(String code_seance, Jour nouveau_jour, String nouvelle_heure)
	{
		this.nouveau_jour = nouveau_jour;
		this.nouvelle_heure = nouvelle_heure;
		this.code_seance = code_seance;
	}
	
	public Dot_Create_ChangementSeance()
	{
		
	}
	
	public String getCode_seance()
	{
		return code_seance;
	}

	public Jour getNouveau_jour()
	{	
		return nouveau_jour;
	}

	public String getNouvelle_heure()
	{
		return nouvelle_heure;
	}

	public void setCode_seance(String code_seance)
	{
		this.code_seance = code_seance;
	}

	public void setNouveau_jour(Jour nouveau_jour)
	{
		this.nouveau_jour = nouveau_jour;
	}

	public void setNouvelle_heure(String nouvelle_heure)
	{
		this.nouvelle_heure = nouvelle_heure;
	}

	@Override
	public void Validate()
	{
		// the two new values cannot be the same as the older ones and they must exist in enums and a seance can only have 1 changement
		Seance seance = DAO_Seance.GetSeanceByCode_Seance(code_seance);
		
		if(DAO_ChangementSeance.GetChangementSeance(code_seance) != null)
		{
			throw new RequestNotValidException(Status.BAD_REQUEST, new RequestReponse(
					"A changement demand already exists for this seance"));
		}
		
		if(!Utility.IsInEnum(String.valueOf(nouveau_jour), Jour.class))
		{
			throw new RequestNotValidException(Status.BAD_REQUEST, new RequestReponse(
					"The new day given is incorrect"));
		}
		
		if(!Utility.HourExists(nouvelle_heure))
		{
			throw new RequestNotValidException(Status.BAD_REQUEST, new RequestReponse(
					"The new hour given is incorrect"));
		}
		
		if(seance.getJour().equals(nouveau_jour) && seance.getHeure().equals(nouvelle_heure))
		{
			throw new RequestNotValidException(Status.BAD_REQUEST, new RequestReponse(
					"A change must be made to atleast one of the following values: {nouveau_jour, nouvelle_heure}"));
		}
	}
}
