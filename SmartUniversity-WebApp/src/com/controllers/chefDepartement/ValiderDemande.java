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
import javax.ws.rs.client.Entity;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import com.controllers.Redirect;
import com.helpers.DemandeChangementSeanceResponse;
import com.helpers.DemandeCongeAcademiqueResponse;
import com.helpers.DemandeSeanceSuppResponse;
import com.helpers.RequestResponse;

@WebServlet("/User/ValiderDemande")
public class ValiderDemande extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
       
    public ValiderDemande() 
    {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		HttpSession session = request.getSession(false);
		String token = session.getAttribute("token").toString();
		String typeDemande = session.getAttribute("typeDemande").toString();
		boolean isDone = true;
		String message = "";
		String redirectTo = "";
		Client client = ClientBuilder.newClient();
		WebTarget target = null;
		
		switch (typeDemande)
		{
		case ConsulterDemandeChefDepartement.DEMANDE_CHANGEMENT_SEANCE:
			DemandeChangementSeanceResponse demandeChangement = (DemandeChangementSeanceResponse) session.getAttribute("demande");
			String code_seance = demandeChangement.getSeance().getCode_seance();
			target = client.target("http://localhost:8080/SmartUniversity-API/api/update/departement/valider/demande/changement")
					.queryParam("code_seance", code_seance);
			
			redirectTo = "/User/ConsulterDemandesChefDepartement";
			
			break;
		case ConsulterDemandeChefDepartement.DEMANDE_SEANCE_SUPP:
			DemandeSeanceSuppResponse demandeSupp = (DemandeSeanceSuppResponse) session.getAttribute("demande");
			int code_seance_supp = demandeSupp.getSeanceSupp().getCode_seance_supp();
			target = client.target("http://localhost:8080/SmartUniversity-API/api/update/departement/valider/demande/seanceSupp")
					.queryParam("code_seance_supp", code_seance_supp);
			
			redirectTo = "/User/ConsulterDemandeChefDepartement?code-seance-supp=" + code_seance_supp + "&type=supp";

			break;
		case ConsulterDemandeChefDepartement.DEMANDE_CONGE_ACADEMIQUE:
			DemandeCongeAcademiqueResponse demandeCongeAcademique = (DemandeCongeAcademiqueResponse) session.getAttribute("demande");
			int numero_conge_academique = demandeCongeAcademique.getCongeAcademique().getNumero_conge_academique();
			target = client.target("http://localhost:8080/SmartUniversity-API/api/update/departement/valider/demande/congeAcademique")
					.queryParam("numero_conge_academique", numero_conge_academique);
			
			redirectTo = "/User/ConsulterDemandeChefDepartement?numero-conge-academique=" + numero_conge_academique + "&type=conge";
			break;
		default :
			//TODO page erreur?
			return;
		}

		Response apiResponse = target.request(MediaType.APPLICATION_JSON)
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + token).post(Entity.json(null));
		RequestResponse requestResponse = RequestResponse.GetRequestResponse(apiResponse);
		
		if (!(apiResponse.getStatusInfo() == Status.OK))
		{
			isDone = false;
		}	
		
		message = requestResponse.getMessage_fr();
		session.setAttribute("isDone", isDone);
		session.setAttribute("message", message);
		Redirect.SendRedirect(request, response, redirectTo);
	}
}
