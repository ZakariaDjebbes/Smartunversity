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
import com.utility.Utility;

@WebServlet("/User/SupprimerDemandeChangement")
public class SupprimerDemandeChangement extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public SupprimerDemandeChangement() 
	{
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		HttpSession session = request.getSession(false);
		String code_seance = request.getParameter("code-seance");
		String token = session.getAttribute("token").toString();
		String message = "";
		boolean isDone = false;
		
		Client client = ClientBuilder.newClient();
		WebTarget target = client.target("http://localhost:8080/SmartUniversity-API/api/delete/changementSeance/" + code_seance);
		Response apiResponse = target.request(MediaType.APPLICATION_JSON)
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + token)
				.delete();
		
		RequestResponse requestResponse = apiResponse.readEntity(RequestResponse.class);
		
		if (apiResponse.getStatusInfo() == Status.OK)
		{
			isDone = true;
			message = requestResponse.getMessage(Utility.GetValueOfCookieWithName(request, "lang"));
		} else
		{
			message = requestResponse.getMessage(Utility.GetValueOfCookieWithName(request, "lang"));
		}
		
		ConsulterSeancesEnseignant.UpadteSeancesFromAPI(session);
		session.setAttribute("message", message);
		session.setAttribute("isDone", isDone);
		
		Redirect.SendRedirect(request, response, "/User/ConsulterSeanceEnseignant?code-seance=" + code_seance);
	}
}
