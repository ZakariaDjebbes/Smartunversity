package com.dots;

import javax.ws.rs.core.Response.Status;
import javax.xml.bind.annotation.XmlRootElement;

import com.modele.Utilisateur;
import com.rest.exceptions.RequestNotValidException;
import com.utility.JsonReader;

@XmlRootElement
public class Dot_Login_User implements IDot
{
	private String user = "";
	private String pass = "";

	public Dot_Login_User()
	{

	}

	public Dot_Login_User(String user, String pass)
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
			throw new RequestNotValidException(Status.BAD_REQUEST, 
					JsonReader.GetNode("empty_user_password"));
		// Check size
		if (pass.length() < Utilisateur.MIN_PASS_LENGHT)
			throw new RequestNotValidException(Status.BAD_REQUEST,
					JsonReader.GetNode("password_length")
					);
	}
}