package com.dots;

import javax.persistence.Entity;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;
import javax.xml.bind.annotation.XmlRootElement;

import com.helpers.RequestResult;
import com.helpers.Utility;
import com.modele.User.User_Type;

@XmlRootElement
@Entity
public class Dots_Create_User implements IDots
{
	private String username = "";
	private String password = "";
	private String first_name = "";
	private String last_name = "";
	private User_Type user_type;

	public Dots_Create_User(String username, String password, String first_name, String last_name, User_Type user_type)
	{
		this.username = username;
		this.password = password;
		this.first_name = first_name;
		this.last_name = last_name;
		this.user_type = user_type;
	}
	
	public Dots_Create_User()
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

	public User_Type getUser_type()
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

	public void setUser_type(User_Type user_type)
	{
		this.user_type = user_type;
	}

	@Override
	public Response Validate()
	{
		//Values shouldn't be empty
		if (username.equals("") || password.equals("") || first_name.equals("") || last_name.equals("")
				|| user_type.equals(User_Type.Undefined))
		{
			return Utility.Response(Status.BAD_REQUEST, new RequestResult(
					"Request body missing important data to create a new user. Required fields are username, password, first name, last name, type"));
		}
		//Checking for password size
		if(password.length() < 6)
		{
			return Utility.Response(Status.BAD_REQUEST, new RequestResult("Password must have at least 6 characters"));
		}
		
		return null;
	}
}
