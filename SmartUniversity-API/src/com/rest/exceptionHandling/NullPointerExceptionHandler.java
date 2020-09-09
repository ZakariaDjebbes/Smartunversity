package com.rest.exceptionHandling;

import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;
import javax.ws.rs.ext.ExceptionMapper;
import javax.ws.rs.ext.Provider;

import com.jsonReaders.MessageReader;
import com.utility.Utility;

@Provider
public class NullPointerExceptionHandler implements ExceptionMapper<NullPointerException>
{

	@Override
	public Response toResponse(NullPointerException exception)
	{
		return Utility.Response(Status.BAD_REQUEST, 
				MessageReader.GetNode("null_pointer_exception"));
	}
}
