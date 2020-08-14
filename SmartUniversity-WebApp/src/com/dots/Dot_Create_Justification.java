package com.dots;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class Dot_Create_Justification
{
	private int numero_absence = 0;
	private Date date_justification = null;
	private String extension = null;

	public Dot_Create_Justification()
	{
		
	}
	
	public Dot_Create_Justification(int numero_absence, Date date_justification, String extension)
	{
		this.numero_absence = numero_absence;
		this.date_justification = date_justification;
		this.extension = extension;
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
	
	public String getExtension()
	{
		return extension ;
	}

	public void setExtension(String extension)
	{
		this.extension = extension;
	}
	
	@Override
	public String toString()
	{
		return "Dot_Create_Justification [numero_absence=" + numero_absence + ", date_justification="
				+ date_justification + "]";
	}
}
