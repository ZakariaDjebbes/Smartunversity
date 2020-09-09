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
import com.data.DAO_Justification;
import com.data.DAO_Module;
import com.data.DAO_Notification;
import com.data.DAO_QR;
import com.data.DAO_Seance;
import com.data.DAO_SeanceSupp;
import com.data.DAO_User;
import com.jsonReaders.MessageReader;
import com.rest.annotations.Secured;
import com.rest.exceptions.RequestNotValidException;
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

		if (!isDone)
		{
			throw new RequestNotValidException(Status.BAD_REQUEST, MessageReader.GetNode("user_not_exist"));
		}

		return Utility.Response(Status.OK, MessageReader.GetNode("profile_deleted"));
	}

	@DELETE
	@Secured
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/absence/{numero_absence}")
	public Response DeleteAbsenceByNumero(@PathParam("numero_absence") int numero_absence)
	{
		if (!DAO_Absence.DeleteAbsenceByNumero(numero_absence))
		{
			throw new RequestNotValidException(Status.BAD_REQUEST, MessageReader.GetNode("absence_not_exist"));
		} else
		{
			return Utility.Response(Status.OK, MessageReader.GetNode("absence_deleted"));
		}
	}

	@DELETE
	@Secured
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/changementSeance/{code_seance}")
	public Response DeleteChangementSeance(@PathParam("code_seance") String code_seance)
	{
		boolean isDone = DAO_ChangementSeance.DeleteChangementSeance(code_seance);

		if (!isDone)
		{
			throw new RequestNotValidException(Status.BAD_REQUEST, MessageReader.GetNode("session_not_exist"));
		}

		return Utility.Response(Status.OK, MessageReader.GetNode("change_request_deleted"));
	}

	@DELETE
	@Secured
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/seance/supp/{code_seance}/{code_seance_supp}")
	public Response DeleteSeanceSupp(@PathParam("code_seance") String code_seance,
			@PathParam("code_seance_supp") int code_seance_supp)
	{
		boolean isDone = DAO_SeanceSupp.DeleteSeanceSupp(code_seance, code_seance_supp);

		if (!isDone)
		{
			throw new RequestNotValidException(Status.BAD_REQUEST, MessageReader.GetNode("additional_session_not_exist"));
		}

		return Utility.Response(Status.OK, MessageReader.GetNode("additional_session_request_deleted"));
	}

	@DELETE
	@Secured
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/departement/desaffecterSeance")
	public Response DesaffecterSeance(@QueryParam("code_seance") String code_seance)
	{
		boolean isDone = DAO_Enseignement.DesaffecterSeance(code_seance);

		if (!isDone)
		{
			throw new RequestNotValidException(Status.BAD_REQUEST, MessageReader.GetNode("session_not_exist"));
		}

		return Utility.Response(Status.OK, MessageReader.GetNode("session_cleared"));
	}

	@DELETE
	@Secured
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/congeAcademique")
	public Response DesaffecterSeance(@QueryParam("numero_conge_academique") int numero_conge_academique)
	{
		boolean isDone = DAO_CongeAcademique.DeleteCongeAcademique(numero_conge_academique);

		if (!isDone)
		{
			throw new RequestNotValidException(Status.BAD_REQUEST, MessageReader.GetNode("academic_leave_not_exist"));
		}

		return Utility.Response(Status.OK, MessageReader.GetNode("academic_leave_request_deleted"));
	}

	@DELETE
	@Secured
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/module")
	public Response DeleteModule(@QueryParam("code_module") String code_module)
	{
		boolean isDone = DAO_Module.DeleteModule(code_module);

		if (!isDone)
		{
			throw new RequestNotValidException(Status.BAD_REQUEST, MessageReader.GetNode("module_not_exist"));
		}

		return Utility.Response(Status.OK, MessageReader.GetNode("module_deleted"));
	}

	@DELETE
	@Secured
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/seance")
	public Response DeleteSeance(@QueryParam("code_seance") String code_seance)
	{
		boolean isDone = DAO_Seance.DeleteSeance(code_seance);

		if (!isDone)
		{
			throw new RequestNotValidException(Status.BAD_REQUEST, MessageReader.GetNode("session_not_deleted"));
		}

		return Utility.Response(Status.OK, MessageReader.GetNode("session_deleted"));
	}

	@DELETE
	@Secured
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/notification")
	public Response DeleteNotification(@QueryParam("id_notification") int id_notification)
	{
		if (DAO_Notification.GetNotification(id_notification) == null)
			throw new RequestNotValidException(Status.BAD_REQUEST, MessageReader.GetNode("notification_not_exist"));

		boolean isDone = DAO_Notification.DeleteNotification(id_notification);

		if (!isDone)
		{
			throw new RequestNotValidException(Status.BAD_REQUEST, MessageReader.GetNode("notification_not_deleted"));
		}

		return Utility.Response(Status.OK, MessageReader.GetNode("notification_deleted"));
	}

	@DELETE
	@Secured
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/justification/android/{numero_absence}/{numero_justification}")
	public Response DeleteJustification(@PathParam("numero_absence") int numero_absence,
			@PathParam("numero_justification") int numero_justification)
	{
		boolean isDone = DAO_Justification.DeleteJustificationByNumero(numero_absence, numero_justification);

		if (!isDone)
		{
			throw new RequestNotValidException(Status.BAD_REQUEST, MessageReader.GetNode("justification_not_deleted"));
		} else
			return Utility.Response(Status.OK, MessageReader.GetNode("justification_deleted"));

	}

	@DELETE
	@Secured
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/congeAcademique/android/{numero_conge_academique}")
	public Response DeleteCongeAcademique(@PathParam("numero_conge_academique") int numero_conge_academique)
	{
		boolean isDone = DAO_CongeAcademique.DeleteCongeAcademique(numero_conge_academique);

		if (!isDone)
		{
			throw new RequestNotValidException(Status.BAD_REQUEST, null);
		} else
			return Utility.Response(Status.OK, null);
	}

	@DELETE
	@Secured
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/qr/{code_seance}")
	public Response DeleteCodeQR(@PathParam("code_seance") String code_seance)
	{
		boolean isDone = DAO_QR.DeleteCodeQR(code_seance);

		if (!isDone)
		{
			throw new RequestNotValidException(Status.BAD_REQUEST, null);
		} else
			return Utility.Response(Status.OK, null);

	}
}
