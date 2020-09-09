package com.controllers.chefDepartement;

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
import com.modele.ChefDepartement;

@WebServlet("/User/ConsulterEtudiantsExclusChefDepartement")
public class ConsulterEtudiantsExclusChefDepartement extends HttpServlet
{
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		HttpSession session = request.getSession(false);
		UpdateEtudiantsExclusFromAPI(session);
		
		request.getRequestDispatcher("/WEB-INF/espace_enseignant/espace_chef_departement/consulter_etudiants_exlus_chef_departement.jsp").forward(request, response);
	}
	
	public static void UpdateEtudiantsExclusFromAPI(HttpSession session)
	{
		String token = session.getAttribute("token").toString();
		ChefDepartement chefDepartement = (ChefDepartement) session.getAttribute("utilisateur");
		
		Client client = ClientBuilder.newClient();
		WebTarget target = client.target(
				"http://localhost:8080/SmartUniversity-API/api/get/etudiants/exlus/departement")
				.queryParam("code_departement",  chefDepartement.getCode_departement());
		Response apiResponse = target.request(MediaType.APPLICATION_JSON)
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + token).get();
		apiResponse.bufferEntity();
		RequestResponse requestResponse = RequestResponse.GetRequestResponse(apiResponse);
		ArrayList<SeanceResponse> seancesDepartement = new ArrayList<SeanceResponse>();
		if(requestResponse == null)
		{
			seancesDepartement = apiResponse.readEntity(new GenericType<ArrayList<SeanceResponse>>() {});
		}
		else 
		{
			System.out.println("erreur UpdateEtudiantsExclusFromAPI Chef dep >>> aucune absence pour ce departement???....");
		}
		
		session.setAttribute("seancesDepartement", seancesDepartement);
	}
}
