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
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import com.controllers.Redirect;
import com.helpers.RequestResponse;
import com.modele.Etudiant.Annee;
import com.modele.Etudiant.Specialite;

@WebServlet("/User/SupprimerSeanceAdmin")
public class SupprimerSeanceAdmin extends HttpServlet
{
	private static final long serialVersionUID = 1L;

	public SupprimerSeanceAdmin()
	{
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		HttpSession session = request.getSession(false);
		String message = "";
		boolean isDone = true;
		String code_seance = request.getParameter("code_seance");
		Annee annee = Annee.valueOf(request.getParameter("annee"));
		Specialite specialite = Specialite.valueOf(request.getParameter("specialite"));
		String token = session.getAttribute("token").toString();
		Client client = ClientBuilder.newClient();
		WebTarget target = client.target("http://localhost:8080/SmartUniversity-API/api/delete/seance")
				.queryParam("code_seance", code_seance);
		Response apiResponse = target.request().header(HttpHeaders.AUTHORIZATION, "Bearer "+token).delete();
		if (apiResponse.getStatusInfo() != Status.OK)
		{
			isDone = false;
		}
		RequestResponse requestResponse = apiResponse.readEntity(RequestResponse.class);		
		message = requestResponse.getMessage_fr();
		session.setAttribute("message", message);
		session.setAttribute("isDone", isDone);
		Redirect.SendRedirect(request, response, "/User/ConsulterSeancesAdmin?annee=" + annee + "&specialite=" + specialite);
	}
}
