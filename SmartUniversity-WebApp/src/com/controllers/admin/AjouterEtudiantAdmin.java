package com.controllers.admin;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.EnumSet;

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
import com.dots.Dot_Create_Etudiant;
import com.dots.Dot_Create_Utilisateur;
import com.helpers.RequestResponse;
import com.modele.Etudiant.Annee;
import com.modele.Etudiant.Specialite;
import com.modele.Utilisateur.Type_Utilisateur;

@WebServlet("/User/AjouterEtudiantAdmin")
public class AjouterEtudiantAdmin extends HttpServlet
{
	private static final long serialVersionUID = 1L;

	public AjouterEtudiantAdmin()
	{
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		request.setAttribute("annees", new ArrayList<Annee>(EnumSet.allOf(Annee.class)));
		request.setAttribute("specialites", new ArrayList<Specialite>(EnumSet.allOf(Specialite.class)));
		
		request.getRequestDispatcher("/WEB-INF/espace_admin/ajouter_etudiant_admin.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		HttpSession session = request.getSession(false);
		String token = session.getAttribute("token").toString();
		Dot_Create_Etudiant etudiant = GetEtudiantData(request);
		boolean isDone = true;
		String message = "";
		
		Client client = ClientBuilder.newClient();
		WebTarget target = client.target(
				"http://localhost:8080/SmartUniversity-API/api/create/etudiant");
				Response apiResponse = target.request(MediaType.APPLICATION_JSON)
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + token).put(Entity.json(etudiant));
		
				RequestResponse requestResponse = RequestResponse.GetRequestResponse(apiResponse);
		
		if (!(apiResponse.getStatusInfo() == Status.OK))
		{
			isDone = false;
		}	
		
		message = requestResponse.getMessage_fr();
		session.setAttribute("isDone", isDone);
		session.setAttribute("message", message);
		Redirect.SendRedirect(request, response, "/User/AjouterEtudiantAdmin");
	}
	
	private Dot_Create_Etudiant GetEtudiantData(HttpServletRequest request)
	{
		String nom = request.getParameter("nom");
		String prenom = request.getParameter("prenom");
		String adresse = request.getParameter("adresse");
		String email = request.getParameter("email");
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		Date date_n = null;
		try
		{
			date_n = formatter.parse(request.getParameter("date_n"));
		} 
		catch (ParseException e)
		{
			e.printStackTrace();
		}
		String telephone = request.getParameter("telephone");
		Annee annee = Annee.valueOf(request.getParameter("annee"));
		Specialite specialite = Specialite.valueOf(request.getParameter("specialite"));
		int groupe = Integer.valueOf(request.getParameter("groupe"));
		
		Dot_Create_Utilisateur utilisateur = new Dot_Create_Utilisateur(nom, prenom, email, date_n, telephone, adresse, Type_Utilisateur.etudiant);
		Dot_Create_Etudiant etudiant = new Dot_Create_Etudiant(utilisateur, annee, specialite, groupe);
		
		return etudiant;
	}
}
