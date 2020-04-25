package com.dots;

import javax.ws.rs.core.Response.Status;
import javax.xml.bind.annotation.XmlRootElement;

import com.helpers.RequestReponse;
import com.modele.Utilisateur;
import com.rest.exceptions.RequestNotValidException;

@XmlRootElement
public class Dots_Login_User implements IDots
{
	private String user = "";
	private String pass = "";

	public Dots_Login_User()
	{

	}

	public Dots_Login_User(String user, String pass)
	{
		this.user = user;
		this.pass = pass;
	}
	
	public String getUser()
	{
		return user;
	}


	public String getPass()
	{
		return pass;
	}


	public void setUser(String user)
	{
		this.user = user;
	}


	public void setPass(String pass)
	{
		this.pass = pass;
	}

	@Override
	public void Validate()
	{		
		// Check notEmpty
		if (user.equals("") || pass.equals(""))
			throw new RequestNotValidException(Status.BAD_REQUEST, new RequestReponse("User or Pass is empty"));
		// Check size
		if (pass.length() < Utilisateur.MIN_PASS_LENGHT)
			throw new RequestNotValidException(Status.BAD_REQUEST, new RequestReponse("Pass must have atleast "+ Utilisateur.MIN_PASS_LENGHT +" characters"));
	}
}
