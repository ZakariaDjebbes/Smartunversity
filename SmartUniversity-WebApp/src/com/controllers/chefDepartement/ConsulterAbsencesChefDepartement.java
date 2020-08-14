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

import com.helpers.AbsenceDepartementResponse;
import com.helpers.RequestResponse;
import com.modele.ChefDepartement;

@WebServlet("/User/ConsulterAbsencesChefDepartement")
public class ConsulterAbsencesChefDepartement extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
       
    public ConsulterAbsencesChefDepartement() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	HttpSession session = request.getSession(false);
    	UpdateAbsencesDepartementFromAPI(session);
		
		request.getRequestDispatcher("/WEB-INF/espace_enseignant/espace_chef_departement/consulter_absences_chef_departement.jsp").forward(request, response);
	}
	
	public static void UpdateAbsencesDepartementFromAPI(HttpSession session)
	{
		String token = session.getAttribute("token").toString();
		ChefDepartement chefDepartement = (ChefDepartement) session.getAttribute("utilisateur");
		
		Client client = ClientBuilder.newClient();
		WebTarget target = client.target(
				"http://localhost:8080/SmartUniversity-API/api/get/absences/departement")
				.queryParam("code_departement",  chefDepartement.getCode_departement());
		Response apiResponse = target.request(MediaType.APPLICATION_JSON)
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + token).get();
		apiResponse.bufferEntity();
		RequestResponse requestResponse = RequestResponse.GetRequestResponse(apiResponse);
		ArrayList<AbsenceDepartementResponse> absencesDepartement = new ArrayList<AbsenceDepartementResponse>();
		if(requestResponse == null)
		{
			absencesDepartement = apiResponse.readEntity(new GenericType<ArrayList<AbsenceDepartementResponse>>() {});
		}
		else 
		{
			System.out.println("erreur UpdateAbsencesFromAPI Chef dep >>> aucune absence pour ce departement???....");
		}
		
		session.setAttribute("absencesDepartement", absencesDepartement);
	}
}
