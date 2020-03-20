package com.modele;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class User
{
	public static final int MIN_PASSWORD_LENGHT = 6;
	
	public enum User_Type 
	{
		Undefined,
		Etudiant,
		Enseignant,
		Chef_Departement,
		Reponsable_Formation,
		Administrateur,
	}
	
	private int id = 0;
	private String username = null;
	private String password = null;
	private String first_name = null;
	private String last_name = null;
	private User_Type user_type;
	
	public User(int id, String username, String password, String first_name, String last_name, User_Type user_type)
	{
		this.id = id;
		this.username = username;
		this.password = password;
		this.first_name = first_name;
		this.last_name = last_name;
		this.user_type = user_type;
	}
	
	public User() 
	{
		
	}

	public int getId()
	{
		return id;
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

	public void setId(int id)
	{
		this.id = id;
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
	public String toString()
	{
		return "User [id=" + id + ", username=" + username + ", password=" + password + ", first_name=" + first_name
				+ ", last_name=" + last_name + ", user_type=" + user_type + "]";
	}
}
