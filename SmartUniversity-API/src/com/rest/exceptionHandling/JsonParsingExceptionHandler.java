package com.rest.exceptionHandling;

import javax.json.stream.JsonParsingException;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;
import javax.ws.rs.ext.ExceptionMapper;
import javax.ws.rs.ext.Provider;

import com.jsonReaders.MessageReader;
import com.utility.Utility;

@Provider
public class JsonParsingExceptionHandler implements ExceptionMapper<JsonParsingException>
{
	@Override
	public Response toResponse(JsonParsingException exception)
	{
		return Utility.Response(Status.BAD_REQUEST,
				MessageReader.GetNode("json_parsing_exception"));
	}
}
