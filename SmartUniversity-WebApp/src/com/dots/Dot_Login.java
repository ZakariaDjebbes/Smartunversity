package com.dots;

public class Dot_Login
{
	private String user = "";
	private String pass = "";
	private boolean isAndroid = false;
	
	public Dot_Login()
	{

	}

	public Dot_Login(String user, String pass, boolean isAndroid)
	{
		this.user = user;
		this.pass = pass;
		this.isAndroid = isAndroid;
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
	
	public boolean isAndroid()
	{
		return isAndroid;
	}

	public void setAndroid(boolean isAndroid)
	{
		this.isAndroid = isAndroid;
	}
}
