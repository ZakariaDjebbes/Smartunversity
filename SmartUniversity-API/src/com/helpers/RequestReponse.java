package com.helpers;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class RequestReponse
{	
	private String message = null;
	
	public RequestReponse(String message)
	{
		this.message = message;
	}
	
	public String getMessage()
	{
		return message;
	}
	
	public void setMessage(String message)
	{
		this.message = message;
	}
}
