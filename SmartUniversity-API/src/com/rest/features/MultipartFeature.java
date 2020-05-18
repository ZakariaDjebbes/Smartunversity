package com.rest.features;

import javax.ws.rs.core.Feature;
import javax.ws.rs.core.FeatureContext;
import javax.ws.rs.ext.Provider;

import org.glassfish.jersey.media.multipart.MultiPartFeature;

@Provider
public class MultipartFeature implements Feature
{

	@Override
	public boolean configure(FeatureContext context)
	{
		MultiPartFeature feature = new MultiPartFeature();
		context.register(feature);
		return true;
	}

}
