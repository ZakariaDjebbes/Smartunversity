package com.controllers.chefDepartement;

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
import com.helpers.RequestResponse;
import com.utility.Utility;

@WebServlet("/User/RefuserJustification")
public class RefuserJustification extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
       
    public RefuserJustification() 
    {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		HttpSession session = request.getSession(false);
		String token = session.getAttribute("token").toString();
		int numero_justification = Integer.parseInt(request.getParameter("numero-justification"));
		int numero_asence = Integer.parseInt(request.getParameter("numero-absence"));
		boolean isDone = true;
		String message = "";
		
		Client client = ClientBuilder.newClient();
		WebTarget target = client.target(
				"http://localhost:8080/SmartUniversity-API/api/update/departement/refuser/justification")
				.queryParam("numero_absence", numero_asence)
				.queryParam("numero_justification", numero_justification);
				Response apiResponse = target.request(MediaType.APPLICATION_JSON)
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + token).post(Entity.json(null));
		RequestResponse requestResponse = RequestResponse.GetRequestResponse(apiResponse);
		
		if (!(apiResponse.getStatusInfo() == Status.OK))
		{
			isDone = false;
		}	
		

		message = requestResponse.getMessage(Utility.GetValueOfCookieWithName(request, "lang"));
		session.setAttribute("isDone", isDone);
		session.setAttribute("message", message);
		Redirect.SendRedirect(request, response, "/User/ConsulterAbsence?numero-absence=" + numero_asence + "&numero-justification=" + numero_justification);
	}
}
