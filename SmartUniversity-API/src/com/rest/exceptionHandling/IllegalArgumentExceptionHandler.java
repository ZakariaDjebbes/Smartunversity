package com.rest.exceptionHandling;

import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;
import javax.ws.rs.ext.ExceptionMapper;
import javax.ws.rs.ext.Provider;

import com.jsonReaders.MessageReader;
import com.utility.Utility;

@Provider
public class IllegalArgumentExceptionHandler implements ExceptionMapper<IllegalArgumentException>
{
	@Override
    public Response toResponse(IllegalArgumentException exception) {
        return Utility.Response(Status.BAD_REQUEST, 
        		MessageReader.GetNode("illegal_argument_exception"));
    }
}
