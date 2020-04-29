package com.modele;

import javax.persistence.Entity;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
@Entity
public class Enseignant extends Utilisateur
{
	private String grade = null;
	private Code_Departement code_departement;
	
	public Enseignant()
	{

	}
	
	public Enseignant(String grade, Code_Departement code_departement)
	{
		this.grade = grade;
		this.code_departement = code_departement;
	}

	public Enseignant(Utilisateur utilisateur, String grade, Code_Departement code_departement)
	{
		super(utilisateur.id_utilisateur, utilisateur.user, utilisateur.pass, utilisateur.nom, utilisateur.prenom,
				utilisateur.adresse, utilisateur.date_n, utilisateur.email, utilisateur.telephone,
				utilisateur.type_utilisateur);
		this.grade = grade;
		this.code_departement = code_departement;
	}

	public String getGrade()
	{
		return grade;
	}

	public void setGrade(String grade)
	{
		this.grade = grade;
	}

	public Code_Departement getCode_departement()
	{
		return code_departement;
	}

	public void setCode_departement(Code_Departement code_departement)
	{
		this.code_departement = code_departement;
	}

	@Override
	public String toString()
	{
		return "Enseignant [grade=" + grade + ", code_departement=" + code_departement + ", id=" + id_utilisateur + ", user=" + user
				+ ", pass=" + pass + ", nom=" + nom + ", prenom=" + prenom + ", adresse=" + adresse + ", date_n="
				+ date_n + ", email=" + email + ", telephone=" + telephone + ", type_utilisateur=" + type_utilisateur
				+ "]";
	}
}
