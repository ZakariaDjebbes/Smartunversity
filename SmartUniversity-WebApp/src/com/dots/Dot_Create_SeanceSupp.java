package com.dots;

import com.modele.Seance.Jour;

public class Dot_Create_SeanceSupp
{
	private String code_seance = null;
	private Jour jour;
	private String heure = null;
	
	public Dot_Create_SeanceSupp()
	{
	}
	
	public Dot_Create_SeanceSupp(String code_seance, Jour jour, String heure)
	{
		this.code_seance = code_seance;
		this.jour = jour;
		this.heure = heure;
	}

	public String getCode_seance()
	{
		return code_seance;
	}

	public Jour getJour()
	{
		return jour;
	}

	public String getHeure()
	{
		return heure;
	}

	public void setCode_seance(String code_seance)
	{
		this.code_seance = code_seance;
	}

	public void setJour(Jour jour)
	{
		this.jour = jour;
	}

	public void setHeure(String heure)
	{
		this.heure = heure;
	}
}