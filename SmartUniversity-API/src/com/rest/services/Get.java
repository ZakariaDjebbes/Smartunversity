package com.rest.services;

import java.util.ArrayList;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import com.data.DAO_Enseignant;
import com.data.DAO_Etudiant;
import com.data.DAO_Module;
import com.data.DAO_Seance;
import com.data.DAO_User;
import com.helpers.RequestReponse;
import com.helpers.Utility;
import com.modele.Module;
import com.modele.Seance;
import com.modele.Utilisateur;
import com.modele.Etudiant;
import com.modele.Etudiant.Annee;
import com.modele.Etudiant.Specialite;
import com.rest.annotations.Secured;
import com.rest.exceptions.RequestNotValidException;

@Path("get")
public class Get
{
	@GET
	@Secured
	@Produces(MediaType.APPLICATION_JSON)
	@Path("user/{id}")
	public Response GetUserByID(@PathParam("id") int id)
	{
		Utilisateur utilisateur = DAO_User.GetUserByID(id);
		
		if(utilisateur == null)
		{
			throw new RequestNotValidException(Status.NOT_FOUND, new RequestReponse("Cannot find a user with this ID"));
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

	@GET
	@Secured
	@Produces(MediaType.APPLICATION_JSON)
	@Path("seances/{id}")
	public Response GetSeancesEnseignant(@PathParam("id") int id)
	{
		ArrayList<Seance> seances = DAO_Seance.GetSeancesEnseignantByID(id);
		
		if(seances.size() == 0)
		{
			return Utility.Response(Status.NOT_FOUND, new RequestReponse("Couldn't find seances matching this teacher ID"));
		}
		
		return Utility.Response(Status.OK, seances);
	}
	
	@GET
	@Secured
	@Produces(MediaType.APPLICATION_JSON)
	@Path("module/{code_module}")
	public Response GetModule(@PathParam("code_module") String code_module)
	{
		Module module = DAO_Module.GetMouleByCode(code_module);
		
		if(module == null)
		{
			return Utility.Response(Status.NOT_FOUND, new RequestReponse("Couldn't find a module for this code module"));
		}
		else 
		{
			return Utility.Response(Status.OK, module);
		}
	}
	
	@GET
	@Secured
	@Produces(MediaType.APPLICATION_JSON)
	@Path("etudiant")
	public Response GetEtudiantsForSeance(@QueryParam("annee") Annee annee, @QueryParam("specialite") Specialite specialite, @QueryParam("groupe") int groupe)
	{
		ArrayList<Etudiant> etudiants = DAO_Etudiant.GetEtudiants(annee, specialite, groupe);
		
		if(etudiants.size() == 0)
		{
			return Utility.Response(Status.NOT_FOUND, new RequestReponse("Couldn't find any student for this year, speciality and group"));
		}
		
		return Utility.Response(Status.OK, etudiants);
	}
	
	@GET
	@Secured
	@Produces(MediaType.APPLICATION_JSON)
	@Path("absence")
	public Response GetAbsencesBySeance(@QueryParam("code_seance")String code_seance, @QueryParam("date_absence") String date)
	{
		return null;
	}
}