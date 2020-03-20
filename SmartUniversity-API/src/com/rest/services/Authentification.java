package com.rest.services;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import com.data.DAO_User;
import com.dots.Dots_Create_User;
import com.dots.Dots_Login_User;
import com.helpers.RequestResult;
import com.helpers.Utility;
import com.modele.User;

@Path("/auth")
public class Authentification
{

	// Access to this service is :
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/login")
	public Response Login(Dots_Login_User userLoginDots)
	{
		// validation
		if (userLoginDots == null)
		{
			return Utility.Response(Status.BAD_REQUEST, new RequestResult("Request body is empty"));
		}
		// validation
		if (userLoginDots.Validate() != null)
		{
			return userLoginDots.Validate();
		}

		// request
		User userFromDB = DAO_User.GetUser(userLoginDots);

		if (userFromDB == null)
		{
			return Utility.Response(Status.UNAUTHORIZED, new RequestResult("This user doesn't exist"));
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
		// request shoudn't be empty
		if (userCreateDots == null)
		{
			return Utility.Response(Status.BAD_REQUEST, new RequestResult("Request body is empty"));
		}
		// validation
		if (userCreateDots.Validate() != null)
		{
			return userCreateDots.Validate();
		}

		// creating account
		if (DAO_User.UserExists(userCreateDots.getUsername()))
		{
			return Utility.Response(Status.BAD_REQUEST, new RequestResult("Username already exists"));
		} else
		{
			if (DAO_User.CreateUser(userCreateDots))
				return Response.ok().build();
			else
				return Utility.Response(Status.INTERNAL_SERVER_ERROR,
						new RequestResult("Internal error prevented the creation of the user"));
		}
	}
}
