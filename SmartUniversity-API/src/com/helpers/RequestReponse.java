package com.helpers;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class RequestReponse
{	
	private String message_fr = null;
	private String message_en = null;
	private String message_ar = null;

	public RequestReponse()
	{
		
	}
	
	public RequestReponse(String message_fr, String message_en, String message_ar)
	{
		this.message_en = message_en;
		this.message_fr = message_en;
		this.message_ar = message_en;
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

	@Override
	public String toString()
	{
		return "RequestReponse [message_fr=" + message_fr + ", message_en=" + message_en + ", message_ar=" + message_ar
				+ "]";
	}
}
