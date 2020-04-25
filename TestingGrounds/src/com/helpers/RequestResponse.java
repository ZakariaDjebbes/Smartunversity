package com.helpers;

public class RequestResponse
{
	private String error = null;
	
	public RequestResponse()
	{
		
	}
	
	public String getError()
	{
		return error;
	}

	public void setError(String error)
	{
		this.error = error;
	}
	
	@Override
	public String toString()
	{
		return "RequestResponse [error=" + error + "]";
	}
}
