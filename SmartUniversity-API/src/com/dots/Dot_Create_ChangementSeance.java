package com.dots;

import javax.ws.rs.core.Response.Status;
import javax.xml.bind.annotation.XmlRootElement;

import com.data.DAO_ChangementSeance;
import com.data.DAO_Enseignant;
import com.data.DAO_Seance;
import com.data.DAO_SeanceSupp;
import com.modele.Enseignant;
import com.modele.Seance;
import com.modele.Seance.Jour;
import com.rest.exceptions.RequestNotValidException;
import com.utility.JsonReader;
import com.utility.Utility;

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
		Seance seance = DAO_Seance.GetSeanceByCode_Seance(code_seance);
		Enseignant enseignant = DAO_Enseignant.GetEnseignantBySeance(seance);
		
		if(DAO_ChangementSeance.GetChangementSeance(code_seance) != null)
		{
			throw new RequestNotValidException(Status.BAD_REQUEST, 
					JsonReader.GetNode("change_request_exist"));
		}
		
		if(!Utility.IsInEnum(String.valueOf(nouveau_jour), Jour.class))
		{
			throw new RequestNotValidException(Status.BAD_REQUEST, 
					JsonReader.GetNode("day_incorrect"));
		}
		
		if(!Utility.HourExists(nouvelle_heure))
		{
			throw new RequestNotValidException(Status.BAD_REQUEST, 
					JsonReader.GetNode("hour_incorrect"));
		}
		
		if(seance.getJour().equals(nouveau_jour) && seance.getHeure().equals(nouvelle_heure))
		{
			throw new RequestNotValidException(Status.BAD_REQUEST, 
					JsonReader.GetNode("change_either_day_hour"));
		}
		
		if(!DAO_Seance.IsEnseignantDisponible(enseignant.getId_utilisateur(), nouvelle_heure, nouveau_jour))
		{
			throw new RequestNotValidException(Status.NOT_ACCEPTABLE, 
					JsonReader.GetNode("have_session"));
		}
		
		if(!DAO_ChangementSeance.IsEnseignantDisponible(enseignant.getId_utilisateur(), nouvelle_heure, nouveau_jour))
		{
			throw new RequestNotValidException(Status.NOT_ACCEPTABLE, 
					JsonReader.GetNode("teacher_have_other_request"));
		}
		
		if(!DAO_SeanceSupp.IsEnseignantDisponible(enseignant.getId_utilisateur(), nouvelle_heure, nouveau_jour))
		{
			throw new RequestNotValidException(Status.NOT_ACCEPTABLE, 
					JsonReader.GetNode("teacher_have_other_request"));
		}
		
		if(!DAO_Seance.IsSeanceDisponible(nouveau_jour, nouvelle_heure, seance.getGroupe(), seance.getAnnee(), seance.getSpecialite()))
		{
			throw new RequestNotValidException(Status.BAD_REQUEST, JsonReader.GetNode("session_occupied"));
		}	}
}
