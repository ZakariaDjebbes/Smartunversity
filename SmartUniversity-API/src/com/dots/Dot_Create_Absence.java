package com.dots;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.ws.rs.core.Response.Status;
import javax.xml.bind.annotation.XmlRootElement;

import com.data.DAO_Etudiant;
import com.data.DAO_Seance;
import com.modele.Etudiant;
import com.modele.Etudiant.Etat_Etudiant;
import com.rest.exceptions.RequestNotValidException;
import com.utility.JsonReader;

@XmlRootElement
public class Dot_Create_Absence implements IDot
{
	private String code_seance = null;
	private int id_etudiant = 0;
	private Date date_absence = null;
	
	public Dot_Create_Absence(String code_seance, int id_etudiant, Date date)
	{
		this.code_seance = code_seance;
		this.id_etudiant = id_etudiant;
		this.date_absence = date;
	}
	
	public Dot_Create_Absence()
	{
		
	}

	public String getCode_seance()
	{
		return code_seance;
	}

	public int getId_etudiant()
	{
		return id_etudiant;
	}

	public Date getDate_absence()
	{
		return date_absence;
	}

	public void setCode_seance(String code_seance)
	{
		this.code_seance = code_seance;
	}

	public void setId_etudiant(int id_etudiant)
	{
		this.id_etudiant = id_etudiant;
	}

	public void setDate_absence(String date_absence)
	{
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		try
		{
			this.date_absence = formatter.parse(date_absence);
		}
		catch (ParseException e)
		{
			e.printStackTrace();
		}		
	}

	@Override
	public void Validate()
	{
		Etudiant etudiant = DAO_Etudiant.GetEtudiantById(id_etudiant);
		
		if(DAO_Seance.GetSeanceByCode_Seance(code_seance) == null)
		{
			throw new RequestNotValidException(Status.BAD_REQUEST, JsonReader.GetNode("session_not_exist"));			
		}
		
		if(etudiant == null)
		{
			throw new RequestNotValidException(Status.BAD_REQUEST, JsonReader.GetNode("student_not_exist"));			
		}
		
		if(etudiant.getEtat_etudiant() == Etat_Etudiant.bloque)
		{
			throw new RequestNotValidException(Status.BAD_REQUEST, JsonReader.GetNode("student_blocked"));			
		}
	}
}
