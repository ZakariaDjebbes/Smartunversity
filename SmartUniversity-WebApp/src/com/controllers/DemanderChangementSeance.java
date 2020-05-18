package com.controllers;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.Entity;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import com.dots.Dot_Create_ChangementSeance;
import com.helpers.RequestResponse;
import com.helpers.SeanceResponse;
import com.modele.Seance.Jour;

@WebServlet("/DemanderChangementSeance")
public class DemanderChangementSeance extends HttpServlet
{
	private static final long serialVersionUID = 1L;

	public DemanderChangementSeance()
	{
		super();
	}

	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		HttpSession session = request.getSession(false);
		String message = "";
		boolean isDone = true;
		String token = session.getAttribute("token").toString();
		ArrayList<SeanceResponse> seances = (ArrayList<SeanceResponse>) session.getAttribute("seances");

		String code_seance = request.getParameter("code-seance");
		SeanceResponse seance = SeanceResponse.GetByCodeSeance(seances, code_seance);
		String nouvelle_heure = request.getParameter("nouvelle-heure") != null ? request.getParameter("nouvelle-heure")
				: seance.getSeance().getHeure();
		String nouveau_jour_str = request.getParameter("noveau-jour");
		Jour nouveau_jour = nouveau_jour_str != null ? Jour.valueOf(request.getParameter("nouveau-jour"))
				: seance.getSeance().getJour();

		if (seance.getChangementSeance() != null)
		{
			isDone = false;
			message = "Une demande de changement existe déjà pour cette séance";
		}

		if (seance.getSeance().getJour().equals(nouveau_jour) && seance.getSeance().getHeure().equals(nouvelle_heure))
		{
			isDone = false;
			message = "Veuillez changer au moins le jour ou l'heure pour faire une demande de changement de séance";
		}

		if (isDone)
		{
			Dot_Create_ChangementSeance changementSeance = new Dot_Create_ChangementSeance(code_seance, nouveau_jour,
					nouvelle_heure);
			Client client = ClientBuilder.newClient();
			WebTarget target = client.target("http://localhost:8080/SmartUniversity-API/api/create/changementSeance");
			Response apiResponse = target.request(MediaType.APPLICATION_JSON)
					.header(HttpHeaders.AUTHORIZATION, "Bearer " + token).put(Entity.json(changementSeance));

			RequestResponse requestResponse = apiResponse.readEntity(RequestResponse.class);

			if (apiResponse.getStatusInfo() == Status.OK)
			{
				message = requestResponse.getMessage();
			} else
			{
				isDone = false;
				message = requestResponse.getMessage();
			}
		}

		ConsulterSeancesEnseignant.UpadteSeancesFromAPI(session);
		session.setAttribute("isDone", isDone);
		session.setAttribute("message", message);

		Redirect.SendRedirect(request, response, "/WEB-INF/espace_enseignant/consulter_seance_enseignant.jsp");
	}
}
