package com.rest.services;

import javax.ws.rs.Consumes;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import com.data.DAO_Absence;
import com.dots.Dot_Create_Absence;
import com.helpers.RequestReponse;
import com.helpers.Utility;
import com.rest.annotations.Secured;

@Path("create")
public class Create
{
	@PUT
	@Secured
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Path("absence")
	public Response CreateAbsence(Dot_Create_Absence absence)
	{
		if(DAO_Absence.AddAbsence(absence))
		{
			return Utility.Response(Status.OK, new RequestReponse("Absence created with success"));
		}
		else 
		{
			return Utility.Response(Status.BAD_REQUEST, new RequestReponse("Couldn't create absence"));
		}
	}
}
