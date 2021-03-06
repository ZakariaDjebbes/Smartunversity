package com.modele;

import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Base64;
import java.util.Date;

import javax.persistence.Entity;
import javax.xml.bind.annotation.XmlRootElement;

import com.modele.Seance.Etat_Demande;

@Entity
@XmlRootElement
public class Justification
{
	private int numero_justification = 0;
	private int numero_absence = 0;
	private byte[] fichier = null;
	private String extension = null;
	private Date date_justification = null;
	private Etat_Demande etat_justification;
	
	public Justification()
	{
		
	}
	
	public Justification(int numero_justification, int numero_absence, byte[] fichier, Date date_justification,
			Etat_Demande etat_justification)
	{
		this.numero_justification = numero_justification;
		this.numero_absence = numero_absence;
		this.fichier = fichier;
		this.date_justification = date_justification;
		this.etat_justification = etat_justification;
	}

	public String getFormattedDate_jusitifcation()
	{
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		formatter.applyPattern("yyyy-MM-dd");
		return formatter.format(date_justification);
	}
	
	public int getNumero_justification()
	{
		return numero_justification;
	}

	public int getNumero_absence()
	{
		return numero_absence;
	}

	public Date getDate_justification()
	{
		return date_justification;
	}

	public Etat_Demande getEtat_justification()
	{
		return etat_justification;
	}

	public void setNumero_justification(int numero_justification)
	{
		this.numero_justification = numero_justification;
	}

	public void setNumero_absence(int numero_absence)
	{
		this.numero_absence = numero_absence;
	}

	public byte[] getFichier()
	{
		return fichier;
	}
	
	public String base64EncodedFichier()
	{
		byte[] encodeBase64 = Base64.getEncoder().encode(fichier);
		try
		{
			return new String(encodeBase64, "UTF-8");
		} catch (UnsupportedEncodingException e)
		{
			e.printStackTrace();
		}
		
		return null;
	}

	public void setFichier(byte[] fichier)
	{
		this.fichier = fichier;
	}
	
	public String getExtension()
	{
		return extension;
	}

	public void setExtension(String extension)
	{
		this.extension = extension;
	}
	public void setDate_justification(String date_justification)
	{
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		try
		{
			this.date_justification = formatter.parse(date_justification);
		}
		catch (ParseException e)
		{
			e.printStackTrace();
		}		
	}
	
	public void setEtat_justification(Etat_Demande etat_justification)
	{
		this.etat_justification = etat_justification;
	}
}
