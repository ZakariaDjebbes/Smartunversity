package com.modele;

import javax.persistence.Entity;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
@Entity
public class Enseignant extends Utilisateur
{
	private String grade = null;

	public Enseignant()
	{

	}
	
	public Enseignant(String grade)
	{
		this.grade = grade;
	}

	public Enseignant(Utilisateur utilisateur, String grade)
	{
		super(utilisateur.id, utilisateur.user, utilisateur.pass, utilisateur.nom, utilisateur.prenom,
				utilisateur.adresse, utilisateur.date_n, utilisateur.email, utilisateur.telephone,
				utilisateur.type_utilisateur, utilisateur.code_departement);
		this.grade = grade;
	}

	public String getGrade()
	{
		return grade;
	}

	public void setGrade(String grade)
	{
		this.grade = grade;
	}
}
