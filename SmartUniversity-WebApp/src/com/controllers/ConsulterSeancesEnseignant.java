package com.controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

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

import com.helpers.Dot_Etudiant;
import com.helpers.Dot_Seance;
import com.helpers.RequestResponse;
import com.modele.Absence;
import com.modele.Enseignant;
import com.modele.Etudiant;
import com.modele.Module;
import com.modele.Seance;

/**
 * Servlet implementation class ConsulterSeances
 */
@WebServlet("/ConsulterSeancesEnseignant")
public class ConsulterSeancesEnseignant extends HttpServlet
{
	private static final long serialVersionUID = 1L;

	public ConsulterSeancesEnseignant()
	{
		super();
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
	{
		doPost(req, resp);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		HttpSession session = request.getSession();
		String token = session.getAttribute("token").toString();
		String message = "";
		boolean isDone = false;
		
		Enseignant enseignant = (Enseignant) session.getAttribute("utilisateur");

		Client client = ClientBuilder.newClient();
		
		//Requete pour chercher les seances
		WebTarget target = client
				.target("http://localhost:8080/SmartUniversity-API/api/get/seances/" + enseignant.getId_utilisateur());
		Response apiResponse = target.request(MediaType.APPLICATION_JSON)
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + token).get();
		apiResponse.bufferEntity();
		RequestResponse requestResponse = RequestResponse.GetRequestResponse(apiResponse);
		
		if(requestResponse == null)
		{
			//Liste des séances
			ArrayList<Seance> seances = apiResponse.readEntity(new GenericType<ArrayList<Seance>>() {}); 
			//Liste des séances avec leurs nom module avec les étudiants de la séance
			ArrayList<Dot_Seance> dot_Seances = new ArrayList<Dot_Seance>();
			apiResponse.close();
			
			for (Seance seance : seances)
			{
				//requete pour chercher les étudiants de cette séance
				target = client.target("http://localhost:8080/SmartUniversity-API/api/get/etudiants")
						.queryParam("annee", seance.getAnnee())
						.queryParam("specialite", seance.getSpecialite())
						.queryParam("groupe", seance.getGroupe());
				apiResponse = target.request(MediaType.APPLICATION_JSON).header(HttpHeaders.AUTHORIZATION, "Bearer " + token)
						.get();
				apiResponse.bufferEntity();
				requestResponse = RequestResponse.GetRequestResponse(apiResponse);
				
				ArrayList<Etudiant> etudiants = new ArrayList<Etudiant>();
				ArrayList<Dot_Etudiant> dot_Etudiants = new ArrayList<Dot_Etudiant>();
				
				if(requestResponse == null)
				{
					etudiants = apiResponse.readEntity(new GenericType<ArrayList<Etudiant>>() {});
				}
				else 
				{
					System.out.println("Api responded with: " + requestResponse.getMessage() + " At ConsulterSeancesEnseignant");
				}
				
				//requete pour chercher les modules des séances
				target = client.target("http://localhost:8080/SmartUniversity-API/api/get/module/" + seance.getCode_module());
				apiResponse = target.request(MediaType.APPLICATION_JSON).header(HttpHeaders.AUTHORIZATION, "Bearer " + token)
						.get();
				apiResponse.bufferEntity();
				
				Module module = apiResponse.readEntity(Module.class);
				
				//requete pour les absences des étudiants
				for (Etudiant etudiant : etudiants)
				{
					ArrayList<Absence> absences = new ArrayList<Absence>();
					target = client.target("http://localhost:8080/SmartUniversity-API/api/get/absences");
					apiResponse = target.queryParam("code_seance", seance.getCode_seance())
										.queryParam("id_etudiant", etudiant.getId_utilisateur())
										.request(MediaType.APPLICATION_JSON)
										.header(HttpHeaders.AUTHORIZATION, "Bearer " + token)
										.get();
					apiResponse.bufferEntity();
					
					requestResponse = RequestResponse.GetRequestResponse(apiResponse);
					
					if(requestResponse == null)
					{
						absences = apiResponse.readEntity(new GenericType<ArrayList<Absence>>() {});
					}
					
					Dot_Etudiant dot_Etudiant = new Dot_Etudiant(etudiant, absences);
					dot_Etudiants.add(dot_Etudiant);
				}
				
				//Mettre tout ca dans le même objet pour facilité l'accés
				Dot_Seance dot_Seance = new Dot_Seance(seance, module, dot_Etudiants);
				
				//Ajouter a la liste des séances
				dot_Seances.add(dot_Seance);
				apiResponse.close();
			}
			
			isDone = true;
			
			if(dot_Seances.size() > 0)
			{
				Collections.sort(dot_Seances, new Comparator<Dot_Seance>()
				{
					@Override
					public int compare(Dot_Seance seance1, Dot_Seance seance2)
					{
						return seance1.getModule().getNom().compareTo(seance2.getModule().getNom());
					}
				});;
				
				session.setAttribute("seances", dot_Seances);	
			}
			else 
			{
				message = "Vous n'assurez aucune séance pour le moment";
			}
			
		}
		else 
		{
			message = requestResponse.getMessage();
		}
		
		session.setAttribute("message", message);
		session.setAttribute("isDone", isDone);
		
		Redirect.SendRedirect(request, response, "/WEB-INF/espace_enseignant/consulter_seance_enseignant.jsp");
	}

}
