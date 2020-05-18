package com.dots;

public class Dot_Login
{
	private String user = "";
	private String pass = "";
	
	public Dot_Login()
	{
	}

	public Dot_Login(String user, String pass)
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
}
