package com.modele;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.persistence.Entity;
import javax.xml.bind.annotation.XmlRootElement;

import com.utility.Utility;

@XmlRootElement
@Entity
public class Utilisateur
{
	public enum Type_Utilisateur
	{
		etudiant, enseignant, chefDepartement, responsableFormation, admin
	}

	public enum Code_Departement
	{
		MI, TLSI, IFA
	}

	protected int id = 0;
	protected String user = null;
	protected String pass = null;
	protected String nom = null;
	protected String prenom = null;
	protected String adresse = null;
	protected Date date_n = null;
	protected String email = null;
	protected String telephone = null;
	protected Type_Utilisateur type_utilisateur;
	protected Code_Departement code_departement = null;
	
	public Utilisateur(int id, String user, String pass, String nom, String prenom, String adresse, Date date_n,
			String email, String telephone, Type_Utilisateur type_utilisateur, Code_Departement code_departement)
	{
		this.id = id;
		this.user = user;
		this.pass = pass;
		this.nom = nom;
		this.prenom = prenom;
		this.adresse = adresse;
		this.date_n = date_n;
		this.email = email;
		this.telephone = telephone;
		this.type_utilisateur = type_utilisateur;
		this.code_departement = code_departement;
	}

	public Utilisateur()
	{

	}

	public int getId()
	{
		return id;
	}

	public String getUser()
	{
		return user;
	}

	public String getPass()
	{
		return pass;
	}

	public String getNom()
	{
		return nom;
	}

	public String getPrenom()
	{
		return prenom;
	}

	public String getAdresse()
	{
		return adresse;
	}

	public String getDate()
	{
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		formatter.applyPattern("yyyy-MM-dd");
		return formatter.format(date_n);
	}

	public String getEmail()
	{
		return email;
	}

	public String getTelephone()
	{
		return telephone;
	}

	public Type_Utilisateur getUser_type()
	{
		return type_utilisateur;
	}

	public Code_Departement getCode_departement()
	{
		return code_departement;
	}

	public void setId(int id)
	{
		this.id = id;
	}

	public void setUser(String user)
	{
		this.user = user;
	}

	public void setPass(String pass)
	{
		this.pass = pass;
	}

	public void setNom(String nom)
	{
		this.nom = nom;
	}

	public void setPrenom(String prenom)
	{
		this.prenom = prenom;
	}

	public void setAdresse(String adresse)
	{
		this.adresse = adresse;
	}

	public void setDate(String date)
	{
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		try
		{
			this.date_n = formatter.parse(date);
		} catch (ParseException e)
		{
			e.printStackTrace();
		}
	}

	public void setEmail(String email)
	{
		this.email = email;
	}

	public void setTelephone(String telephone)
	{
		this.telephone = telephone;
	}

	public void setUser_type(Type_Utilisateur user_type)
	{
		this.type_utilisateur = user_type;
	}

	public void setCode_departement(Code_Departement code_departement)
	{
		this.code_departement = code_departement;
	}

	@Override
	public String toString()
	{
		return "Utilisateur [id=" + id + ", user=" + user + ", pass=" + pass + ", nom=" + nom + ", prenom=" + prenom
				+ ", adresse=" + adresse + ", date_n=" + date_n + ", email=" + email + ", telephone=" + telephone
				+ ", type_utilisateur=" + type_utilisateur + ", code_departement=" + code_departement + "]";
	}
	
	@Override
	public boolean equals(Object obj)
	{
		if(obj == this)
		{
			return true;
		}
		if(obj == null)
		{
			return false;
		}
		
		Utilisateur other = (Utilisateur)obj;
		
		if(user.equals(other.user) && pass.equals(other.pass) && nom.equals(other.nom) && prenom.equals(other.prenom) 
				&& adresse.equals(other.adresse) && email.equals(other.email) && code_departement.equals(other.code_departement)
				&& telephone.equals(other.telephone) && Utility.SameDate(date_n, other.date_n)) 
		{
			return true;
		}
		return false;
	}
}
