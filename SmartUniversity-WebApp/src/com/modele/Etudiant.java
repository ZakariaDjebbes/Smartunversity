package com.modele;

import java.util.Arrays;
import java.util.List;

public class Etudiant extends Utilisateur
{
	/***
	 * @author Zaki
	 *Values are by default setup to be in this order ("FRENCH", "ENGLISH", "ARABIC")
	 */
	public enum Annee
	{
		L1("1ere année licence", "PLACE HOLDER", "PLACE HOLDER"),
		L2("2ème année licence", "PLACE HOLDER", "PLACE HOLDER"),
		L3("3ème année licence", "PLACE HOLDER", "PLACE HOLDER"),
		M1("1ere année master", "PLACE HOLDER", "PLACE HOLDER"),
		M2("2ème année master", "PLACE HOLDER", "PLACE HOLDER");
		
		private final List<String> values;
		
		Annee(String... values)
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
	}
	
	/***
	 * @author Zaki
	 *Values are by default setup to be in this order ("FRENCH", "ENGLISH", "ARABIC")
	 */
	public enum Specialite
	{
		MI("Mathématiques et informatique", "PLACE HOLDER", "PLACE HOLDER"),
		GL("Génie logiciel", "PLACE HOLDER", "PLACE HOLDER"),
		SI("Systèmes d'information", "PLACE HOLDER", "PLACE HOLDER"),
		SCI("Sciences de l’informatique", "PLACE HOLDER", "PLACE HOLDER"),
		TI("Technologies de l'information", "PLACE HOLDER", "PLACE HOLDER"),
		STIC("Sciences et technologies de l'information et de la communication", "PLACE HOLDER", "PLACE HOLDER"),
		STIW("Systèmes d’information et technologies web", "PLACE HOLDER", "PLACE HOLDER"),
		RSD("Réseaux et systèmes distribués", "PLACE HOLDER", "PLACE HOLDER");
		
		private final List<String> values;
		
		Specialite(String... values)
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
	}
	
	/***
	 * @author Zaki
	 *Values are by default setup to be in this order ("FRENCH", "ENGLISH", "ARABIC")
	 */
	public enum Etat_Etudiant
	{
		actif("Actif","",""),
		bloque("En Congé Académique","","");
		
		private final List<String> values;
		
		Etat_Etudiant(String... values)
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
	}
	
	private Annee annee;
	private Specialite specialite;
	private int section = 0;
	private int groupe = 0;
	private Etat_Etudiant etat_etudiant;
	private Code_Departement code_departement;
	
	public Etudiant(Utilisateur utilisateur, Annee annee, Specialite specialite,
			int section, int groupe, Etat_Etudiant etat_etudiant, Code_Departement code_departement)
	{
		super(utilisateur.id_utilisateur, utilisateur.user, utilisateur.pass, utilisateur.nom, utilisateur.prenom, utilisateur.adresse,
				utilisateur.date_n, utilisateur.email, utilisateur.telephone, utilisateur.type_utilisateur);
		this.annee = annee;
		this.specialite = specialite;
		this.section = section;
		this.groupe = groupe;
		this.etat_etudiant = etat_etudiant;
		this.code_departement = code_departement;
	}
	
	public Etudiant() 
	{
		
	}

	public Annee getAnnee()
	{
		return annee;
	}

	public Specialite getSpecialite()
	{
		return specialite;
	}

	public int getSection()
	{
		return section;
	}

	public int getGroupe()
	{
		return groupe;
	}

	public Etat_Etudiant getEtat_etudiant()
	{
		return etat_etudiant;
	}

	public Code_Departement getCode_departement()
	{
		return code_departement;
	}

	public void setAnnee(Annee annee)
	{
		this.annee = annee;
	}

	public void setSpecialite(Specialite specialite)
	{
		this.specialite = specialite;
	}

	public void setSection(int section)
	{
		this.section = section;
	}

	public void setGroupe(int groupe)
	{
		this.groupe = groupe;
	}

	public void setEtat_etudiant(Etat_Etudiant etat_etudiant)
	{
		this.etat_etudiant = etat_etudiant;
	}

	public void setCode_departement(Code_Departement code_departement)
	{
		this.code_departement = code_departement;
	}

	@Override
	public String toString()
	{
		return "Etudiant [annee=" + annee + ", specialite=" + specialite + ", section=" + section + ", groupe=" + groupe
				+ ", etat_etudiant=" + etat_etudiant + ", code_departement=" + code_departement + ", id=" + id_utilisateur
				+ ", user=" + user + ", pass=" + pass + ", nom=" + nom + ", prenom=" + prenom + ", adresse=" + adresse
				+ ", date_n=" + date_n + ", email=" + email + ", telephone=" + telephone + ", type_utilisateur="
				+ type_utilisateur + "]";
	}
}
