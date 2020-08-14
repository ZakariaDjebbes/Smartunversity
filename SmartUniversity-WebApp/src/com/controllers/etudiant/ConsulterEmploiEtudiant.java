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

import com.helpers.RequestResponse;
import com.helpers.SeanceResponse;
import com.modele.Etudiant;

@WebServlet("/User/ConsulterEmploiEtudiant")
public class ConsulterEmploiEtudiant extends HttpServlet
{
	private static final long serialVersionUID = 1L;

	public ConsulterEmploiEtudiant()
	{
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		HttpSession session = request.getSession(false);
		ConsulterReleverAbsencesEtudiant.UpdateReleverAbsencesFromAPI(session);
		UpdateSeancesEtudiantFromAPI(session);
		
		request.getRequestDispatcher("/WEB-INF/espace_etudiant/consulter_emploi_etudiant.jsp").forward(request, response);
	}
	
	public static void UpdateSeancesEtudiantFromAPI(HttpSession session)
	{
		String token = session.getAttribute("token").toString();
		Etudiant etudiant = (Etudiant) session.getAttribute("utilisateur");
		
		Client client = ClientBuilder.newClient();
		WebTarget target = client.target(
				"http://localhost:8080/SmartUniversity-API/api/get/seances/etudiant")
				.queryParam("id_etudiant", etudiant.getId_utilisateur());
		Response apiResponse = target.request(MediaType.APPLICATION_JSON)
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + token).get();
		apiResponse.bufferEntity();
		RequestResponse requestResponse = RequestResponse.GetRequestResponse(apiResponse);
		
		ArrayList<SeanceResponse> seancesEtudiant = new ArrayList<SeanceResponse>();
		
		if(requestResponse == null)
		{
			seancesEtudiant = apiResponse.readEntity(new GenericType<ArrayList<SeanceResponse>>() {});
		}
		else 
		{
			System.out.println("erreur UpdateSeancesEtudiantFromAPI etudiant >>> aucune absence pour cet etudiant???....");
		}
				
		session.setAttribute("seancesEtudiant", seancesEtudiant);
	}
}
