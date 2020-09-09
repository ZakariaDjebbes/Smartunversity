package com.data;

import com.jsonReaders.ConfigReader;

public class DAO_Initialize
{
	protected static String dbURL = null;
	protected static String dbUser = null;
	protected static String dbPassword = null;

	private static final String CONFIG_ROOT = "dbConfig";
	
	public static void Start()
	{
		try
		{			
			Class.forName(ConfigReader.GetNode(CONFIG_ROOT, "dbConnector")); // init le driver ?autoReconnect=true&useSSL=false
			dbURL = ConfigReader.GetNode(CONFIG_ROOT, "dbUrl");
			dbUser = ConfigReader.GetNode(CONFIG_ROOT, "dbUser");
			dbPassword = ConfigReader.GetNode(CONFIG_ROOT, "dbPassword");
		} 
		catch (Exception exception)
		{
			exception.printStackTrace();
		}
	}
}
