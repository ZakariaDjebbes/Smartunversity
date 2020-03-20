package com.rest.services;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import com.data.DAO_User;
import com.dots.Dots_Create_User;
import com.dots.Dots_Login_User;
import com.helpers.RequestReponse;
import com.helpers.Utility;
import com.modele.User;
import com.rest.exceptions.RequestNotValidException;

@Path("/auth")
public class Authentification
{

	@GET
	@Produces(MediaType.TEXT_PLAIN)
	@Path("/test")
	public Response TestAuthService()
	{
		return Response.ok("Test service running...").build();
	}
	
	// Access to this service is :
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/login")
	public Response Login(Dots_Login_User userLoginDots)
	{
		//validation
		userLoginDots.Validate();

		// request
		User userFromDB = DAO_User.GetUser(userLoginDots);

		if (userFromDB == null)
		{
			throw new RequestNotValidException(Status.UNAUTHORIZED, new RequestReponse("Invalid username and password combination"));
		} else
		{
			return Utility.Response(Status.OK, userFromDB);
		}
	}

	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/create")
	public Response CreateUser(Dots_Create_User userCreateDots)
	{
		//validation
		userCreateDots.Validate();
		
		// creating account
		if (DAO_User.UserExists(userCreateDots.getUsername()))
		{
			throw new RequestNotValidException(Status.BAD_REQUEST, new RequestReponse("Username already exists"));
		} else
		{
			if (DAO_User.CreateUser(userCreateDots))
				return Response.ok().build();
			else
				throw new RequestNotValidException(Status.INTERNAL_SERVER_ERROR,
						new RequestReponse("Internal error prevented the creation of the user"));
		}
	}
}
