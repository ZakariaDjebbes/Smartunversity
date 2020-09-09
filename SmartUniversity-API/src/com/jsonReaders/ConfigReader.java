package com.jsonReaders;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

public class ConfigReader
{
	private static InputStream is =  ConfigReader.class.getClassLoader().getResourceAsStream("/config.json");
	private static BufferedReader br = new BufferedReader(new InputStreamReader(is));
	private static Gson gson = new Gson();
	private static JsonObject body = gson.fromJson(br, JsonObject.class);

	public static String GetNode(String root, String node)
	{
		JsonObject root_object = body.getAsJsonObject(root);
		JsonElement element = root_object.get(node);
		
		return element.getAsString();
	}	
}
