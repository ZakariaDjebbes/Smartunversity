package com.modele;

import javax.persistence.Entity;
import javax.xml.bind.annotation.XmlRootElement;

import com.modele.Seance.Etat_Demande;
import com.modele.Seance.Jour;

@XmlRootElement
@Entity
public class SeanceSupp
{
	private String code_seance = null;
	private int code_seance_supp;
	private Jour jour;
	private String heure = null;
	private Etat_Demande etat_seance;
	
	public SeanceSupp()
	{
	}
	
	public SeanceSupp(String code_seance, int code_seance_supp, Jour jour, String heure, Etat_Demande etat_seance)
	{
		this.code_seance = code_seance;
		this.code_seance_supp = code_seance_supp;
		this.jour = jour;
		this.heure = heure;
		this.etat_seance = etat_seance;
	}

	public String getCode_seance()
	{
		return code_seance;
	}

	public int getCode_seance_supp()
	{
		return code_seance_supp;
	}

	public Jour getJour()
	{
		return jour;
	}

	public String getHeure()
	{
		return heure;
	}

	public Etat_Demande getEtat_seance()
	{
		return etat_seance;
	}

	public void setCode_seance(String code_seance)
	{
		this.code_seance = code_seance;
	}

	public void setCode_seance_supp(int code_seance_supp)
	{
		this.code_seance_supp = code_seance_supp;
	}

	public void setJour(Jour jour)
	{
		this.jour = jour;
	}

	public void setHeure(String heure)
	{
		this.heure = heure;
	}

	public void setEtat_seance(Etat_Demande etat_seance)
	{
		this.etat_seance = etat_seance;
	}
}
