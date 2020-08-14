package com.modele;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.persistence.Entity;
import javax.xml.bind.annotation.XmlRootElement;

@Entity
@XmlRootElement
public class ChefDepartement extends Enseignant
{
	private Date date_nomination = null;
	
	public ChefDepartement()
	{
		
	}
	
	public ChefDepartement(Utilisateur utilisateur, Enseignant enseignant, Date date_nomination)
	{
		super(utilisateur, enseignant.grade, enseignant.code_departement);
		this.date_nomination = date_nomination;
	}

	public String getDate_nomination()
	{
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		formatter.applyPattern("yyyy-MM-dd");
		return formatter.format(date_nomination);	
	}

	public void setDate_nomination(String date_nomination)
	{
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		try
		{
			this.date_nomination = formatter.parse(date_nomination);
		} catch (ParseException e)
		{
			e.printStackTrace();
		}
	}
}
