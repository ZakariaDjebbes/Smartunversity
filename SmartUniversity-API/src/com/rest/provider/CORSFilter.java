package com.rest.provider;

import java.io.IOException;

import javax.ws.rs.container.ContainerRequestContext;
import javax.ws.rs.container.ContainerResponseContext;
import javax.ws.rs.container.ContainerResponseFilter;
import javax.ws.rs.ext.Provider;

import com.jsonReaders.ConfigReader;

@Provider
public class CORSFilter implements ContainerResponseFilter {
	private static final String CONFIG_ROOT = "corsConfig";
	
   @Override
   public void filter(final ContainerRequestContext requestContext,
                      final ContainerResponseContext cres) throws IOException {
      cres.getHeaders().add("Access-Control-Allow-Origin", ConfigReader.GetNode(CONFIG_ROOT, "allow-origin"));
      cres.getHeaders().add("Access-Control-Allow-Headers", ConfigReader.GetNode(CONFIG_ROOT, "allow-headers"));
      cres.getHeaders().add("Access-Control-Allow-Credentials", ConfigReader.GetNode(CONFIG_ROOT, "allow-credentials"));
      cres.getHeaders().add("Access-Control-Allow-Methods", ConfigReader.GetNode(CONFIG_ROOT, "allow-methods"));
      cres.getHeaders().add("Access-Control-Max-Age", ConfigReader.GetNode(CONFIG_ROOT, "max-age"));
   }
}