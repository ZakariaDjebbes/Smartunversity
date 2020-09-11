package com.modele;

import java.util.Arrays;
import java.util.List;

import javax.persistence.Entity;
import javax.xml.bind.annotation.XmlRootElement;

import com.modele.Etudiant.Annee;
import com.modele.Etudiant.Specialite;

@XmlRootElement
@Entity
public class Seance
{
	/***
	 * @author Zaki
	 *Values are by default setup to be in this order ("FRENCH", "ENGLISH", "ARABIC")
	 */
	public enum Type_Seance
	{
		TD("Travaux dirigés", "Directed Work", "PLACE HOLDER"),
		TP("Travaux pratiques", "Practical work", "PLACE HOLDER");
				
		private final List<String> values;
		
		Type_Seance(String... values)
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
	public enum Jour
	{
		dimanche("Dimanche", "Sunday", "PLACE HOLDER"),
		lundi("Lundi", "Monday", "PLACE HOLDER"),
		mardi("Mardi", "Tuesday", "PLACE HOLDER"),
		mercredi("Mercredi", "Wednesday", "PLACE HOLDER"),
		jeudi("Jeudi", "Thursday", "PLACE HOLDER");
		
		private final List<String> values;
		
		Jour(String... values)
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
	public enum Etat_Demande
	{
		valide("Validé", "Valid", "PLACE HOLDER"),
		refuse("Refusé", "Denied", "PLACE HOLDER"),
		nonTraite("Non traité", "Untreated", "PLACE HOLDER");

		private final List<String> values;
		
		Etat_Demande(String... values)
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
	
	protected String code_seance = null;
	protected String code_module = null;
	protected Type_Seance type;
	protected Annee annee;
	protected Specialite specialite;
	protected int section = 0;
	protected int groupe = 0;
	protected Jour jour;
	protected String heure = null;

	public Seance()
	{
		
	}
	
	public Seance(String code_seance, String code_module, Type_Seance type, Annee annee, Specialite specialite,
			int section, int groupe, Jour jour, String heure)
	{
		this.code_seance = code_seance;
		this.code_module = code_module;
		this.type = type;
		this.annee = annee;
		this.specialite = specialite;
		this.section = section;
		this.groupe = groupe;
		this.jour = jour;
		this.heure = heure;
	}

	public String getCode_seance()
	{
		return code_seance;
	}

	public String getCode_module()
	{
		return code_module;
	}

	public Type_Seance getType()
	{
		return type;
	}

	public int getSection()
	{
		return section;
	}

	public int getGroupe()
	{
		return groupe;
	}

	public Jour getJour()
	{
		return jour;
	}

	public String getHeure()
	{
		return heure;
	}

	public void setCode_seance(String code_seance)
	{
		this.code_seance = code_seance;
	}

	public void setCode_module(String code_module)
	{
		this.code_module = code_module;
	}

	public void setType(Type_Seance type)
	{
		this.type = type;
	}

	public void setSection(int section)
	{
		this.section = section;
	}

	public void setGroupe(int groupe)
	{
		this.groupe = groupe;
	}

	public void setJour(Jour jour)
	{
		this.jour = jour;
	}

	public void setHeure(String heure)
	{
		this.heure = heure;
	}
	
	public Annee getAnnee()
	{
		return annee;
	}

	public Specialite getSpecialite()
	{
		return specialite;
	}

	public void setAnnee(Annee annee)
	{
		this.annee = annee;
	}

	public void setSpecialite(Specialite specialite)
	{
		this.specialite = specialite;
	}
	
	@Override
	public String toString()
	{
		return "Seance [code_seance=" + code_seance + ", code_module=" + code_module + ", type=" + type + ", section="
				+ section + ", groupe=" + groupe + ", jour=" + jour + ", heure=" + heure + "]";
	}
}
