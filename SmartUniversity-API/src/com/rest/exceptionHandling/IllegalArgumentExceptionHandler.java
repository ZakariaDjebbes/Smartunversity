package com.rest.exceptionHandling;

import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;
import javax.ws.rs.ext.ExceptionMapper;
import javax.ws.rs.ext.Provider;

import com.helpers.RequestReponse;
import com.helpers.Utility;

@Provider
public class IllegalArgumentExceptionHandler implements ExceptionMapper<IllegalArgumentException>
{
	@Override
    public Response toResponse(IllegalArgumentException exception) {
        return Utility.Response(Status.BAD_REQUEST, new RequestReponse("Couldn't parse a field in request body at: " + exception.getMessage()));
    }
}
