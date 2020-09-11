package com.modele;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.persistence.Entity;
import javax.xml.bind.annotation.XmlRootElement;

import com.utility.Utility;

@XmlRootElement
@Entity
public class Utilisateur
{
	/***
	 * @author Zaki
	 *Values are by default setup to be in this order ("FRENCH", "ENGLISH", "ARABIC")
	 */
	public enum Type_Utilisateur
	{
		etudiant("Étudiant", "Student", "PLACE HOLDER"),
		enseignant("Enseignant", "Teacher", "PLACE HOLDER"), 
		chefDepartement("Chef de département", "Head of Department", "PLACE HOLDER"),
		responsableFormation("Responsable de formation", "Training Manager", "PLACE HOLDER"), 
		admin("Administrateur", "Administrator", "PLACE HOLDER");

		private final List<String> values;
		
		Type_Utilisateur(String... values)
		{
			this.values = Arrays.asList(values);
		}

		public List<String> getValues()
		{
			return values;
		}
		
		public String getValue(int index)
		{
			return values.get(index);
		}
		
		public String getValue(String lang)
		{
			switch (lang)
			{
			case "fr":
				return values.get(0);

			case "en":
				return values.get(1);
				
			default:
				return values.get(1);
			}
		}
	}

	/***
	 * @author Zaki
	 *Values are by default setup to be in this order ("FRENCH", "ENGLISH", "ARABIC")
	 */
	public enum Code_Departement
	{
		MI("Tronc commun mathématiques et informatique", "Common core mathematics and computer science", "PLACE HOLDER"), 
		TLSI("Technologies des Logiciels et des Systèmes d'information", "Software and Information Systems Technologies", "PLACE HOLDER"), 
		IFA("Informatique Fondamentale et ses Applications", "Fundamental Computing and its Applications", "PLACE HOLDER");
		
		private final List<String> values;
		
		Code_Departement(String... values)
		{
			this.values = Arrays.asList(values);
		}

		public List<String> getValues()
		{
			return values;
		}
		
		public String getValue(int index)
		{
			return values.get(index);
		}
		
		public String getValue(String lang)
		{
			switch (lang)
			{
			case "fr":
				return values.get(0);

			case "en":
				return values.get(1);
				
			default:
				return values.get(1);
			}
		}
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

	public Utilisateur(int id_utilisateur, String user, String pass, String nom, String prenom, String adresse,
			Date date_n, String email, String telephone, Type_Utilisateur type_utilisateur)
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

	@Override
	public String toString()
	{
		return "Utilisateur [id=" + id_utilisateur + ", user=" + user + ", pass=" + pass + ", nom=" + nom + ", prenom="
				+ prenom + ", adresse=" + adresse + ", date_n=" + date_n + ", email=" + email + ", telephone="
				+ telephone + ", type_utilisateur=" + type_utilisateur + "]";
	}

	@Override
	public boolean equals(Object obj)
	{
		if (obj == this)
		{
			return true;
		}
		if (obj == null)
		{
			return false;
		}

		Utilisateur other = (Utilisateur) obj;

		if (user.equals(other.user) && pass.equals(other.pass) && nom.equals(other.nom) && prenom.equals(other.prenom)
				&& adresse.equals(other.adresse) && email.equals(other.email) && telephone.equals(other.telephone)
				&& Utility.SameDate(date_n, other.date_n))
		{
			return true;
		}
		return false;
	}
}
