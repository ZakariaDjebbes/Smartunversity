package com.dots;

import javax.ws.rs.core.Response.Status;
import javax.xml.bind.annotation.XmlRootElement;

import com.helpers.RequestReponse;
import com.modele.Utilisateur;
import com.modele.Utilisateur.Type_Utilisateur;
import com.rest.exceptions.RequestNotValidException;

@XmlRootElement
public class Dot_Create_User implements IDot
{
	private String username = "";
	private String password = "";
	private String first_name = "";
	private String last_name = "";
	private Type_Utilisateur user_type;

	public Dot_Create_User(String username, String password, String first_name, String last_name, Type_Utilisateur user_type)
	{
		this.username = username;
		this.password = password;
		this.first_name = first_name;
		this.last_name = last_name;
		this.user_type = user_type;
	}

	public Dot_Create_User()
	{

	}

	public String getUsername()
	{
		return username;
	}

	public String getPassword()
	{
		return password;
	}

	public String getFirst_name()
	{
		return first_name;
	}

	public String getLast_name()
	{
		return last_name;
	}

	public Type_Utilisateur getUser_type()
	{
		return user_type;
	}

	public void setUsername(String username)
	{
		this.username = username;
	}

	public void setPassword(String password)
	{
		this.password = password;
	}

	public void setFirst_name(String first_name)
	{
		this.first_name = first_name;
	}

	public void setLast_name(String last_name)
	{
		this.last_name = last_name;
	}

	public void setUser_type(Type_Utilisateur user_type)
	{
		this.user_type = user_type;
	}

	@Override
	public void Validate()
	{
		// Values shouldn't be empty
		if (username.equals("") || password.equals("") || first_name.equals("") || last_name.equals("")
				|| user_type.equals(Type_Utilisateur.undefined))
		{
			throw new RequestNotValidException(Status.BAD_REQUEST, new RequestReponse(
					"Request body missing important data to create a new user. Required fields are username, password, first name, last name, type"));
		}
		// Checking for password size
		if (password.length() < Utilisateur.MIN_PASS_LENGHT)
		{
			throw new RequestNotValidException(Status.BAD_REQUEST,
					new RequestReponse("Password must have atleast " + Utilisateur.MIN_PASS_LENGHT + " characters"));
		}
	}
}
