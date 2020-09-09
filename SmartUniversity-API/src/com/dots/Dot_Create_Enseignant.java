package com.dots;

import javax.xml.bind.annotation.XmlRootElement;

import com.modele.Utilisateur.Code_Departement;

@XmlRootElement
public class Dot_Create_Enseignant implements IDot
{
	private Dot_Create_Utilisateur dot_Create_Utilisateur;
	private String grade;
	private Code_Departement code_departement;

	public Dot_Create_Enseignant()
	{

	}

	public Dot_Create_Enseignant(Dot_Create_Utilisateur dot_Create_Utilisateur, String grade,
			Code_Departement code_departement)
	{
		this.dot_Create_Utilisateur = dot_Create_Utilisateur;
		this.grade = grade;
		this.code_departement = code_departement;
	}

	public Dot_Create_Utilisateur getDot_Create_Utilisateur()
	{
		return dot_Create_Utilisateur;
	}

	public String getGrade()
	{
		return grade;
	}

	public Code_Departement getCode_departement()
	{
		return code_departement;
	}

	public void setDot_Create_Utilisateur(Dot_Create_Utilisateur dot_Create_Utilisateur)
	{
		this.dot_Create_Utilisateur = dot_Create_Utilisateur;
	}

	public void setGrade(String grade)
	{
		this.grade = grade;
	}

	public void setCode_departement(Code_Departement code_departement)
	{
		this.code_departement = code_departement;
	}

	@Override
	public void Validate()
	{
		dot_Create_Utilisateur.Validate();
	}
}
