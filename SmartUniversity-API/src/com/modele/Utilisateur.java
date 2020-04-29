package com.modele;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.persistence.Entity;
import javax.xml.bind.annotation.XmlRootElement;


@XmlRootElement
@Entity
public class Utilisateur
{
	public static final int MIN_PASS_LENGHT = 6;
	
	public enum Type_Utilisateur 
	{
		undefined,
		etudiant,
		enseignant,
		chefDepartement,
		responsableFormation,
		admin
	}
	
	public enum Code_Departement
	{
		MI,
		TLSI,
		IFA
	}
	
	protected int id_utilisateur = 0;
	protected String user = null;
	protected String pass = null;
	protected String nom = null;
	protected String prenom = null;
	protected String adresse = null;
	protected Date date_n = null;
	protected String email = null;
	protected String telephone = null;
	protected Type_Utilisateur type_utilisateur;
		
	public Utilisateur(int id_utilisateur, String user, String pass, String nom, String prenom, String adresse, Date date_n, String email,
			String telephone, Type_Utilisateur type_utilisateur)
	{
		this.id_utilisateur = id_utilisateur;
		this.user = user;
		this.pass = pass;
		this.nom = nom;
		this.prenom = prenom;
		this.adresse = adresse;
		this.date_n = date_n;
		this.email = email;
		this.telephone = telephone;
		this.type_utilisateur = type_utilisateur;
	}

	public Utilisateur() 
	{
		
	}

	public int getId_utilisateur()
	{
		return id_utilisateur;
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

	public Date getDate()
	{
		return date_n;
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

	public void setId_utilisateur(int id)
	{
		this.id_utilisateur = id;
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
		}	}

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
}
