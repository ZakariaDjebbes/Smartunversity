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

import com.helpers.Dot_Create_Absence;
import com.helpers.Dot_Seance;
import com.modele.Etudiant;

@WebServlet("/MarquerPresence")
public class MarquerPresence extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public MarquerPresence() {
        super();
    }

    @SuppressWarnings("unchecked")
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
    	HttpSession session = request.getSession();
    	String token = session.getAttribute("token").toString();
    	boolean isDone = false;
    	String code_seance = request.getParameter("code_seance");
    	ArrayList<Dot_Seance> seances = (ArrayList<Dot_Seance>) session.getAttribute("seances");
    	Dot_Seance currentSeance = null;
    	    	
    	for (Dot_Seance seance : seances)
		{
			if(seance.getSeance().getCode_seance().equals(code_seance))
			{
				currentSeance = seance;
				break;
			}
		}
    	    
    	//erreur?
    	if(currentSeance == null)
    	{
    		isDone = false;
    	}
    	else 
    	{
    		ArrayList<Etudiant> etudiants = currentSeance.GetEtudiants();
    		ArrayList<Etudiant> etudiantsAbsent = new ArrayList<Etudiant>();
    		
    		isDone = true;
    		//recup des etudiants depuis le formulaire
    		for (Etudiant etudiant : etudiants)
			{
    			//recup de la checkbox
				String checkbox = request.getParameter(String.valueOf(etudiant.getId_utilisateur()));
				//si la checkbox est checked alors l'etudiant est présent donc pas d'absence...
				if(checkbox == null)
				{
					etudiantsAbsent.add(etudiant);
				}
			}
    		//creation des absences
    		for (Etudiant etudiant : etudiantsAbsent)
			{
    			Dot_Create_Absence absence = new Dot_Create_Absence(code_seance, etudiant.getId_utilisateur(), new Date());
    			
    			Client client = ClientBuilder.newClient();
    			WebTarget target = client.target("http://localhost:8080/SmartUniversity-API/api/create/absence");
    			Response apiResponse = target.request(MediaType.APPLICATION_JSON)
    					.header(HttpHeaders.AUTHORIZATION, "Bearer " + token).put(Entity.json(absence));
    			
    			if(apiResponse.getStatusInfo() != Status.OK)
    			{
    				isDone = false;
    			}
    			apiResponse.close();
			}
		}
    	
		response.setContentType("text/plain");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(String.valueOf(isDone));
	}
}
