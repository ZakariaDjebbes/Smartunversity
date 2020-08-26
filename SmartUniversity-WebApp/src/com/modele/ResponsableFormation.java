package com.modele;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.persistence.Entity;
import javax.xml.bind.annotation.XmlRootElement;

import com.modele.Etudiant.Annee;
import com.modele.Etudiant.Specialite;

@Entity
@XmlRootElement
public class ResponsableFormation extends Enseignant
{
	private Date date_nomination = null;
	private Annee annee;
	private Specialite specialite;
	
	public ResponsableFormation()
	{
		
	}
	
	public ResponsableFormation(Utilisateur utilisateur, Enseignant enseignant, Date date_nomination, Annee annee, Specialite specialite)
	{
		super(utilisateur, enseignant.grade, enseignant.code_departement);
		this.date_nomination = date_nomination;
		this.annee = annee;
		this.specialite = specialite;
	}
	
	public Annee getAnnee()
	{
		return annee;
	}

	public Specialite getSpecialite()
	{
		return specialite;
	}

	public void setAnnee(Annee annee)
	{
		this.annee = annee;
	}

	public void setSpecialite(Specialite specialite)
	{
		this.specialite = specialite;
	}

	public Date getDate_nomination()
	{
		return date_nomination;
	}

	public void setDate_nomination(String date_nomination)
	{
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		try
		{
			this.date_n = formatter.parse(date_nomination);
		}
		catch (ParseException e)
		{
			e.printStackTrace();
		}
	}
}
