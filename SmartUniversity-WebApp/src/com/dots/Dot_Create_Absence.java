package com.dots;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Dot_Create_Absence
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
}
