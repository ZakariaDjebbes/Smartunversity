package com.controllers.admin;

import java.io.IOException;

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

import com.controllers.Redirect;
import com.dots.Dot_Create_Seance;
import com.helpers.RequestResponse;
import com.modele.Etudiant.Annee;
import com.modele.Etudiant.Specialite;
import com.modele.Seance.Jour;
import com.modele.Seance.Type_Seance;
import com.utility.Utility;

@WebServlet("/User/AjouterSeanceAdmin")
public class AjouterSeanceAdmin extends HttpServlet
{
	private static final long serialVersionUID = 1L;

	public AjouterSeanceAdmin()
	{
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		HttpSession session = request.getSession(false);
		String token = session.getAttribute("token").toString();
		Dot_Create_Seance seance = GetSeanceData(request);
		boolean isDone = true;
		String message = "";

		Client client = ClientBuilder.newClient();
		WebTarget target = client.target("http://localhost:8080/SmartUniversity-API/api/create/seance");
		Response apiResponse = target.request(MediaType.APPLICATION_JSON)
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + token).put(Entity.json(seance));

		RequestResponse requestResponse = RequestResponse.GetRequestResponse(apiResponse);

		if (!(apiResponse.getStatusInfo() == Status.OK))
		{
			isDone = false;
		}

		message = requestResponse.getMessage(Utility.GetValueOfCookieWithName(request, "lang"));
		session.setAttribute("isDone", isDone);
		session.setAttribute("message", message);
		Redirect.SendRedirect(request, response, "/User/ConsulterSeancesAdmin?annee=" + seance.getAnnee() + "&specialite=" + seance.getSpecialite());
	}

	private Dot_Create_Seance GetSeanceData(HttpServletRequest request)
	{
		String code_module = request.getParameter("module");
		Jour jour = Jour.valueOf(request.getParameter("jour"));
		Annee annee = Annee.valueOf(request.getParameter("annee"));
		Specialite specialite = Specialite.valueOf(request.getParameter("specialite"));
		int groupe = Integer.valueOf(request.getParameter("groupe"));
		Type_Seance type_seance = Type_Seance.valueOf(request.getParameter("type"));
		String heure = request.getParameter("heure");

		Dot_Create_Seance seance = new Dot_Create_Seance(code_module, jour, heure, annee, specialite, groupe,
				type_seance);
		return seance;
	}
}
