package com.controllers.enseignant;

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
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import com.controllers.Redirect;
import com.helpers.RequestResponse;


@WebServlet("/User/SupprimerAbsence")
public class SupprimerAbsence extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public SupprimerAbsence() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		HttpSession session = request.getSession();
		String token = session.getAttribute("token").toString();
		String message = "";
		boolean isDone = true;
		String numero_absence = request.getParameter("numero-absence");
		String link = request.getParameter("to");
		System.out.println(link);
		Client client = ClientBuilder.newClient();
		WebTarget target = client.target("http://localhost:8080/SmartUniversity-API/api/delete/absence/" + numero_absence);
		Response apiResponse = target.request(MediaType.APPLICATION_JSON)
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + token).delete();

		RequestResponse requestResponse = apiResponse.readEntity(RequestResponse.class);

		if (apiResponse.getStatusInfo() == Status.OK)
		{
			message = requestResponse.getMessage_fr();
		} else
		{
			isDone = false;
			message = requestResponse.getMessage_fr();
		}
		
		ConsulterSeancesEnseignant.UpadteSeancesFromAPI(session);
		session.setAttribute("isDone", isDone);
		session.setAttribute("message", message);

		if(link == null)
		{
			Redirect.SendRedirect(request, response, "/WEB-INF/espace_enseignant/consulter_seances_enseignant.jsp");
		}
		else 
		{
			Redirect.SendRedirect(request, response, link);
		}

	}
}
