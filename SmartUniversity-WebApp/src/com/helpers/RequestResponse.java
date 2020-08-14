package com.helpers;

import javax.ws.rs.core.Response;

public class RequestResponse
{
	private String message_fr = null;
	private String message_en = null;
	private String message_ar = null;

	public RequestResponse()
	{
		
	}
	
	public RequestResponse(String message_fr)
	{
		this.message_fr = message_fr;
	}
	
	
	public String getMessage_en()
	{
		return message_en;
	}

	public String getMessage_ar()
	{
		return message_ar;
	}

	public void setMessage_en(String message_en)
	{
		this.message_en = message_en;
	}

	public void setMessage_ar(String message_ar)
	{
		this.message_ar = message_ar;
	}

	public String getMessage_fr()
	{
		return message_fr;
	}
	
	public void setMessage_fr(String message)
	{
		this.message_fr = message;
	}
	
	public static RequestResponse GetRequestResponse(Response apiResponse)
	{
		RequestResponse requestResponse = null;
		try
		{
			requestResponse = apiResponse.readEntity(RequestResponse.class);
			if(requestResponse.getMessage_fr() == null) requestResponse = null;

		} 
		catch (Exception e)
		{
			requestResponse = null;
		}
		return requestResponse;
	}
}
