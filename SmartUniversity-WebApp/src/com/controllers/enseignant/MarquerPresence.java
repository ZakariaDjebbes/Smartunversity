package com.controllers.enseignant;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;

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
import com.dots.Dot_Create_Absence;
import com.helpers.EtudiantResponse;
import com.helpers.SeanceResponse;
import com.modele.Etudiant.Etat_Etudiant;
import com.utility.Utility;

@WebServlet("/User/MarquerPresence")
public class MarquerPresence extends HttpServlet
{
	private static final long serialVersionUID = 1L;

	public MarquerPresence()
	{
		super();
	}

	@SuppressWarnings("unchecked")
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		HttpSession session = request.getSession();
		String token = session.getAttribute("token").toString();
		boolean isDone = false;
		String message = "";
		String code_seance = request.getParameter("code-seance");
		ArrayList<SeanceResponse> seances = (ArrayList<SeanceResponse>) session.getAttribute("seances");
		SeanceResponse currentSeance = SeanceResponse.GetByCodeSeance(seances, code_seance);

		Client client = ClientBuilder.newClient();
		WebTarget target;

		// erreur?
		if (currentSeance == null)
		{
			isDone = false;
		} else
		{
			ArrayList<EtudiantResponse> etudiants = currentSeance.getEtudiants();
			ArrayList<EtudiantResponse> etudiantsAbsent = new ArrayList<EtudiantResponse>();

			if (etudiants != null)
			{

				isDone = true;
				// recup des etudiants depuis le formulaire
				for (EtudiantResponse etudiant : etudiants)
				{
					// recup de la checkbox
					String checkbox = request.getParameter(String.valueOf(etudiant.getEtudiant().getId_utilisateur()));
					// si la checkbox est checked alors l'etudiant est présent donc pas d'absence...
					if (checkbox == null && !(etudiant.getEtudiant().getEtat_etudiant() == Etat_Etudiant.bloque))
					{
						etudiantsAbsent.add(etudiant);
					}
				}
				// creation des absences
				for (EtudiantResponse etudiant : etudiantsAbsent)
				{
					Dot_Create_Absence absence = new Dot_Create_Absence(code_seance,
							etudiant.getEtudiant().getId_utilisateur(), new Date());

					client = ClientBuilder.newClient();
					target = client.target("http://localhost:8080/SmartUniversity-API/api/create/absence");
					Response apiResponse = target.request(MediaType.APPLICATION_JSON)
							.header(HttpHeaders.AUTHORIZATION, "Bearer " + token).put(Entity.json(absence));

					if (apiResponse.getStatusInfo() != Status.OK)
					{
						isDone = false;
					}
					apiResponse.close();
				}
			}
		}
		
		if(isDone)
		{
			switch (Utility.GetValueOfCookieWithName(request, "lang"))
			{
			case "fr":
				message = "Présence marquer avec succès.";				
				break;
			case "en":
				message = "Presence mark successfully.";				
				break;

			}
		}
		else 
		{
			switch (Utility.GetValueOfCookieWithName(request, "lang"))
			{
			case "fr":
				message= "Une erreur s'est produite, la présence n'a pas été marqué.";
				break;
			case "en":
				message = "An error has occurred, the presence has not been marked.";				
				break;

			}
		}

		ConsulterSeancesEnseignant.UpadteSeancesFromAPI(session);
		session.setAttribute("message", message);
		session.setAttribute("isDone", isDone);
		
		Redirect.SendRedirect(request, response, "/User/ConsulterSeanceEnseignant?code-seance=" + currentSeance.getSeance().getCode_seance());
		
//		response.setContentType("text/json");
//		response.setCharacterEncoding("UTF-8");
//		response.getWriter().write();
	}
}
