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

@WebServlet("/User/SupprimerCompteAdmin")
public class SupprimerCompteAdmin extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
       
    public SupprimerCompteAdmin() 
    {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		HttpSession session = request.getSession(false);
		String message = "";
		boolean isDone = true;
		String delete = request.getParameter("delete");
		int id_utilisateur = Integer.parseInt(request.getParameter("id_utilisateur"));
		String token = session.getAttribute("token").toString();
		Client client = ClientBuilder.newClient();
		WebTarget target = client.target("http://localhost:8080/SmartUniversity-API/api/delete/utilisateur/" + id_utilisateur);
		Response apiResponse = target.request().header(HttpHeaders.AUTHORIZATION, "Bearer "+token).delete();
		if (apiResponse.getStatusInfo() != Status.OK)
		{
			isDone = false;
		}
		RequestResponse requestResponse = apiResponse.readEntity(RequestResponse.class);		
		message = requestResponse.getMessage_fr();
		session.setAttribute("message", message);
		session.setAttribute("isDone", isDone);
		if(delete.equals("enseignant"))
		{
			Redirect.SendRedirect(request, response, "/User/ConsulterListeEnseignantsAdmin");
		}
		else 
		{
			Redirect.SendRedirect(request, response, "/User/ConsulterListeEtudiantsAdmin");
		}
	}
}
