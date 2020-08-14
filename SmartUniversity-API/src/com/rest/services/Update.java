package com.rest.services;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import com.data.DAO_ChangementSeance;
import com.data.DAO_ChefDepartement;
import com.data.DAO_CongeAcademique;
import com.data.DAO_Enseignant;
import com.data.DAO_Etudiant;
import com.data.DAO_Justification;
import com.data.DAO_SeanceSupp;
import com.data.DAO_User;
import com.dots.Dot_Login_User;
import com.modele.Seance.Etat_Demande;
import com.modele.Utilisateur;
import com.rest.annotations.Secured;
import com.rest.exceptions.RequestNotValidException;
import com.utility.JsonReader;
import com.utility.Utility;

@Path("/update")
public class Update
{
	// Access to this service is :
	// http://localhost:8080/SmartUniversity-API/api/update/updateUser
	@Secured
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/updateUser")
	public Response UpdateUser(Utilisateur utilisateur)
	{
		// validation
		Dot_Login_User dots_Login_User = new Dot_Login_User(utilisateur.getUser(), utilisateur.getPass());

		dots_Login_User.Validate();

		// request
		int updatedRows = DAO_User.UpdateUser(utilisateur);

		if (updatedRows == 0)
		{
			throw new RequestNotValidException(Status.BAD_REQUEST,
					JsonReader.GetNode("profile_not_updated"));
		} else
		{
			Utilisateur userFromDB = DAO_User.GetUserByID(utilisateur.getId_utilisateur());
			switch (userFromDB.getUser_type())
			{
			case enseignant:
				userFromDB = DAO_Enseignant.GetEnseignant(userFromDB);
				break;
			case chefDepartement:
				userFromDB = DAO_ChefDepartement.GetChefDepartement(userFromDB);
				break;
			case etudiant: 
				userFromDB = DAO_Etudiant.GetEtudiantById(userFromDB.getId_utilisateur());
			default:
				break;
			}

			return Utility.Response(Status.OK, userFromDB);
		}
	}
	
	@Secured
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/departement/refuser/justification")
	public Response RefuserJustification(@QueryParam("numero_absence") int numero_absence, @QueryParam("numero_justification") int numero_justification)
	{
		if(DAO_Justification.SetJustificationState(Etat_Demande.refuse, numero_absence, numero_justification))
		{
			return Utility.Response(Status.OK, 
					JsonReader.GetNode("justification_accepted"));
		}
		else
		{
			return Utility.Response(Status.NOT_MODIFIED,
					JsonReader.GetNode("justification_not_updated"));
		}
	}
	
	@Secured
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/departement/valider/justification")
	public Response ValiderJustification(@QueryParam("numero_absence") int numero_absence, @QueryParam("numero_justification") int numero_justification)
	{
		if(DAO_Justification.SetJustificationState(Etat_Demande.valide, numero_absence, numero_justification))
		{
			return Utility.Response(Status.OK,
					JsonReader.GetNode("justification_denied"));
		}
		else
		{
			return Utility.Response(Status.NOT_MODIFIED,
					JsonReader.GetNode("justification_not_updated"));
		}
	}
	
	@Secured
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/departement/valider/demande/seanceSupp")
	public Response ValiderSeanceSupp(@QueryParam("code_seance_supp") int code_seance_supp)
	{
		if(DAO_SeanceSupp.SetEtatDemande(Etat_Demande.valide, code_seance_supp))
		{
			return Utility.Response(Status.OK, JsonReader.GetNode("demand_accepted"));
		}
		else
		{
			return Utility.Response(Status.NOT_MODIFIED, JsonReader.GetNode("demand_not_updated"));
		}
	}
	
	@Secured
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/departement/refuser/demande/seanceSupp")
	public Response RefuserSeanceSupp(@QueryParam("code_seance_supp") int code_seance_supp)
	{
		if(DAO_SeanceSupp.SetEtatDemande(Etat_Demande.refuse, code_seance_supp))
		{
			return Utility.Response(Status.OK, JsonReader.GetNode("demand_denied"));
		}
		else
		{
			return Utility.Response(Status.NOT_MODIFIED, JsonReader.GetNode("demand_not_updated"));
		}
	}
	
	@Secured
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/departement/valider/demande/changement")
	public Response ValiderChangementSeance(@QueryParam("code_seance") String code_seance)
	{
		if(DAO_ChangementSeance.ChangerSeance(DAO_ChangementSeance.GetChangementSeance(code_seance)))
		{
			return Utility.Response(Status.OK, JsonReader.GetNode("demand_accepted"));
		}
		else
		{
			return Utility.Response(Status.NOT_MODIFIED, JsonReader.GetNode("demand_not_updated"));
		}
	}
	
	@Secured
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/departement/refuser/demande/changement")
	public Response RefuserChangementSeance(@QueryParam("code_seance") String code_seance)
	{
		if(DAO_ChangementSeance.SetEtatDemande(Etat_Demande.refuse, code_seance))
		{
			return Utility.Response(Status.OK, JsonReader.GetNode("demand_denied"));
		}
		else
		{
			return Utility.Response(Status.NOT_MODIFIED, JsonReader.GetNode("demand_not_updated"));
		}
	}
	
	@Secured
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/departement/valider/demande/congeAcademique")
	public Response ValiderCongeAcademique(@QueryParam("numero_conge_academique") int numero_conge_academique)
	{
		if(DAO_CongeAcademique.AcceptCongeAcademique(numero_conge_academique, 
				DAO_CongeAcademique.GetCongeAcademiqueByCode(numero_conge_academique).getId_etudiant()))
		{
			return Utility.Response(Status.OK, JsonReader.GetNode("demand_accepted"));
		}
		else
		{
			return Utility.Response(Status.NOT_MODIFIED, JsonReader.GetNode("demand_not_updated"));
		}
	}
	
	@Secured
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/departement/refuser/demande/congeAcademique")
	public Response RefuserCongeAcademique(@QueryParam("numero_conge_academique") int numero_conge_academique)
	{
		if(DAO_CongeAcademique.RefuserCongeAcademique(numero_conge_academique, 
				DAO_CongeAcademique.GetCongeAcademiqueByCode(numero_conge_academique).getId_etudiant()))
		{
			return Utility.Response(Status.OK, JsonReader.GetNode("demand_denied"));
		}
		else
		{
			return Utility.Response(Status.NOT_MODIFIED, JsonReader.GetNode("demand_not_updated"));
		}
	}
}
