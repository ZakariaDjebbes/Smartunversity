package com.controllers.etudiant;

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
@WebServlet("/User/AnnulerCongeAcademique")
public class AnnulerCongeAcademique extends HttpServlet
{
	private static final long serialVersionUID = 1L;

	public AnnulerCongeAcademique()
	{
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		HttpSession session = request.getSession(false);
		String token = session.getAttribute("token").toString();
		int numero_conge_academique = Integer.parseInt(request.getParameter("numero-conge-academique"));
		boolean isDone = true;
		String message = "";
		
		Client client = ClientBuilder.newClient();
		WebTarget target = client.target(
				"http://localhost:8080/SmartUniversity-API/api/delete/congeAcademique")
				.queryParam("numero_conge_academique",  numero_conge_academique);
		Response apiResponse = target.request(MediaType.APPLICATION_JSON)
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + token).delete();
		RequestResponse requestResponse = RequestResponse.GetRequestResponse(apiResponse);
		
		if (apiResponse.getStatusInfo() == Status.OK)
		{
			message = requestResponse.getMessage_fr();
		}
		else 
		{
			message = requestResponse.getMessage_fr();
			isDone = false;
		}	
		
		session.setAttribute("isDone", isDone);
		session.setAttribute("message", message);
		Redirect.SendRedirect(request, response, "/User/ConsulterCongeAcademique");	
	}
}