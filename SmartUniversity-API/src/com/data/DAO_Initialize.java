package com.data;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

public class DAO_Initialize
{
	protected static String dbURL = null;
	protected static String dbUser = null;
	protected static String dbPassword = null;

	public static void Start()
	{
		try
		{
			InputStream is =  DAO_Initialize.class.getClassLoader().getResourceAsStream("/config.json");
			BufferedReader br = new BufferedReader(new InputStreamReader(is));
			Gson gson = new Gson();
			JsonObject body = gson.fromJson(br, JsonObject.class);
			JsonObject dbConfig = body.getAsJsonObject("dbConfig");
						
			Class.forName(dbConfig.get("dbConnector").getAsString()); // init le driver ?autoReconnect=true&useSSL=false
			dbURL = dbConfig.get("dbUrl").getAsString();
			dbUser = dbConfig.get("dbUser").getAsString();
			dbPassword = dbConfig.get("dbPassword").getAsString();
		} 
		catch (Exception exception)
		{
			exception.printStackTrace();
		}
	}
}
