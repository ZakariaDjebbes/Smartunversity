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
import com.data.DAO_Enseignement;
import com.data.DAO_SeanceSupp;
import com.dots.Dot_Affecter_Seance;
import com.dots.Dot_Create_Absence;
import com.dots.Dot_Create_ChangementSeance;
import com.dots.Dot_Create_SeanceSupp;
import com.rest.annotations.Secured;
import com.utility.JsonReader;
import com.utility.Utility;

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
			return Utility.Response(Status.OK,
					JsonReader.GetNode("absence_created"));
		}
		else 
		{
			return Utility.Response(Status.BAD_REQUEST,
					JsonReader.GetNode("absence_not_created"));
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
			return Utility.Response(Status.OK,
					JsonReader.GetNode("change_request_created"));
		}
		else 
		{
			return Utility.Response(Status.BAD_REQUEST,
					JsonReader.GetNode("change_request_not_created"));
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
			return Utility.Response(Status.OK,
					JsonReader.GetNode("additional_session_request_created"));
		}
		else
		{
			return Utility.Response(Status.BAD_REQUEST,
					JsonReader.GetNode("additional_session_request_not_created"));
		}
	}
	
	@PUT
	@Secured
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/departement/affecterSeance")
	public Response affecterSeance(Dot_Affecter_Seance dot_Affecter_Seance)
	{
		dot_Affecter_Seance.Validate();
		
		if(DAO_Enseignement.AffecterSeance(dot_Affecter_Seance))
		{
			return Utility.Response(Status.OK,
					JsonReader.GetNode("teacher_assigned"));		
		}
		else 
		{
			return Utility.Response(Status.BAD_REQUEST,
					JsonReader.GetNode("teacher_not_assigned"));
		}
	}
}
