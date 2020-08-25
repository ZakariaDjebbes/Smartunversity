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
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import com.helpers.RequestResponse;
import com.helpers.SeanceResponse;
import com.modele.Enseignant;

@WebServlet("/User/ConsulterSeanceEtudiant")
public class ConsulterSeanceEtudiant extends HttpServlet
{
	private static final long serialVersionUID = 1L;
	
	public ConsulterSeanceEtudiant()
	{
		super();
	}

	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		HttpSession session = request.getSession(false);
		String token = session.getAttribute("token").toString();
		String code_seance = request.getParameter("code-seance");
		ConsulterEmploiEtudiant.UpdateSeancesEtudiantFromAPI(session);
		ArrayList<SeanceResponse> seancesResponse = (ArrayList<SeanceResponse>) session
				.getAttribute("seancesEtudiant");
		
		SeanceResponse seance = SeanceResponse.GetByCodeSeance(seancesResponse, code_seance);
		
		if(seance == null)
		{
			System.out.println("pas de séance");
			//TODO page d'erreur?
		}
		
		Client client = ClientBuilder.newClient();
		WebTarget target = client.target("http://localhost:8080/SmartUniversity-API/api/get/enseignant")
				.queryParam("code_seance", seance.getSeance().getCode_seance());
		Response apiResponse = target.request(MediaType.APPLICATION_JSON).header(HttpHeaders.AUTHORIZATION, "Bearer " + token).get();
		apiResponse.bufferEntity();
		RequestResponse requestResponse = RequestResponse.GetRequestResponse(apiResponse);
		Enseignant enseignant = null;
		
		if(requestResponse == null)
		{
			enseignant = apiResponse.readEntity(Enseignant.class);
		}
		else
		{
			//TODO error page?
		}
		request.setAttribute("enseignant", enseignant);
		request.setAttribute("seanceEtudiant", seance);
		request.getRequestDispatcher("/WEB-INF/espace_etudiant/consulter_seance_etudiant.jsp").forward(request,
				response);
	}
}
