package com.rest.exceptionHandling;

import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;
import javax.ws.rs.ext.ExceptionMapper;
import javax.ws.rs.ext.Provider;

import org.glassfish.jersey.message.internal.MessageBodyProviderNotFoundException;

import com.jsonReaders.MessageReader;
import com.utility.Utility;

@Provider
public class MessageBodyProviderNotFoundExceptionHandler implements ExceptionMapper<MessageBodyProviderNotFoundException>
{
	@Override
    public Response toResponse(MessageBodyProviderNotFoundException exception) {
        return Utility.Response(Status.BAD_REQUEST,
        		MessageReader.GetNode("message_body_provider_not_found_exception"));
    }
}
