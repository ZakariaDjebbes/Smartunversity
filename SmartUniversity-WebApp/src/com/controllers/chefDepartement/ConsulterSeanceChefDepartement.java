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

import com.helpers.EnseignantDisponibleResponse;
import com.helpers.RequestResponse;
import com.helpers.SeanceDepartementResponse;
import com.modele.ChefDepartement;

@WebServlet("/User/ConsulterSeanceChefDepartement")
public class ConsulterSeanceChefDepartement extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ConsulterSeanceChefDepartement() {
        super();
    }
    @SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	HttpSession session = request.getSession(false);
		ConsulterSeancesChefDepartement.UpdateSeancesDepartementFromAPI(session);
		String code_seance = request.getParameter("code-seance");
		ArrayList<SeanceDepartementResponse> seances = (ArrayList<SeanceDepartementResponse>) session.getAttribute("seancesDepartement");
				
		SeanceDepartementResponse seance = SeanceDepartementResponse.GetByCodeSeance(seances, code_seance);
				
		if(seance.getEnseignant() == null)
		{
			ChefDepartement chefDepartement = (ChefDepartement) session.getAttribute("utilisateur");
			String token = session.getAttribute("token").toString();
			ArrayList<EnseignantDisponibleResponse> enseignants = new ArrayList<EnseignantDisponibleResponse>();
			
			Client client = ClientBuilder.newClient();
			WebTarget target = client.target(
					"http://localhost:8080/SmartUniversity-API/api/get/enseignants/departement")
					.queryParam("code_departement", chefDepartement.getCode_departement())
					.queryParam("jour", seance.getSeance().getJour())
					.queryParam("heure", seance.getSeance().getHeure());
			Response apiResponse = target.request(MediaType.APPLICATION_JSON)
					.header(HttpHeaders.AUTHORIZATION, "Bearer " + token).get();
			apiResponse.bufferEntity();
			RequestResponse requestResponse = RequestResponse.GetRequestResponse(apiResponse);
			
			if(requestResponse == null)
			{
				enseignants = apiResponse.readEntity(new GenericType<ArrayList<EnseignantDisponibleResponse>>() {});
				session.setAttribute("enseignants", enseignants);
			}
			else 
			{
				System.out.println("Erreur dans la requete des enseigants? .... >>> ConsulterSeanceChefDepartement");
			}
		}
		
		session.setAttribute("seanceDepartement", seance);
		request.getRequestDispatcher("/WEB-INF/espace_enseignant/espace_chef_departement/consulter_seance_chef_departement.jsp").forward(request, response);
    }
}
