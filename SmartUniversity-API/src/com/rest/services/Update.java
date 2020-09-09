package com.rest.services;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import com.data.DAO_Admin;
import com.data.DAO_ChangementSeance;
import com.data.DAO_ChefDepartement;
import com.data.DAO_CongeAcademique;
import com.data.DAO_Enseignant;
import com.data.DAO_Etudiant;
import com.data.DAO_Justification;
import com.data.DAO_Module;
import com.data.DAO_Notification;
import com.data.DAO_NotificationChangementSeance;
import com.data.DAO_NotificationSeanceSupp;
import com.data.DAO_ReponsableFormation;
import com.data.DAO_Seance;
import com.data.DAO_SeanceSupp;
import com.data.DAO_User;
import com.dots.Dot_Login_User;
import com.jsonReaders.MessageReader;
import com.modele.Enseignant;
import com.modele.Etudiant;
import com.modele.Module;
import com.modele.Seance;
import com.modele.Seance.Etat_Demande;
import com.modele.Seance.Type_Seance;
import com.modele.SeanceSupp;
import com.modele.Utilisateur;
import com.rest.annotations.Secured;
import com.rest.exceptions.RequestNotValidException;
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
	public Response UpdateUser(Utilisateur utilisateur, @QueryParam("is_android") boolean isAndroid)
	{
		Utilisateur oldUtilisateur = DAO_User.GetUserByID(utilisateur.getId_utilisateur());
		
		boolean checkUser = !DAO_User.UsernameExists(utilisateur.getUser()) || oldUtilisateur.getUser().equals(utilisateur.getUser());
		boolean checkEmail = !DAO_User.EmailExists(utilisateur.getEmail()) || oldUtilisateur.getEmail().equals(utilisateur.getEmail());
		
		if (checkUser && checkEmail)
		{
			// validation
			Dot_Login_User dots_Login_User = new Dot_Login_User(utilisateur.getUser(), utilisateur.getPass(), isAndroid);

			dots_Login_User.Validate();

			// request
			int updatedRows = DAO_User.UpdateUser(utilisateur);

			if (updatedRows == 0)
			{
				throw new RequestNotValidException(Status.BAD_REQUEST, MessageReader.GetNode("profile_not_updated"));
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
					break;
				case admin:
					userFromDB = DAO_Admin.GetAdminById(userFromDB.getId_utilisateur());
					break;
				case responsableFormation:
					userFromDB = DAO_ReponsableFormation.GetReponsableFormation(userFromDB);
					break;
				default:
					break;
				}

				return Utility.Response(Status.OK, userFromDB);
			}
		} else
		{
			if(!checkEmail)
			{
				throw new RequestNotValidException(Status.BAD_REQUEST, MessageReader.GetNode("change_email"));
			}
			if(!checkUser)
			{
				throw new RequestNotValidException(Status.BAD_REQUEST, MessageReader.GetNode("change_username"));	
			}
			
			throw new RequestNotValidException(Status.BAD_REQUEST, MessageReader.GetNode("internal_error"));	
		}
	}

	@Secured
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/admin/etudiant")
	public Response UpdateEtudiant(Etudiant etudiant)
	{
		if (DAO_Etudiant.UpdateEtudiant(etudiant))
		{
			return Utility.Response(Status.OK, MessageReader.GetNode("student_updated"));
		} else
		{
			return Utility.Response(Status.INTERNAL_SERVER_ERROR, MessageReader.GetNode("student_not_updated"));
		}
	}

	@Secured
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/admin/module")
	public Response UpdateModule(Module module, @QueryParam("old_code_module") String oldCodeModule)
	{
		if (DAO_Module.UpdateModule(module, oldCodeModule))
		{
			return Utility.Response(Status.OK, MessageReader.GetNode("module_updated"));
		} else
		{
			return Utility.Response(Status.INTERNAL_SERVER_ERROR, MessageReader.GetNode("module_not_updated"));
		}
	}

	@Secured
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/admin/enseignant")
	public Response UpdateEnseignant(Enseignant enseignant)
	{
		if (DAO_Enseignant.UpdateEnseignant(enseignant))
		{
			return Utility.Response(Status.OK, MessageReader.GetNode("teacher_updated"));
		} else
		{
			return Utility.Response(Status.INTERNAL_SERVER_ERROR, MessageReader.GetNode("teacher_not_updated"));
		}
	}

	@Secured
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/admin/seance")
	public Response UpdateSeance(@QueryParam("code_seance") String code_seance,
			@QueryParam("type_seance") Type_Seance type_seance, @QueryParam("code_module") String code_module)
	{
		if (DAO_Seance.UpdateSeance(code_seance, type_seance, code_module))
		{
			return Utility.Response(Status.OK, MessageReader.GetNode("session_updated"));
		} else
		{
			return Utility.Response(Status.INTERNAL_SERVER_ERROR, MessageReader.GetNode("session_not_updated"));
		}
	}

	@Secured
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/departement/refuser/justification")
	public Response RefuserJustification(@QueryParam("numero_absence") int numero_absence,
			@QueryParam("numero_justification") int numero_justification)
	{
		if (DAO_Justification.SetJustificationState(Etat_Demande.refuse, numero_absence, numero_justification))
		{
			return Utility.Response(Status.OK, MessageReader.GetNode("justification_denied"));
		} else
		{
			return Utility.Response(Status.NOT_MODIFIED, MessageReader.GetNode("justification_not_updated"));
		}
	}

	@Secured
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/departement/valider/justification")
	public Response ValiderJustification(@QueryParam("numero_absence") int numero_absence,
			@QueryParam("numero_justification") int numero_justification)
	{
		if (DAO_Justification.SetJustificationState(Etat_Demande.valide, numero_absence, numero_justification))
		{
			return Utility.Response(Status.OK, MessageReader.GetNode("justification_accepted"));
		} else
		{
			return Utility.Response(Status.NOT_MODIFIED, MessageReader.GetNode("justification_not_updated"));
		}
	}

	@Secured
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/departement/valider/demande/seanceSupp")
	public Response ValiderSeanceSupp(@QueryParam("code_seance_supp") int code_seance_supp)
	{
		if (DAO_SeanceSupp.SetEtatDemande(Etat_Demande.valide, code_seance_supp))
		{
			SeanceSupp seanceSupp = DAO_SeanceSupp.GetSeanceSupp(code_seance_supp);
			Seance seance = DAO_Seance.GetSeanceByCode_Seance(seanceSupp.getCode_seance());
			Enseignant enseignant = DAO_Enseignant.GetEnseignantBySeance(seance);
			DAO_NotificationSeanceSupp.CreateNotificationSupp(code_seance_supp, enseignant.getId_utilisateur(),
					Etat_Demande.valide);
			return Utility.Response(Status.OK, MessageReader.GetNode("demand_accepted"));
		} else
		{
			return Utility.Response(Status.NOT_MODIFIED, MessageReader.GetNode("demand_not_updated"));
		}
	}

	@Secured
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/departement/refuser/demande/seanceSupp")
	public Response RefuserSeanceSupp(@QueryParam("code_seance_supp") int code_seance_supp)
	{
		if (DAO_SeanceSupp.SetEtatDemande(Etat_Demande.refuse, code_seance_supp))
		{
			SeanceSupp seanceSupp = DAO_SeanceSupp.GetSeanceSupp(code_seance_supp);
			Seance seance = DAO_Seance.GetSeanceByCode_Seance(seanceSupp.getCode_seance());
			Enseignant enseignant = DAO_Enseignant.GetEnseignantBySeance(seance);
			DAO_NotificationSeanceSupp.CreateNotificationSupp(code_seance_supp, enseignant.getId_utilisateur(),
					Etat_Demande.refuse);

			return Utility.Response(Status.OK, MessageReader.GetNode("demand_denied"));
		} else
		{
			return Utility.Response(Status.NOT_MODIFIED, MessageReader.GetNode("demand_not_updated"));
		}
	}

	@Secured
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/departement/valider/demande/changement")
	public Response ValiderChangementSeance(@QueryParam("code_seance") String code_seance)
	{
		if (DAO_ChangementSeance.SetEtatDemande(Etat_Demande.valide, code_seance)
				&& DAO_ChangementSeance.ChangerSeance(DAO_ChangementSeance.GetChangementSeance(code_seance)))
		{
			Seance seance = DAO_Seance.GetSeanceByCode_Seance(code_seance);
			Enseignant enseignant = DAO_Enseignant.GetEnseignantBySeance(seance);
			DAO_NotificationChangementSeance.CreateNotificationChangement(code_seance, enseignant.getId_utilisateur(),
					Etat_Demande.valide);
			return Utility.Response(Status.OK, MessageReader.GetNode("demand_accepted"));
		} else
		{
			return Utility.Response(Status.NOT_MODIFIED, MessageReader.GetNode("demand_not_updated"));
		}
	}

	@Secured
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/departement/refuser/demande/changement")
	public Response RefuserChangementSeance(@QueryParam("code_seance") String code_seance)
	{
		if (DAO_ChangementSeance.SetEtatDemande(Etat_Demande.refuse, code_seance))
		{
			Enseignant enseignant = DAO_Enseignant
					.GetEnseignantBySeance(DAO_Seance.GetSeanceByCode_Seance(code_seance));
			DAO_NotificationChangementSeance.CreateNotificationChangement(code_seance, enseignant.getId_utilisateur(),
					Etat_Demande.refuse);
			return Utility.Response(Status.OK, MessageReader.GetNode("demand_denied"));
		} else
		{
			return Utility.Response(Status.NOT_MODIFIED, MessageReader.GetNode("demand_not_updated"));
		}
	}

	@Secured
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/departement/valider/demande/congeAcademique")
	public Response ValiderCongeAcademique(@QueryParam("numero_conge_academique") int numero_conge_academique)
	{
		if (DAO_CongeAcademique.AcceptCongeAcademique(numero_conge_academique,
				DAO_CongeAcademique.GetCongeAcademiqueByCode(numero_conge_academique).getId_etudiant()))
		{
			return Utility.Response(Status.OK, MessageReader.GetNode("demand_accepted"));
		} else
		{
			return Utility.Response(Status.NOT_MODIFIED, MessageReader.GetNode("demand_not_updated"));
		}
	}

	@Secured
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/departement/refuser/demande/congeAcademique")
	public Response RefuserCongeAcademique(@QueryParam("numero_conge_academique") int numero_conge_academique)
	{
		if (DAO_CongeAcademique.RefuserCongeAcademique(numero_conge_academique,
				DAO_CongeAcademique.GetCongeAcademiqueByCode(numero_conge_academique).getId_etudiant()))
		{
			return Utility.Response(Status.OK, MessageReader.GetNode("demand_denied"));
		} else
		{
			return Utility.Response(Status.NOT_MODIFIED, MessageReader.GetNode("demand_not_updated"));
		}
	}

	@Secured
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/notification/setVue")
	public Response SetNotificationVue(@QueryParam("id_notification") int id_notification)
	{
		if (DAO_Notification.SetVue(id_notification, true))
		{
			return Utility.Response(Status.OK, MessageReader.GetNode("notification_updated"));
		} else
		{
			return Utility.Response(Status.NOT_MODIFIED, MessageReader.GetNode("notification_not_updated"));
		}
	}
}
