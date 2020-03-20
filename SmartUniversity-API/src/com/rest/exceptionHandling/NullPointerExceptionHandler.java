package com.rest.exceptionHandling;

import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;
import javax.ws.rs.ext.ExceptionMapper;
import javax.ws.rs.ext.Provider;

import com.helpers.RequestReponse;
import com.helpers.Utility;

@Provider
public class NullPointerExceptionHandler implements ExceptionMapper<NullPointerException>
{

	@Override
	public Response toResponse(NullPointerException exception)
	{
		return Utility.Response(Status.BAD_REQUEST, new RequestReponse("Failed to parse json data, An expected field is missing in request body"));
	}
}
