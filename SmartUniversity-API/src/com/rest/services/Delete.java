package com.rest.services;

import javax.ws.rs.DELETE;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import com.data.DAO_ChangementSeance;
import com.data.DAO_SeanceSupp;
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
	@Path("/utilisateur/{id}")
	public Response DeleteUserByID(@PathParam("id") int id)
	{
		boolean isDone = DAO_User.DeleteUserByID(id);
		
		if(!isDone)
		{
			throw new RequestNotValidException(Status.BAD_REQUEST, new RequestReponse("Couldn't find user with this ID"));
		}
		
		return Utility.Response(Status.OK, new RequestReponse("Profil deleted with success"));
	}
	
	@DELETE
	@Secured
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/changementSeance/{code_seance}")
	public Response DeleteChangementSeance(@PathParam("code_seance") String code_seance)
	{
		boolean isDone = DAO_ChangementSeance.DeleteChangementSeance(code_seance);
		
		if(!isDone)
		{
			throw new RequestNotValidException(Status.BAD_REQUEST, new RequestReponse("Couldn't find a seance with this code"));
		}
		
		return Utility.Response(Status.OK, new RequestReponse("Change demand was deleted with success"));
	}
	
	@DELETE
	@Secured
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/seance/supp/{code_seance}/{code_seance_supp}")
	public Response DeleteSeanceSupp(@PathParam("code_seance") String code_seance, @PathParam("code_seance_supp") int code_seance_supp)
	{
		boolean isDone = DAO_SeanceSupp.DeleteSeanceSupp(code_seance, code_seance_supp);
		
		if(!isDone)
		{
			throw new RequestNotValidException(Status.BAD_REQUEST, new RequestReponse("Couldn't find any additional seance with this code"));
		}
		
		return Utility.Response(Status.OK, new RequestReponse("Additional seance was deleted with success"));
	}
}
