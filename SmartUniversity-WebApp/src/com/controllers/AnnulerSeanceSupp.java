package com.controllers;

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

import com.helpers.RequestResponse;

@WebServlet("/AnnulerSeanceSupp")
public class AnnulerSeanceSupp extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AnnulerSeanceSupp() 
    {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		HttpSession session = request.getSession();
		String token = session.getAttribute("token").toString();
		String message = "";
		boolean isDone = true;
		String code_seance = request.getParameter("code-seance");
		String code_seance_supp = request.getParameter("code-seance-supp").toString();
		
		Client client = ClientBuilder.newClient();
		WebTarget target = client.target("http://localhost:8080/SmartUniversity-API/api/delete/seance/supp/" + code_seance + "/" + code_seance_supp);
		Response apiResponse = target.request(MediaType.APPLICATION_JSON)
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + token).delete();

		RequestResponse requestResponse = apiResponse.readEntity(RequestResponse.class);

		if (apiResponse.getStatusInfo() == Status.OK)
		{
			message = requestResponse.getMessage();
		} else
		{
			isDone = false;
			message = requestResponse.getMessage();
		}
		
		ConsulterSeancesEnseignant.UpadteSeancesFromAPI(session);
		session.setAttribute("isDone", isDone);
		session.setAttribute("message", message);

		Redirect.SendRedirect(request, response, "/WEB-INF/espace_enseignant/consulter_seance_enseignant.jsp");
	}
}
