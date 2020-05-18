package com.controllers;

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

import com.dots.Dot_Create_Absence;
import com.helpers.EtudiantResponse;
import com.helpers.SeanceResponse;

@WebServlet("/MarquerPresence")
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
					if (checkbox == null)
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
			message = String.format("Présence marquer avec succès pour le groupe %s du module %s", 
					currentSeance.getSeance().getGroupe(),
					currentSeance.getModule().getNom());
		}
		else 
		{
			message= "Une erreur s'est produite...";
		}

		ConsulterSeancesEnseignant.UpadteSeancesFromAPI(session);
		session.setAttribute("message", message);
		session.setAttribute("isDone", isDone);
		
		Redirect.SendRedirect(request, response, "/WEB-INF/espace_enseignant/consulter_seance_enseignant.jsp");
		
//		response.setContentType("text/json");
//		response.setCharacterEncoding("UTF-8");
//		response.getWriter().write();
	}
}
