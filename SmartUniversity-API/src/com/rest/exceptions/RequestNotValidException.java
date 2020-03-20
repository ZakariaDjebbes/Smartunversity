package com.rest.exceptions;

import javax.ws.rs.WebApplicationException;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import com.helpers.RequestReponse;

public class RequestNotValidException extends WebApplicationException
{
	private static final long serialVersionUID = 1L;
	
	public RequestNotValidException(Status status, RequestReponse response)
	{
		super(Response.status(status).entity(response).build());
	}
}
