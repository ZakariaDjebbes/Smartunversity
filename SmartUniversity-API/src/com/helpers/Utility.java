package com.helpers;

import java.security.SecureRandom;

import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

public class Utility
{
	public static <T> Response Response(Status status, T entity)
	{
		return Response.status(status).entity(entity).build();
	}

	public static <E extends Enum<E>> boolean IsInEnum(String value, Class<E> enumClass)
	{
		for (E e : enumClass.getEnumConstants())
		{
			if (e.name().equals(value))
			{
				return true;
			}
		}
		return false;
	}
	
	//TODO this is trash change it
	public static boolean HourExists(String heure)
	{
		if(!heure.equals("8:30") && !heure.equals("10:00") && !heure.equals("11:30") && !heure.equals("13:00") 
				&& !heure.equals("14:30"))
			return false;
		
		return true;
	}
	
	public static String generateRandomString(int length) {
		final String ALPHABET = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
	    SecureRandom random = new SecureRandom();
	    StringBuilder builder = new StringBuilder(length);

	    for (int i = 0; i < length; i++) 
	    {
	        builder.append(ALPHABET.charAt(random.nextInt(ALPHABET.length())));
	    }

	    return builder.toString();
	}
}
