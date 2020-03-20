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
			Class.forName("com.mysql.jdbc.Driver"); // init le driver
			dbURL = "jdbc:mysql://localhost:3306/smartUniversity?autoReconnect=true&useSSL=false"; // données récup directement dans le web.xml
			dbLogin = "adminBD";
			dbPassword = "247365";
		} catch (Exception exception)
		{
			exception.printStackTrace();
		}
	}
}
