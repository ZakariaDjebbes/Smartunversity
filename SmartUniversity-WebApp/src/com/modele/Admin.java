package com.modele;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.persistence.Entity;
import javax.xml.bind.annotation.XmlRootElement;

@Entity
@XmlRootElement
public class Admin extends Utilisateur
{
	protected Date date_nomination;
	
	public Admin()
	{

	}
	
	public Admin(Date date_nomination)
	{
		this.date_nomination = date_nomination;
	}

	public Admin(Utilisateur utilisateur, Date date_nomination)
	{
		super(utilisateur.id_utilisateur, utilisateur.user, utilisateur.pass, utilisateur.nom, utilisateur.prenom,
				utilisateur.adresse, utilisateur.date_n, utilisateur.email, utilisateur.telephone,
				utilisateur.type_utilisateur);
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
