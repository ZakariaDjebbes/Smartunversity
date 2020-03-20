package com.helpers;

import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

public class Utility
{
	public static <T> Response Response (Status status, T entity)
	{
		return Response.status(status).entity(entity).build();
	}
}
