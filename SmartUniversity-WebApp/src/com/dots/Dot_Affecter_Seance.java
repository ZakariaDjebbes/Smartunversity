package com.dots;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class Dot_Affecter_Seance
{
	private String code_seance = null;
	private int id_enseignant = 0;
	
	public Dot_Affecter_Seance()
	{
		
	}
	
	public Dot_Affecter_Seance(String code_seance, int id_enseignant)
	{
		this.code_seance = code_seance;
		this.id_enseignant = id_enseignant;
	}

	public String getCode_seance()
	{
		return code_seance;
	}

	public int getId_enseignant()
	{
		return id_enseignant;
	}

	public void setCode_seance(String code_seance)
	{
		this.code_seance = code_seance;
	}

	public void setId_enseignant(int id_enseignant)
	{
		this.id_enseignant = id_enseignant;
	}
}
