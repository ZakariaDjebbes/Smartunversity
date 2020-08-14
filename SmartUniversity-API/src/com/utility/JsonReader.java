package com.utility;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.helpers.RequestReponse;

public class JsonReader
{
	private static InputStream is =  JsonReader.class.getClassLoader().getResourceAsStream("/messages.json");
	private static BufferedReader br = new BufferedReader(new InputStreamReader(is));
	private static Gson gson = new Gson();
	private static JsonObject body = gson.fromJson(br, JsonObject.class);

	public static RequestReponse GetNode(String root)
	{
		JsonObject root_object = body.getAsJsonObject(root);
		RequestReponse reponse = gson.fromJson(root_object, RequestReponse.class);
		
		return reponse;
	}	
}
