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

import com.helpers.RequestResponse;
import com.modele.CongeAcademique;
import com.modele.Etudiant;

@WebServlet("/User/ConsulterCongeAcademique")
public class ConsulterCongeAcademique extends HttpServlet
{
	private static final long serialVersionUID = 1L;

	public ConsulterCongeAcademique()
	{
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		HttpSession session = request.getSession(false);
		String token = session.getAttribute("token").toString();
		Etudiant etudiant = (Etudiant) session.getAttribute("utilisateur");
		
		Client client = ClientBuilder.newClient();
		WebTarget target = client.target(
				"http://localhost:8080/SmartUniversity-API/api/get/demande/etudiant")
				.queryParam("id_etudiant", etudiant.getId_utilisateur());
		Response apiResponse = target.request(MediaType.APPLICATION_JSON)
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + token).get();
		apiResponse.bufferEntity();
		RequestResponse requestResponse = RequestResponse.GetRequestResponse(apiResponse);
		
		CongeAcademique demandeConge = null;
		
		if(requestResponse == null)
		{
			demandeConge = apiResponse.readEntity(CongeAcademique.class);
		}
		else 
		{
			System.out.println("erreur dans DemanderCongeEtudiant etudiant >>> aucune demande pour cet etudiant???....");
		}
		
		session.setAttribute("demandeConge", demandeConge);
		
		request.getRequestDispatcher("/WEB-INF/espace_etudiant/demander_conge_etudiant.jsp").forward(request, response);
	}
}
