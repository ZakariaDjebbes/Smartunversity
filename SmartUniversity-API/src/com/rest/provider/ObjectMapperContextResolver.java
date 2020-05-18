package com.rest.provider;

import javax.annotation.Priority;
import javax.ws.rs.ext.ContextResolver;
import javax.ws.rs.ext.Provider;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;

@Provider
@Priority(1)
public class ObjectMapperContextResolver implements ContextResolver<ObjectMapper> {
	@Override
	public ObjectMapper getContext(final Class<?> arg0)
	{
		ObjectMapper mapper = new ObjectMapper();
		mapper.configure(DeserializationFeature.FAIL_ON_NULL_FOR_PRIMITIVES, true);
		return mapper;
	}
}