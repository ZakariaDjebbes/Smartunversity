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
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import com.controllers.Redirect;
import com.helpers.RequestResponse;
import com.helpers.SeanceDepartementResponse;

@WebServlet("/User/DesaffecterSeance")
public class DesaffecterSeance extends HttpServlet 
{
	private static final long serialVersionUID = 1L;

    public DesaffecterSeance() 
    {
        super();
    }


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		HttpSession session = request.getSession(false);
		String token = session.getAttribute("token").toString();
		SeanceDepartementResponse seance = (SeanceDepartementResponse) session.getAttribute("seanceDepartement");
		boolean isDone = true;
		String message = "";
		String code_seance = seance.getSeance().getCode_seance();
		
		Client client = ClientBuilder.newClient();
		WebTarget target = client.target(
				"http://localhost:8080/SmartUniversity-API/api/delete/departement/desaffecterSeance")
				.queryParam("code_seance",  code_seance);
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
		ConsulterSeancesChefDepartement.UpdateSeancesDepartementFromAPI(session);
		Redirect.SendRedirect(request, response, "/User/ConsulterSeanceChefDepartement?code-seance=" + code_seance);	
	}
}
