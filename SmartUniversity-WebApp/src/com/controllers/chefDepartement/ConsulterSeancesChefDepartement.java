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
import com.helpers.SeanceDepartementResponse;
import com.modele.ChefDepartement;

/**
 * Servlet implementation class ConsulterSeancesChefDepartement
 */
@WebServlet("/User/ConsulterSeancesChefDepartement")
public class ConsulterSeancesChefDepartement extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
	
    public ConsulterSeancesChefDepartement() 
    {
        super();
    }

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
    	HttpSession session = request.getSession(false);
		UpdateSeancesDepartementFromAPI(session);
		
		request.getRequestDispatcher("/WEB-INF/espace_enseignant/espace_chef_departement/consulter_seances_chef_departement.jsp").forward(request, response);
    }
	
	public static void UpdateSeancesDepartementFromAPI(HttpSession session)
	{
		String token = session.getAttribute("token").toString();
		ChefDepartement chefDepartement = (ChefDepartement) session.getAttribute("utilisateur");
		
		Client client = ClientBuilder.newClient();
		WebTarget target = client.target(
				"http://localhost:8080/SmartUniversity-API/api/get/seances")
				.queryParam("code_departement",  chefDepartement.getCode_departement());
		Response apiResponse = target.request(MediaType.APPLICATION_JSON)
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + token).get();
		apiResponse.bufferEntity();
		RequestResponse requestResponse = RequestResponse.GetRequestResponse(apiResponse);
		ArrayList<SeanceDepartementResponse> seancesDepartement = new ArrayList<SeanceDepartementResponse>();
		if(requestResponse == null)
		{
			seancesDepartement = apiResponse.readEntity(new GenericType<ArrayList<SeanceDepartementResponse>>() {});
		}
		else 
		{
			System.out.println("erreur UpdateSeanceFromAPI Chef dep >>> aucune séance pour ce departement???....");
		}
		
		session.setAttribute("seancesDepartement", seancesDepartement);
	}
}
