package com.rest.services;

import javax.ws.rs.Consumes;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import com.data.DAO_Absence;
import com.data.DAO_ChangementSeance;
import com.data.DAO_SeanceSupp;
import com.dots.Dot_Create_Absence;
import com.dots.Dot_Create_ChangementSeance;
import com.dots.Dot_Create_SeanceSupp;
import com.helpers.RequestReponse;
import com.helpers.Utility;
import com.rest.annotations.Secured;

@Path("/create")
public class Create
{
	@PUT
	@Secured
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/absence")
	public Response CreateAbsence(Dot_Create_Absence absence)
	{
		if(DAO_Absence.CreateAbsence(absence))
		{
			return Utility.Response(Status.OK, new RequestReponse("Absence created with success"));
		}
		else 
		{
			return Utility.Response(Status.BAD_REQUEST, new RequestReponse("Couldn't create absence"));
		}
	}
	
	@PUT
	@Secured
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/changementSeance")
	public Response CreateChangementSenace(Dot_Create_ChangementSeance changementSeance)
	{
		//validation
		changementSeance.Validate();
		
		//create
		if(DAO_ChangementSeance.CreateChangementSeance(changementSeance))
		{
			return Utility.Response(Status.OK, new RequestReponse("Seance changement created with success"));
		}
		else 
		{
			return Utility.Response(Status.BAD_REQUEST, new RequestReponse("Seance changement couldn't be created due to invalid data or server side error"));
		}
	}
	
	@PUT
	@Secured
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/seance/supp")
	public Response createSeanceSupp(Dot_Create_SeanceSupp seanceSupp)
	{
		//validation
		seanceSupp.Validate();
		
		//create
		if(DAO_SeanceSupp.CreateSeanceSupp(seanceSupp))
		{
			return Utility.Response(Status.OK, new RequestReponse("Additional seance created with success"));
		}
		else
		{
			return Utility.Response(Status.BAD_REQUEST, new RequestReponse("Additional seance couldn't be created due to invalid data or server side error"));			
		}
	}
	
	
	//LOOK in Upload.java
//	@PUT
//	@Secured
//	@Consumes(MediaType.APPLICATION_JSON)
//	@Produces(MediaType.APPLICATION_JSON)
//	@Path("justification")
//	public Response createJustification(Dot_Create_Justification justification)
//	{
//		//validation
//		justification.Validate();
//		
//		//creation
//		if(DAO_Justification.CreateJustification(justification))
//		{
//			return Utility.Response(Status.OK, new RequestReponse("Justification created with success"));
//		}
//		else 
//		{
//			return Utility.Response(Status.BAD_REQUEST, new RequestReponse("Couldn't create the justification due to invalid data or server side error"));			
//		}
//	}
}
