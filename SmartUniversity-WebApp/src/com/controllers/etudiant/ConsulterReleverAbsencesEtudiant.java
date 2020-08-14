package com.controllers.etudiant;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.GenericType;
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import com.helpers.AbsenceDepartementResponse;
import com.helpers.RequestResponse;
import com.modele.Etudiant;
import com.utility.ReleverAbsencesEtudiant;

@WebServlet("/User/ConsulterReleverAbsencesEtudiant")
public class ConsulterReleverAbsencesEtudiant extends HttpServlet
{
	private static final long serialVersionUID = 1L;
	public ConsulterReleverAbsencesEtudiant()
	{
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		HttpSession session = request.getSession(false);
		UpdateReleverAbsencesFromAPI(session);
		
		request.getRequestDispatcher("/WEB-INF/espace_etudiant/consulter_relever_absences_etudiant.jsp").forward(request, response);
	}
	
	public static void UpdateReleverAbsencesFromAPI(HttpSession session)
	{
		String token = session.getAttribute("token").toString();
		Etudiant etudiant = (Etudiant) session.getAttribute("utilisateur");
		
		Client client = ClientBuilder.newClient();
		WebTarget target = client.target(
				"http://localhost:8080/SmartUniversity-API/api/get/absences/etudiant")
				.queryParam("id_etudiant", etudiant.getId_utilisateur());
		Response apiResponse = target.request(MediaType.APPLICATION_JSON)
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + token).get();
		apiResponse.bufferEntity();
		RequestResponse requestResponse = RequestResponse.GetRequestResponse(apiResponse);
		
		ArrayList<AbsenceDepartementResponse> absences = new ArrayList<AbsenceDepartementResponse>();
		
		if(requestResponse == null)
		{
			absences = apiResponse.readEntity(new GenericType<ArrayList<AbsenceDepartementResponse>>() {});
		}
		else 
		{
			System.out.println("erreur UpdateReleverAbsencesFromAPI etudiant >>> aucune absence pour cet etudiant???....");
		}
		
		ReleverAbsencesEtudiant releverAbsences = ReleverAbsencesEtudiant.GetReleverFromAbsences(absences);
				
		session.setAttribute("releverAbsences", releverAbsences);
	}
}
