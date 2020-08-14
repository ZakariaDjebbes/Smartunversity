package com.modele;

import javax.persistence.Entity;
import javax.xml.bind.annotation.XmlRootElement;

import com.modele.Seance.Etat_Demande;
import com.modele.Seance.Jour;

@Entity
@XmlRootElement
public class ChangementSeance
{
	private String code_seance = null;
	private Jour nouveau_jour;
	private String nouvelle_heure = null;
	private Etat_Demande etat_demande;
	
	public ChangementSeance(String code_seance, Jour nouveau_jour, String nouvelle_heure, Etat_Demande etat_demande)
	{
		this.code_seance = code_seance;
		this.nouveau_jour = nouveau_jour;
		this.nouvelle_heure = nouvelle_heure;
		this.etat_demande = etat_demande;
	}
	
	public ChangementSeance()
	{
		
	}

	public String getCode_seance()
	{
		return code_seance;
	}

	public Jour getNouveau_jour()
	{
		return nouveau_jour;
	}

	public String getHeure()
	{
		return nouvelle_heure;
	}

	public Etat_Demande getEtat_seance()
	{
		return etat_demande;
	}

	public void setCode_seance(String code_seance)
	{
		this.code_seance = code_seance;
	}

	public void setNouveau_jour(Jour nouveau_jour)
	{
		this.nouveau_jour = nouveau_jour;
	}

	public void setHeure(String nouvelle_heure)
	{
		this.nouvelle_heure = nouvelle_heure;
	}

	public void setEtat_seance(Etat_Demande etat_demande)
	{
		this.etat_demande = etat_demande;
	}
	
	@Override
	public String toString()
	{
		return "ChangementSeance [code_seance=" + code_seance + ", nouveau_jour=" + nouveau_jour + ", heure=" + nouvelle_heure
				+ ", etat_seance=" + etat_demande + "]";
	}
}
