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

import com.helpers.AbsenceDepartementResponse;
import com.helpers.RequestResponse;
import com.modele.Justification;
import com.modele.Utilisateur;
import com.utility.Utility;

@WebServlet("/User/ConsulterAbsence")
public class ConsulterAbsence extends HttpServlet {
	private static final long serialVersionUID = 1L;
     
    public ConsulterAbsence() {
        super();
    
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		HttpSession session = request.getSession(false);
		int numero_absence = Integer.valueOf(request.getParameter("numero-absence"));
		int numero_justification = request.getParameter("numero-justification") == null? 
					-1:
					Integer.valueOf(request.getParameter("numero-justification"));
		String token = session.getAttribute("token").toString();
		Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
		Justification justification = null;
		
		Client client = ClientBuilder.newClient();
		WebTarget target = client.target(
				"http://localhost:8080/SmartUniversity-API/api/get/absence/departement")
				.queryParam("code_departement", Utility.GetDepartementOfUser(utilisateur))
				.queryParam("numero_absence", numero_absence);
		Response apiResponse = target.request(MediaType.APPLICATION_JSON)
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + token).get();
		apiResponse.bufferEntity();
		RequestResponse requestResponse = RequestResponse.GetRequestResponse(apiResponse);
		AbsenceDepartementResponse absenceDepartement = null;

		if(requestResponse == null)
		{
			absenceDepartement = apiResponse.readEntity(AbsenceDepartementResponse.class);
		}
		else 
		{
			//TODO redirect to error page
			System.out.println("erreur UpdateAbsencesFromAPI Chef dep >>> aucune absence pour ce departement???....");
		}
		
		if(numero_justification != -1)
		{
			for (Justification item : absenceDepartement.getJustifications())
			{
				if(item.getNumero_justification() == numero_justification)
				{
					justification = item;
					break;
				}
			}
			
			if(justification == null)
			{
				//TODO redirect to error page
			}
		}
		else
		{
			justification = absenceDepartement.getLatestJustification();
		}
		session.setAttribute("absence", absenceDepartement);
		session.setAttribute("justification", justification);
		request.getRequestDispatcher("/WEB-INF/consulter_absence.jsp").forward(request, response);
	}
}