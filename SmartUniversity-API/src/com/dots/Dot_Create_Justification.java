package com.dots;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.ws.rs.core.Response.Status;
import javax.xml.bind.annotation.XmlRootElement;

import com.data.DAO_Absence;
import com.helpers.RequestReponse;
import com.rest.exceptions.RequestNotValidException;

@XmlRootElement
public class Dot_Create_Justification implements IDot
{
	private int numero_absence = 0;
	private Date date_justification = null;

	public Dot_Create_Justification()
	{
		
	}
	
	public Dot_Create_Justification(int numero_absence, Date date_justification)
	{
		this.numero_absence = numero_absence;
		this.date_justification = date_justification;
	}

	public int getNumero_absence()
	{
		return numero_absence;
	}

	public Date getDate_justification()
	{
		return date_justification;
	}

	public void setNumero_absence(int numero_absence)
	{
		this.numero_absence = numero_absence;
	}
	
	public void setDate_justification(String date_justification)
	{
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		try
		{
			this.date_justification = formatter.parse(date_justification);
		}
		catch (ParseException e)
		{
			e.printStackTrace();
		}		
	}
	
	@Override
	public String toString()
	{
		return "Dot_Create_Justification [numero_absence=" + numero_absence + ", date_justification="
				+ date_justification + "]";
	}

	@Override
	public void Validate()
	{
		//TODO 1 justification per absence?
		
		if(DAO_Absence.GetAbsenceByNumero(numero_absence) == null)
		{
			throw new RequestNotValidException(Status.BAD_REQUEST, new RequestReponse(
					"Cannot find an absence with this id"));
		}
	}
}
