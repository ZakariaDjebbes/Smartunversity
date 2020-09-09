package com.dots;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.ws.rs.core.Response.Status;
import javax.xml.bind.annotation.XmlRootElement;

import com.data.DAO_User;
import com.jsonReaders.MessageReader;
import com.modele.Utilisateur.Type_Utilisateur;
import com.rest.exceptions.RequestNotValidException;

@XmlRootElement
public class Dot_Create_Utilisateur implements IDot
{
	private String nom;
	private String prenom;
	private String email;
	private Date date_n;
	private String telephone;
	private String adresse;
	private Type_Utilisateur type_utilisateur;
	
	public Dot_Create_Utilisateur()
	{
		
	}

	public Dot_Create_Utilisateur(String nom, String prenom, String email, Date date_n, String telephone,
			String adresse, Type_Utilisateur type_utilisateur)
	{
		this.nom = nom;
		this.prenom = prenom;
		this.email = email;
		this.date_n = date_n;
		this.telephone = telephone;
		this.adresse = adresse;
		this.type_utilisateur = type_utilisateur;
	}

	public String getNom()
	{
		return nom;
	}

	public String getPrenom()
	{
		return prenom;
	}

	public String getEmail()
	{
		return email;
	}

	public Date getDate()
	{
		return date_n;
	}

	public String getTelephone()
	{
		return telephone;
	}

	public String getAdresse()
	{
		return adresse;
	}

	public void setNom(String nom)
	{
		this.nom = nom;
	}

	public void setPrenom(String prenom)
	{
		this.prenom = prenom;
	}

	public void setEmail(String email)
	{
		this.email = email;
	}

	public void setDate(String date)
	{
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		try
		{
			this.date_n = formatter.parse(date);
		}
		catch (ParseException e)
		{
			e.printStackTrace();
		}	
	}

	public void setTelephone(String telephone)
	{
		this.telephone = telephone;
	}

	public void setAdresse(String adresse)
	{
		this.adresse = adresse;
	}
	
	public Type_Utilisateur getUser_type()
	{
		return type_utilisateur;
	}

	public void setUser_type(Type_Utilisateur user_type)
	{
		this.type_utilisateur = user_type;
	}
	
	@Override
	public String toString()
	{
		return "Dot_Create_Utilisateur [nom=" + nom + ", prenom=" + prenom + ", email=" + email + ", date_n=" + date_n
				+ ", telephone=" + telephone + ", adresse=" + adresse + ", type_utilisateur=" + type_utilisateur + "]";
	}

	@Override
	public void Validate()
	{
		if(DAO_User.EmailExists(email))
		{
			throw new RequestNotValidException(Status.BAD_REQUEST, MessageReader.GetNode("change_email"));
		}
	}
}
