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

import com.helpers.DemandesDepartementResponse;
import com.helpers.RequestResponse;
import com.modele.ChefDepartement;

@WebServlet("/User/ConsulterDemandesChefDepartement")
public class ConsulterDemandesChefDepartement extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ConsulterDemandesChefDepartement() 
    {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		HttpSession session = request.getSession(false);
		UpdateDemandesFromAPI(session);
		
		request.getRequestDispatcher("/WEB-INF/espace_enseignant/espace_chef_departement/consulter_demandes_chef_departement.jsp").forward(request, response);
	}
	
	public static void UpdateDemandesFromAPI(HttpSession session)
	{
		String token = session.getAttribute("token").toString();
		ChefDepartement chefDepartement = (ChefDepartement) session.getAttribute("utilisateur");
		
		Client client = ClientBuilder.newClient();
		WebTarget target = client.target(
				"http://localhost:8080/SmartUniversity-API/api/get/demandes/departement")
				.queryParam("code_departement",  chefDepartement.getCode_departement());
		Response apiResponse = target.request(MediaType.APPLICATION_JSON)
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + token).get();
		apiResponse.bufferEntity();
		RequestResponse requestResponse = RequestResponse.GetRequestResponse(apiResponse);
		DemandesDepartementResponse demandesDepartement = new DemandesDepartementResponse();
		if(requestResponse == null)
		{
			demandesDepartement = apiResponse.readEntity(DemandesDepartementResponse.class);
		}
		else 
		{
			System.out.println("erreur UpdateDemandesFromApi Chef dep >>> aucune demande pour ce departement???....");
		}
				
		session.setAttribute("demandesDepartement", demandesDepartement);
	}
}
