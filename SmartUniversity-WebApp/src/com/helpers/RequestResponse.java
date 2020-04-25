package com.helpers;

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
}
