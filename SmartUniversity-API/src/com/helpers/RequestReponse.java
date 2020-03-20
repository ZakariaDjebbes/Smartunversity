package com.helpers;

import javax.persistence.Entity;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
@Entity
public class RequestReponse
{	
	private boolean isSuccessful = false;
	private String message = null;

	public RequestReponse(String message, boolean isSuccessful)
	{
		this.message = message;
		this.isSuccessful = isSuccessful;
	}
	
	public RequestReponse(String message)
	{
		this.message = message;
	}
	
	public String getError()
	{
		return message;
	}
	
	public void setError(String message)
	{
		this.message = message;
	}

	public boolean isSuccessful()
	{
		return isSuccessful;
	}

	public void setSuccessful(boolean isSuccessful)
	{
		this.isSuccessful = isSuccessful;
	}
}
