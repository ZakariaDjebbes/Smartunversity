package com.helpers;

import javax.ws.rs.core.Response;

public class RequestResponse
{
	private String message = null;
	
	public RequestResponse()
	{
		
	}
	
	public String getMessage()
	{
		return message;
	}

	public void setMessage(String error)
	{
		this.message = error;
	}
	
	@Override
	public String toString()
	{
		return "RequestResponse [error=" + message + "]";
	}
	
	public static RequestResponse GetRequestResponse(Response apiResponse)
	{
		RequestResponse requestResponse = null;
		try
		{
			requestResponse = apiResponse.readEntity(RequestResponse.class);
			if(requestResponse.getMessage() == null) requestResponse = null;

		} 
		catch (Exception e)
		{
			requestResponse = null;
		}
		return requestResponse;
	}
}
