package com.dots;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class Dot_Create_CongeAcademique
{
	private int id_etudiant;
	private String extension = null;

	public Dot_Create_CongeAcademique()
	{
		
	}
	
	public Dot_Create_CongeAcademique(int id_etudiant, String extension)
	{
		this.id_etudiant = id_etudiant;
		this.extension = extension;
	}

	public int getId_etudiant()
	{
		return id_etudiant;
	}

	public String getExtension()
	{
		return extension;
	}

	public void setId_etudiant(int id_etudiant)
	{
		this.id_etudiant = id_etudiant;
	}

	public void setExtension(String extension)
	{
		this.extension = extension;
	}
}
