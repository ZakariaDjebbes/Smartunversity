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

import com.data.DAO_Absence;
import com.data.DAO_Admin;
import com.data.DAO_ChangementSeance;
import com.data.DAO_ChefDepartement;
import com.data.DAO_CongeAcademique;
import com.data.DAO_Enseignant;
import com.data.DAO_Etudiant;
import com.data.DAO_Justification;
import com.data.DAO_Module;
import com.data.DAO_NotificationChangementSeance;
import com.data.DAO_NotificationSeanceSupp;
import com.data.DAO_ReponsableFormation;
import com.data.DAO_Seance;
import com.data.DAO_SeanceSupp;
import com.data.DAO_User;
import com.helpers.AbsenceDepartementResponse;
import com.helpers.DemandeChangementSeanceResponse;
import com.helpers.DemandeCongeAcademiqueResponse;
import com.helpers.DemandeSeanceSuppResponse;
import com.helpers.DemandesDepartementResponse;
import com.helpers.EnseignantDisponibleResponse;
import com.helpers.EtudiantResponse;
import com.helpers.NotificationResponse;
import com.helpers.SeanceDepartementResponse;
import com.helpers.SeanceResponse;
import com.modele.Absence;
import com.modele.ChangementSeance;
import com.modele.CongeAcademique;
import com.modele.Enseignant;
import com.modele.Etudiant;
import com.modele.Etudiant.Annee;
import com.modele.Etudiant.Specialite;
import com.modele.Justification;
import com.modele.Module;
import com.modele.NotificationChangementSeance;
import com.modele.NotificationSeanceSupp;
import com.modele.Seance;
import com.modele.Seance.Jour;
import com.modele.SeanceSupp;
import com.modele.Utilisateur;
import com.modele.Utilisateur.Code_Departement;
import com.rest.annotations.Secured;
import com.rest.exceptions.RequestNotValidException;
import com.utility.JsonReader;
import com.utility.Utility;

@Path("/get")
public class Get
{
	@GET
	@Secured
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/user/{id}")
	public Response GetUserByID(@PathParam("id") int id)
	{
		Utilisateur utilisateur = DAO_User.GetUserByID(id);

		if (utilisateur == null)
		{
			throw new RequestNotValidException(Status.NOT_FOUND,
					JsonReader.GetNode("user_not_exist"));
		}

		switch (utilisateur.getUser_type())
		{
		case enseignant:
			utilisateur = DAO_Enseignant.GetEnseignant(utilisateur);
			break;
		case chefDepartement:
			utilisateur = DAO_ChefDepartement.GetChefDepartement(utilisateur);
			break;
		case etudiant:
			utilisateur = DAO_Etudiant.GetEtudiantById(id);
			break;
		case admin:
			utilisateur = DAO_Admin.GetAdminById(id);
			break;
		case responsableFormation:
			utilisateur = DAO_ReponsableFormation.GetReponsableFormation(utilisateur);
			break;
		default:
			break;
		}

		return Utility.Response(Status.OK, utilisateur);
	}

	@GET
	@Secured
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/seances/{id}")
	public Response GetSeancesEnseignant(@PathParam("id") int id)
	{
		ArrayList<Seance> seances = DAO_Seance.GetSeancesEnseignantByID(id);

		if (seances.size() == 0)
		{
			return Utility.Response(Status.NOT_FOUND,
					JsonReader.GetNode("sessions_teacher_not_exist"));
		}

		return Utility.Response(Status.OK, seances);
	}
	
	@GET
	@Secured
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/enseignant")
	public Response GetEnseignant(@QueryParam("code_seance") String code_seance)
	{
		Enseignant enseignant = DAO_Enseignant.GetEnseignantBySeance(DAO_Seance.GetSeanceByCode_Seance(code_seance));

		if (enseignant == null)
		{
			return Utility.Response(Status.NOT_FOUND,
					JsonReader.GetNode("session_not_exist"));
		}

		return Utility.Response(Status.OK, enseignant);
	}

	@GET
	@Secured
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/seances/full/{id_enseignant}")
	public Response GetSeancesCompleteEnseignant(@PathParam("id_enseignant") int id_enseignant)
	{
		ArrayList<SeanceResponse> response = new ArrayList<SeanceResponse>();

		ArrayList<Seance> seances = DAO_Seance.GetSeancesEnseignantByID(id_enseignant);

		if (seances.size() == 0)
		{
			return Utility.Response(Status.NOT_FOUND,
					JsonReader.GetNode("sessions_teacher_not_exist"));
		}

		for (Seance seance : seances)
		{
			SeanceResponse seanceResponse = new SeanceResponse();
			seanceResponse.setSeance(seance);

			// getting the module of seance
			Module module = DAO_Module.GetMouleByCode(seance.getCode_module());

			if (module == null)
			{ // if no module for this seance is found and error should be thrown
				return Utility.Response(Status.NOT_FOUND,
						JsonReader.GetNode("internal_error"));
			}

			seanceResponse.setModule(module);

			// getting changement demand is it exists
			ChangementSeance changementSeance = DAO_ChangementSeance.GetChangementSeance(seance.getCode_seance());

			// if it exists its sent, else send nothing...
			if (changementSeance != null)
			{
				seanceResponse.setChangementSeance(changementSeance);
			}

			// getting seances supp
			ArrayList<SeanceSupp> seancesSupp = DAO_SeanceSupp.GetSeancesSupp(seance.getCode_seance());

			if (seancesSupp.size() == 0)
			{
				seancesSupp = null;
			}

			seanceResponse.setSeancesSupp(seancesSupp);

			// getting students of this seance
			ArrayList<EtudiantResponse> etudiantsResponse = new ArrayList<EtudiantResponse>();
			ArrayList<Etudiant> etudiants = new ArrayList<Etudiant>();

			etudiants = DAO_Etudiant.GetEtudiants(seance.getAnnee(), seance.getSpecialite(), seance.getGroupe());

			// a seance without students is technically possible

			if (etudiants.size() == 0)
			{
				// an empty list shouldn't be created for studens, nothing is sent
				etudiants = null;
			} else
			{
				// foreach student, get the absences
				for (Etudiant etudiant : etudiants)
				{
					// getting absences
					ArrayList<Absence> absences = DAO_Absence.GetAbsencesOfStudentBySeance(seance.getCode_seance(),
							etudiant.getId_utilisateur());
					EtudiantResponse etudiantResponse = Utility.GetEtudiantResponse(absences, etudiant);

					// set the sudent
					etudiantsResponse.add(etudiantResponse);
				}
				// set the students..
				seanceResponse.setEtudiants(etudiantsResponse);
			}
			response.add(seanceResponse);
		}

		return Utility.Response(Status.OK, response);
	}

	@GET
	@Secured
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/module/{code_module}")
	public Response GetModule(@PathParam("code_module") String code_module)
	{
		Module module = DAO_Module.GetMouleByCode(code_module);

		if (module == null)
		{
			return Utility.Response(Status.NOT_FOUND,
					JsonReader.GetNode("module_not_exist"));
		} else
		{
			return Utility.Response(Status.OK, module);
		}
	}

	@GET
	@Secured
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/etudiants")
	public Response GetEtudiantsOfSeance(@QueryParam("annee") Annee annee,
			@QueryParam("specialite") Specialite specialite, @QueryParam("groupe") int groupe)
	{
		ArrayList<Etudiant> etudiants = DAO_Etudiant.GetEtudiants(annee, specialite, groupe);

		if (etudiants.size() == 0)
		{
			return Utility.Response(Status.NOT_FOUND,
					JsonReader.GetNode("students_year_speciality_group_not_exist"));
		}

		return Utility.Response(Status.OK, etudiants);
	}

	@GET
	@Secured
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/absences")
	public Response GetAbsencesByEtudiant(@QueryParam("code_seance") String code_seance,
			@QueryParam("id_etudiant") int id_etudiant)
	{
		ArrayList<Absence> absences = DAO_Absence.GetAbsencesOfStudentBySeance(code_seance, id_etudiant);

		if (absences.size() == 0)
		{
			return Utility.Response(Status.NOT_FOUND,
					JsonReader.GetNode("absences_student_not_exist"));
		}

		return Utility.Response(Status.OK, absences);
	}

	@GET
	@Secured
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/seances")
	public Response GetSeancesByDepartement(@QueryParam("code_departement") Code_Departement code_departement)
	{
		ArrayList<SeanceDepartementResponse> seances = new ArrayList<SeanceDepartementResponse>();

		try
		{
			seances = DAO_Seance.GetSeancesByCode_Departement(code_departement);
		} catch (Exception e)
		{
			e.printStackTrace();
		}

		if (seances.size() == 0)
		{
			return Utility.Response(Status.NOT_FOUND,
					JsonReader.GetNode("sessions_departement_not_exist"));
		}

		return Utility.Response(Status.OK, seances);
	}

	@GET
	@Secured
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/justification")
	public Response GetJustification(@QueryParam("numero_absence") int numero_absence,
			@QueryParam("numero_justification") int numero_justification)
	{
		Justification justification = DAO_Justification.GetJustificationByAbsence(numero_absence, numero_justification);

		if (justification == null)
		{
			return Utility.Response(Status.NOT_FOUND,
					JsonReader.GetNode("justifcations_not_exist"));
		}

		return Utility.Response(Status.OK, justification);
	}

	@GET
	@Secured
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/enseignants/departement")
	public Response GetEnseignantForSeanceAndDepartement(
			@QueryParam("code_departement") Code_Departement code_departement, @QueryParam("jour") Jour jour,
			@QueryParam("heure") String heure)
	{
		ArrayList<EnseignantDisponibleResponse> enseignants = new ArrayList<EnseignantDisponibleResponse>();

		try
		{
			// TODO UN enseignant du département X peut il enseigné une matiere du
			// département Y
			enseignants = DAO_Enseignant.GetEnseignantsDisponiblesForSeance(code_departement, jour, heure);
		} catch (Exception e)
		{
			e.printStackTrace();
		}

		if (enseignants.size() == 0)
		{
			return Utility.Response(Status.NOT_FOUND, JsonReader.GetNode("teachers_not_exist"));
		}

		return Utility.Response(Status.OK, enseignants);
	}

	@GET
	@Secured
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/absences/departement")
	public Response GetAbsencesOfDepartement(@QueryParam("code_departement") Code_Departement code_departement)
	{
		ArrayList<AbsenceDepartementResponse> response = new ArrayList<AbsenceDepartementResponse>();
		ArrayList<Absence> absences = DAO_Absence.GetAbsencesByDepartement(code_departement);

		for (Absence absence : absences)
		{
			ArrayList<Justification> justifications = DAO_Justification
					.GetJustificationsByAbsence(absence.getNumero_absence());
			Etudiant etudiant = DAO_Etudiant.GetEtudiantById(absence.getId_etudiant());
			Seance seance = DAO_Seance.GetSeanceByCode_Seance(absence.getCode_seance());
			Module module = DAO_Module.GetMouleByCode(seance.getCode_module());
			AbsenceDepartementResponse ar = new AbsenceDepartementResponse(absence, justifications, etudiant, seance,
					module);
			response.add(ar);
		}

		if (response.size() == 0)
		{
			return Utility.Response(Status.NOT_FOUND, JsonReader.GetNode("absences_departement_not_exist"));
		}

		return Utility.Response(Status.OK, response);
	}

	@GET
	@Secured
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/absence/departement")
	public Response GetAbsenceOfDepartement(@QueryParam("code_departement") Code_Departement code_departement,
			@QueryParam("numero_absence") int numero_absence)
	{
		AbsenceDepartementResponse response = null;
		ArrayList<Absence> absences = DAO_Absence.GetAbsencesByDepartement(code_departement);

		for (Absence absence : absences)
		{
			if (absence.getNumero_absence() == numero_absence)
			{
				ArrayList<Justification> justifications = DAO_Justification
						.GetJustificationsByAbsence(absence.getNumero_absence());
				Etudiant etudiant = DAO_Etudiant.GetEtudiantById(absence.getId_etudiant());
				Seance seance = DAO_Seance.GetSeanceByCode_Seance(absence.getCode_seance());
				Module module = DAO_Module.GetMouleByCode(seance.getCode_module());
				AbsenceDepartementResponse adr = new AbsenceDepartementResponse(absence, justifications, etudiant,
						seance, module);
				response = adr;
				break;
			}
		}

		if (response == null)
		{
			return Utility.Response(Status.NOT_FOUND,
					JsonReader.GetNode("absences_departement_not_exist"));
		}

		return Utility.Response(Status.OK, response);
	}

	@GET
	@Secured
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/demandes/departement")
	public Response GetDemandesOfDepartement(@QueryParam("code_departement") Code_Departement code_departement)
	{
		ArrayList<DemandeSeanceSuppResponse> demandesSeanceSupp = DAO_SeanceSupp
				.GetDemandesOfEnseignants(code_departement);
		ArrayList<DemandeChangementSeanceResponse> demandesChangement = DAO_ChangementSeance
				.GetChangementSeanceOfEnseignants(code_departement);
		ArrayList<DemandeCongeAcademiqueResponse> demandesEtudiant = DAO_CongeAcademique.GetDemandesCongeAcademiqueOfDepartement(code_departement);
		
		if (demandesChangement.size() == 0 && demandesSeanceSupp.size() == 0 && demandesEtudiant.size() == 0)
		{
			return Utility.Response(Status.NOT_FOUND,
					JsonReader.GetNode("demands_departement_not_exist"));
		}

		DemandesDepartementResponse response = new DemandesDepartementResponse(demandesSeanceSupp, demandesChangement,
				demandesEtudiant);
		return Utility.Response(Status.OK, response);
	}
	
	@GET
	@Secured
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/absences/etudiant")
	public Response GetAbsencesOfEtudiant(@QueryParam("id_etudiant") int id_etudiant)
	{
		ArrayList<Absence> absences = DAO_Absence.GetAbsencesOfEtudiant(id_etudiant);
		
		if(absences.size() == 0)
		{
			return Utility.Response(Status.NOT_FOUND,
					JsonReader.GetNode("absences_student_not_exist"));
		}

		ArrayList<AbsenceDepartementResponse> response = new ArrayList<AbsenceDepartementResponse>();
		Etudiant etudiant = DAO_Etudiant.GetEtudiantById(id_etudiant);

		for (Absence absence : absences)
		{
			Seance seance = DAO_Seance.GetSeanceByCode_Seance(absence.getCode_seance());
			Module module = DAO_Module.GetMouleByCode(seance.getCode_module());
			ArrayList<Justification> justifications = DAO_Justification.GetJustificationsByAbsence(absence.getNumero_absence());
			
			AbsenceDepartementResponse absenceDepartement = new AbsenceDepartementResponse(absence, justifications, etudiant, seance, module);
			response.add(absenceDepartement);
		}		
		
		return Utility.Response(Status.OK, response);
	}
	
	@GET
	@Secured
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/seances/etudiant")
	public Response GetSeancesOfEtudiant(@QueryParam("id_etudiant") int id_etudiant)
	{
		ArrayList<Seance> seances = DAO_Seance.GetSeancesByEtudiant(id_etudiant);
		
		if(seances.size() == 0)
		{
			return Utility.Response(Status.NOT_FOUND, JsonReader.GetNode("sessions_student_not_exist"));
		}
		
		ArrayList<SeanceResponse> response = new ArrayList<SeanceResponse>();
		
		for (Seance seance : seances)
		{
			Module module = DAO_Module.GetMouleByCode(seance.getCode_module());
			ArrayList<SeanceSupp> seancesSupp = DAO_SeanceSupp.GetValidSeancesSupp(seance.getCode_seance());
			
			SeanceResponse seanceResponse = new SeanceResponse(null, module, seance, null, seancesSupp);
			response.add(seanceResponse);
		}
		
		return Utility.Response(Status.OK, response);
	}
	
	@GET
	@Secured
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/demande/etudiant")
	public Response GetDemandeOfEtudiant(@QueryParam("id_etudiant") int id_etudiant)
	{
		CongeAcademique response = DAO_CongeAcademique.GetCongeAcademiqueByEtudiant(id_etudiant);
		
		if(response == null)
		{
			return Utility.Response(Status.NOT_FOUND, 
					JsonReader.GetNode("academic_leave_student_not_exist"));
		}
		
		return Utility.Response(Status.OK, response);
	}
	
	@GET
	@Secured
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/admin/etudiants")
	public Response GetAllEtudiants()
	{
		ArrayList<Etudiant> response = DAO_Etudiant.GetAllEtudiants();
		
		if(response == null || response.size() == 0)
		{
			return Utility.Response(Status.NOT_FOUND, 
					JsonReader.GetNode("students_not_exist"));
		}
		
		return Utility.Response(Status.OK, response);
	}
	
	@GET
	@Secured
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/admin/enseignants")
	public Response GetAllEnseignants()
	{
		ArrayList<Enseignant> enseignants = DAO_Enseignant.GetAllEnseignant();
		
		if(enseignants.size() == 0)
		{
			return Utility.Response(Status.NOT_FOUND, 
					JsonReader.GetNode("teachers_not_exist"));
		}

		ArrayList<Utilisateur> response = new ArrayList<Utilisateur>();
		response.addAll(enseignants);
		
		return Utility.Response(Status.OK, response);
	}
	
	@GET
	@Secured
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/admin/modules")
	public Response GetAllModules()
	{
		ArrayList<Module> modules = DAO_Module.GetAllModules();
		
		if(modules.size() == 0)
		{
			return Utility.Response(Status.NOT_FOUND, 
					JsonReader.GetNode("modules_not_exist"));
		}

		
		return Utility.Response(Status.OK, modules);
	}
	
	@GET
	@Secured
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/admin/seances")
	public Response GetAllSeances(@QueryParam("annee")Annee annee, @QueryParam("specialite")Specialite specialite)
	{
		ArrayList<SeanceResponse> seances = DAO_Seance.GetAllSeancesOfAnneeSpecialite(annee, specialite);
		
		if(seances.size() == 0)
		{
			return Utility.Response(Status.NOT_FOUND, 
					JsonReader.GetNode("seances_annee_specialite_not_exist"));
		}

		
		return Utility.Response(Status.OK, seances);
	}
	
	@GET
	@Secured
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/notification")
	public Response GetNotificationsOfUser(@QueryParam("id_utilisateur") int id_utilisateur)
	{
		ArrayList<NotificationChangementSeance> notificationsChangement = DAO_NotificationChangementSeance.GetNotificationsOfUser(id_utilisateur);
		ArrayList<NotificationSeanceSupp> notificationsSeanceSupp = DAO_NotificationSeanceSupp.GetNotificationsOfUser(id_utilisateur);
		
		if(notificationsChangement.size() == 0 && notificationsSeanceSupp.size() == 0)
		{
			throw new RequestNotValidException(Status.NOT_FOUND, JsonReader.GetNode("notifications_not_exist"));
		}
		
		NotificationResponse response = new NotificationResponse(notificationsSeanceSupp, notificationsChangement);

		return Utility.Response(Status.OK, response);
	}
}