package com.rest.services;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import com.data.DAO_Enseignant;
import com.data.DAO_User;
import com.helpers.RequestReponse;
import com.helpers.Utility;
import com.modele.Utilisateur;
import com.rest.annotations.Secured;
import com.rest.exceptions.RequestNotValidException;

@Path("/get")
public class Get
{
	@GET
	@Secured
	@Produces(MediaType.APPLICATION_JSON)
	@Path("{id}")
	public Response GetUserByID(@PathParam("id") int id)
	{
		Utilisateur utilisateur = DAO_User.GetUserByID(id);
		
		if(utilisateur == null)
		{
			throw new RequestNotValidException(Status.BAD_REQUEST, new RequestReponse("Cannot find a user with this ID"));
		}
		
		switch (utilisateur.getUser_type())
		{
		case enseignant:
			utilisateur = DAO_Enseignant.GetEnseignant(utilisateur);
			break;

		default:
			break;
		}
		
		return Utility.Response(Status.OK, utilisateur);
	}
}
