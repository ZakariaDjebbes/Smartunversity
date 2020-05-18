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
import javax.ws.rs.client.Entity;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import com.dots.Dot_Create_SeanceSupp;
import com.helpers.RequestResponse;
import com.modele.Seance.Jour;

@WebServlet("/DemanderSeanceSupp")
public class DemanderSeanceSupp extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public DemanderSeanceSupp() 
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
		String heure = request.getParameter("heure-supp");
		Jour jour = Jour.valueOf(request.getParameter("jour-supp"));
		
		Dot_Create_SeanceSupp seanceSupp = new Dot_Create_SeanceSupp(code_seance, jour, heure);
		Client client = ClientBuilder.newClient();
		WebTarget target = client.target("http://localhost:8080/SmartUniversity-API/api/create/seance/supp");
		Response apiResponse = target.request(MediaType.APPLICATION_JSON)
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + token).put(Entity.json(seanceSupp));

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
