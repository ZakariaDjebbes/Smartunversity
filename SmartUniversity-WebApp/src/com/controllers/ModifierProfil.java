package com.controllers;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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

import com.helpers.RequestResponse;
import com.modele.Admin;
import com.modele.ChefDepartement;
import com.modele.Enseignant;
import com.modele.Etudiant;
import com.modele.Utilisateur;
import com.utility.Utility;

@WebServlet("/User/ModifierProfil")
public class ModifierProfil extends HttpServlet
{
	private static final long serialVersionUID = 1L;

	public ModifierProfil()
	{
		super();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		request.getRequestDispatcher("/WEB-INF/modifier_profil.jsp").forward(request, response);
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		HttpSession session = request.getSession();
		String message = "";
		boolean isDone = false;

		Utilisateur newUtilisateur = GetUserData(request);
		Utilisateur oldUtilisateur = (Utilisateur) session.getAttribute("utilisateur");
		if (!newUtilisateur.equals(oldUtilisateur))
		{
			newUtilisateur.setId_utilisateur(oldUtilisateur.getId_utilisateur());
			Client client = ClientBuilder.newClient();
			WebTarget target = client.target("http://localhost:8080/SmartUniversity-API/api/update/updateUser")
					.queryParam("isAndroid", false);
			Response apiResponse = target.request(MediaType.APPLICATION_JSON)
					.header(HttpHeaders.AUTHORIZATION, "Bearer " + session.getAttribute("token").toString())
					.post(Entity.json(newUtilisateur));
			apiResponse.bufferEntity();
			RequestResponse requestResponse = RequestResponse.GetRequestResponse(apiResponse);
			if (requestResponse == null)
			{
				Utilisateur utilisateur = apiResponse.readEntity(Utilisateur.class);
				switch (utilisateur.getUser_type())
				{
				case etudiant:
					Etudiant etudiant = apiResponse.readEntity(Etudiant.class);
					session.setAttribute("utilisateur", etudiant);
					break;
				case enseignant:
					Enseignant enseignant = apiResponse.readEntity(Enseignant.class);
					session.setAttribute("utilisateur", enseignant);
					break;
				case chefDepartement:
					ChefDepartement chefDepartement = apiResponse.readEntity(ChefDepartement.class);
					session.setAttribute("utilisateur", chefDepartement);
					break;
				case admin:
					Admin admin = apiResponse.readEntity(Admin.class);
					session.setAttribute("utilisateur", admin);
				default:
					break;
				}

				isDone = true;
				switch (Utility.GetValueOfCookieWithName(request, "lang"))
				{
				case "fr":
					message = "Modification réussi.";
					break;
				case "en":
					message = "Modification successful.";				
					break;

				}
			} 
			else
			{
				message = requestResponse.getMessage(Utility.GetValueOfCookieWithName(request, "lang"));
				session.setAttribute("message", message);
			}
			apiResponse.close();
		} 
		else
		{
			switch (Utility.GetValueOfCookieWithName(request, "lang"))
			{
			case "fr":
				message = "Veuillez modifier au moins un champ.";
				break;
			case "en":
				message = "Please edit at least one field.";				
				break;

			}
		}

		session.setAttribute("isDone", isDone);
		session.setAttribute("message", message);
		Redirect.SendRedirect(request, response, "/WEB-INF/modifier_profil.jsp");
	}

	private Utilisateur GetUserData(HttpServletRequest request)
	{
		HttpSession session = request.getSession();
		Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");

		String user = request.getParameter("user");
		String pass = request.getParameter("pass");
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

		return new Utilisateur(0, user, pass, nom, prenom, adresse, date_n, email, telephone,
				utilisateur.getUser_type());
	}
}
