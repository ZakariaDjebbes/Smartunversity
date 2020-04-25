package com.rest.services;

import javax.ws.rs.DELETE;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import com.data.DAO_User;
import com.helpers.RequestReponse;
import com.helpers.Utility;
import com.rest.annotations.Secured;
import com.rest.exceptions.RequestNotValidException;

@Path("/delete")
public class Delete
{
	
	@DELETE
	@Secured
	@Produces(MediaType.APPLICATION_JSON)
	@Path("{id}")
	public Response DeleteUserByID(@PathParam("id") int id)
	{
		boolean isDone = DAO_User.DeleteUserByID(id);
		if(!isDone)	
			throw new RequestNotValidException(Status.BAD_REQUEST, new RequestReponse("Couldn't find user with this ID"));

		return Utility.Response(Status.OK, new RequestReponse("Profil deleted with success"));
	}
	
}
