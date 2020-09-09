package com.rest.services;

import javax.mail.MessagingException;
import javax.ws.rs.Consumes;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import com.data.DAO_Absence;
import com.data.DAO_ChangementSeance;
import com.data.DAO_ChefDepartement;
import com.data.DAO_Enseignant;
import com.data.DAO_Enseignement;
import com.data.DAO_Etudiant;
import com.data.DAO_Module;
import com.data.DAO_ReponsableFormation;
import com.data.DAO_Seance;
import com.data.DAO_SeanceSupp;
import com.data.DAO_User;
import com.dots.Dot_Affecter_Seance;
import com.dots.Dot_Create_Absence;
import com.dots.Dot_Create_ChangementSeance;
import com.dots.Dot_Create_Enseignant;
import com.dots.Dot_Create_Etudiant;
import com.dots.Dot_Create_Seance;
import com.dots.Dot_Create_SeanceSupp;
import com.jsonReaders.MessageReader;
import com.mailer.Mailer;
import com.modele.Etudiant;
import com.modele.Module;
import com.modele.Utilisateur;
import com.modele.Etudiant.Annee;
import com.modele.Etudiant.Specialite;
import com.rest.annotations.Secured;
import com.rest.exceptions.RequestNotValidException;
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
		if (DAO_Absence.CreateAbsence(absence))
		{
			return Utility.Response(Status.OK, MessageReader.GetNode("absence_created"));
		} else
		{
			return Utility.Response(Status.BAD_REQUEST, MessageReader.GetNode("absence_not_created"));
		}
	}

	@PUT
	@Secured
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/seance")
	public Response CreateSeance(Dot_Create_Seance seance)
	{
		if (DAO_Seance.CreateSeance(seance))
		{
			return Utility.Response(Status.OK, MessageReader.GetNode("session_created"));
		} else
		{
			return Utility.Response(Status.BAD_REQUEST, MessageReader.GetNode("session_not_created"));
		}
	}

	@PUT
	@Secured
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/module")
	public Response CreateModule(Module module)
	{
		if (DAO_Module.CreateMoudle(module))
		{
			return Utility.Response(Status.OK, MessageReader.GetNode("module_created"));
		} else
		{
			return Utility.Response(Status.BAD_REQUEST, MessageReader.GetNode("module_not_created"));
		}
	}

	@PUT
	@Secured
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/etudiant")
	public Response CreateEtudiant(Dot_Create_Etudiant dot_etudiant)
	{
		dot_etudiant.Validate();
		
		int id_etudiant = DAO_Etudiant.CreateEtudiant(dot_etudiant);

		if (id_etudiant != -1)
		{
			Etudiant etudiant = DAO_Etudiant.GetEtudiantById(id_etudiant);
			String email = etudiant.getEmail();
			String mailBody = String.format(
					"<h1>Bonjour %s %s</h1>"
							+ "<p>Votre compte du système de gestion d'absences de la faculté ntic a été créé." + "<br>"
							+ "<p><b>Votre nom d'utilisateur: </b>%s</p>" + "<p><b>Votre mot de passe: </b>%s</p>"
							+ "<p>Nous vous souhaitons une bonne journée,</p>" + "<br>"
							+ "<p>Cordialement, L'administration.</p>",
					etudiant.getNom(), etudiant.getPrenom(), etudiant.getUser(), etudiant.getPass());

			String mailSubject = "Votre compte pour la faculté NTIC a été créé!";
			try
			{
				Mailer.SendMail(email, mailSubject, mailBody);
			} catch (MessagingException e)
			{
				System.out.println("Erreur dans l'envoi du mail >>> " + e.getMessage());
			}

			return Utility.Response(Status.OK, MessageReader.GetNode("student_created"));
		} else
		{
			return Utility.Response(Status.BAD_REQUEST, MessageReader.GetNode("student_not_created"));
		}
	}

	@PUT
	@Secured
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/enseignant")
	public Response CreateEnseignant(Dot_Create_Enseignant dot_enseignant, @QueryParam("annee") Annee annee,
			@QueryParam("specialite") Specialite specialite)
	{
		dot_enseignant.Validate();
		int id_utilisateur = 0;
		Utilisateur utilisateur = null;
		switch (dot_enseignant.getDot_Create_Utilisateur().getUser_type())
		{
		case enseignant:
			id_utilisateur = DAO_Enseignant.CreateEnseignant(dot_enseignant);
			utilisateur = DAO_User.GetUserByID(id_utilisateur);

			break;
		case chefDepartement:
			id_utilisateur = DAO_ChefDepartement.CreateChefDepartement(DAO_Enseignant.CreateEnseignant(dot_enseignant));
			utilisateur = DAO_User.GetUserByID(id_utilisateur);
			break;
		case responsableFormation:
			id_utilisateur = DAO_ReponsableFormation
					.CreateresponsableFormation(DAO_Enseignant.CreateEnseignant(dot_enseignant), annee, specialite);
			utilisateur = DAO_User.GetUserByID(id_utilisateur);
			break;
		default:
			throw new RequestNotValidException(Status.BAD_REQUEST, MessageReader.GetNode("teacher_type_not_exist"));
		}

		if (id_utilisateur != -1)
		{
			String email = utilisateur.getEmail();
			String mailBody = String.format("<h1>Bonjour %s %s</h1>"
					+ "<p>Votre compte enseignant du système de gestion d'absences de la faculté ntic a été créé."
					+ "<br>" + "<p><b>Votre nom d'utilisateur: </b>%s</p>" + "<p><b>Votre mot de passe: </b>%s</p>"
					+ "<p>Nous vous souhaitons une bonne journée,</p>" + "<br>"
					+ "<p>Cordialement, L'administration.</p>", utilisateur.getNom(), utilisateur.getPrenom(),
					utilisateur.getUser(), utilisateur.getPass());

			String mailSubject = "Votre compte pour la faculté NTIC a été créé!";
			try
			{
				Mailer.SendMail(email, mailSubject, mailBody);
			} catch (MessagingException e)
			{
				System.out.println("Erreur dans l'envoi du mail >>> " + e.getMessage());
			}

			return Utility.Response(Status.OK, MessageReader.GetNode("teacher_created"));
		} else
		{
			return Utility.Response(Status.BAD_REQUEST, MessageReader.GetNode("teacher_not_created"));
		}
	}

	@PUT
	@Secured
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/changementSeance")
	public Response CreateChangementSenace(Dot_Create_ChangementSeance changementSeance)
	{
		// validation
		changementSeance.Validate();

		// create
		if (DAO_ChangementSeance.CreateChangementSeance(changementSeance))
		{
			return Utility.Response(Status.OK, MessageReader.GetNode("change_request_created"));
		} else
		{
			return Utility.Response(Status.BAD_REQUEST, MessageReader.GetNode("change_request_not_created"));
		}
	}

	@PUT
	@Secured
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/seance/supp")
	public Response createSeanceSupp(Dot_Create_SeanceSupp seanceSupp)
	{
		// validation
		seanceSupp.Validate();

		// create
		if (DAO_SeanceSupp.CreateSeanceSupp(seanceSupp))
		{
			return Utility.Response(Status.OK, MessageReader.GetNode("additional_session_request_created"));
		} else
		{
			return Utility.Response(Status.BAD_REQUEST, MessageReader.GetNode("additional_session_request_not_created"));
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

		if (DAO_Enseignement.AffecterSeance(dot_Affecter_Seance))
		{
			return Utility.Response(Status.OK, MessageReader.GetNode("teacher_assigned"));
		} else
		{
			return Utility.Response(Status.BAD_REQUEST, MessageReader.GetNode("teacher_not_assigned"));
		}
	}
}
