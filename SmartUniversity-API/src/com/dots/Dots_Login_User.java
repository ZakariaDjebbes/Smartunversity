package com.dots;

import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;
import javax.xml.bind.annotation.XmlRootElement;

import com.helpers.RequestResult;
import com.helpers.Utility;

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
	public Response Validate()
	{
		int passwordMin = 6;
		
		// Check notEmpty
		if (username.equals("") || password.equals(""))
			return Utility.Response(Status.BAD_REQUEST, new RequestResult("Username or password is empty"));
		// Check size
		if (password.length() < passwordMin)
			return Utility.Response(Status.BAD_REQUEST, new RequestResult("Password must have atleast "+ passwordMin +" characters"));

		return null;
	}
}
