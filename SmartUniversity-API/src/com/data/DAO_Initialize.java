package com.data;

public class DAO_Initialize
{
	protected static String dbURL = null;
	protected static String dbLogin = null;
	protected static String dbPassword = null;

	public static void Start()
	{
		try
		{
			Class.forName("com.mysql.jdbc.Driver"); // init le driver ?autoReconnect=true&useSSL=false
			dbURL = "jdbc:mysql://localhost:3306/ntic?autoReconnect=true";
			dbLogin = "adminBD";
			dbPassword = "247365";
		} catch (Exception exception)
		{
			exception.printStackTrace();
		}
	}
}
