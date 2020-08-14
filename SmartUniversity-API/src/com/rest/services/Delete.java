package com.rest.services;

import javax.ws.rs.DELETE;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import com.data.DAO_Absence;
import com.data.DAO_ChangementSeance;
import com.data.DAO_CongeAcademique;
import com.data.DAO_Enseignement;
import com.data.DAO_SeanceSupp;
import com.data.DAO_User;
import com.rest.annotations.Secured;
import com.rest.exceptions.RequestNotValidException;
import com.utility.JsonReader;
import com.utility.Utility;

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
			throw new RequestNotValidException(Status.BAD_REQUEST,
					JsonReader.GetNode("user_not_exist"));
		}
		
		return Utility.Response(Status.OK, JsonReader.GetNode("profile_deleted"));
	}
	
	@DELETE
	@Secured
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/absence/{numero_absence}")
	public Response DeleteAbsenceByNumero(@PathParam("numero_absence") int numero_absence)
	{
		if(!DAO_Absence.DeleteAbsenceByNumero(numero_absence))
		{
			throw new RequestNotValidException(Status.BAD_REQUEST,
					JsonReader.GetNode("absence_not_exist"));			
		}
		else 
		{
			return Utility.Response(Status.OK,
					JsonReader.GetNode("absence_deleted"));
		}
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
			throw new RequestNotValidException(Status.BAD_REQUEST,
					JsonReader.GetNode("session_not_exist"));
		}
		
		return Utility.Response(Status.OK, 
				JsonReader.GetNode("change_request_deleted"));
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
			throw new RequestNotValidException(Status.BAD_REQUEST, 
					JsonReader.GetNode("additional_session_not_exist"));
		}
		
		return Utility.Response(Status.OK, JsonReader.GetNode("additional_session_request_deleted"));
	}
	
	@DELETE
	@Secured
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/departement/desaffecterSeance")
	public Response DesaffecterSeance(@QueryParam("code_seance") String code_seance)
	{
		boolean isDone = DAO_Enseignement.DesaffecterSeance(code_seance);
		
		if(!isDone)
		{
			throw new RequestNotValidException(Status.BAD_REQUEST,
					JsonReader.GetNode("session_not_exist"));
		}
		
		return Utility.Response(Status.OK,
				JsonReader.GetNode("session_cleared"));
	}
	
	@DELETE
	@Secured
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/congeAcademique")
	public Response DesaffecterSeance(@QueryParam("numero_conge_academique") int numero_conge_academique)
	{
		boolean isDone = DAO_CongeAcademique.DeleteCongeAcademique(numero_conge_academique);
		
		if(!isDone)
		{
			throw new RequestNotValidException(Status.BAD_REQUEST,
					JsonReader.GetNode("academic_leave_not_exist"));
		}
		
		return Utility.Response(Status.OK, 
				JsonReader.GetNode("academic_leave_request_deleted"));
	}
}
