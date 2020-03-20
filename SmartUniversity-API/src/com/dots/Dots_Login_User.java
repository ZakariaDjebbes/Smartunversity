package com.dots;

import javax.ws.rs.core.Response.Status;
import javax.xml.bind.annotation.XmlRootElement;

import com.helpers.RequestReponse;
import com.modele.User;
import com.rest.exceptions.RequestNotValidException;

@XmlRootElement
public class Dots_Login_User implements IDots
{
	private String username = "";
	private String password = "";

	public Dots_Login_User(String username, String password)
	{
		this.username = username;
		this.password = password;
	}

	public Dots_Login_User()
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

	public void setUsername(String username)
	{
		this.username = username;
	}

	public void setPassword(String password)
	{
		this.password = password;
	}

	@Override
	public void Validate()
	{		
		// Check notEmpty
		if (username.equals("") || password.equals(""))
			throw new RequestNotValidException(Status.BAD_REQUEST, new RequestReponse("Username or password is empty"));
		// Check size
		if (password.length() < User.MIN_PASSWORD_LENGHT)
			throw new RequestNotValidException(Status.BAD_REQUEST, new RequestReponse("Password must have atleast "+ User.MIN_PASSWORD_LENGHT +" characters"));
	}
}
