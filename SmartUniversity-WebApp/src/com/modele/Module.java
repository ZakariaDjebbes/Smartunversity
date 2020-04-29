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
	public String toString()
	{
		return "Module [code_module=" + code_module + ", nom=" + nom + "]";
	}
}
