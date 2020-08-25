package com.modele;

import javax.persistence.Entity;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
@Entity
public class Module
{
	private String code_module = null;
	private String nom = null;

	public Module()
	{
		
	}
	
	public Module(String code_module, String nom)
	{
		this.code_module = code_module;
		this.nom = nom;
	}

	public String getCode_module()
	{
		return code_module;
	}

	public void setCode_module(String code_module)
	{
		this.code_module = code_module;
	}

	public String getNom()
	{
		return nom;
	}

	public void setNom(String nom)
	{
		this.nom = nom;
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

		Module other = (Module) obj;

		if (code_module.equals(other.getCode_module()) && nom.equals(other.getNom()))
		{
			return true;
		}
		return false;
	}
	
	@Override
	public String toString()
	{
		return "Module [code_module=" + code_module + ", nom=" + nom + "]";
	}
}
