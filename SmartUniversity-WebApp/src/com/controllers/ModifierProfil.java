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
import com.modele.Enseignant;
import com.modele.Utilisateur;

@WebServlet("/ModifierProfil")
public class ModifierProfil extends HttpServlet
{
	private static final long serialVersionUID = 1L;

	public ModifierProfil()
	{
		super();
	}

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
			WebTarget target = client.target("http://localhost:8080/SmartUniversity-API/api/update/updateUser");
			Response apiResponse = target.request(MediaType.APPLICATION_JSON)
					.header(HttpHeaders.AUTHORIZATION, "Bearer " + session.getAttribute("token").toString())
					.put(Entity.json(newUtilisateur));
			apiResponse.bufferEntity();
			RequestResponse requestResponse = RequestResponse.GetRequestResponse(apiResponse);
			if (requestResponse == null)
			{
				Utilisateur utilisateur = apiResponse.readEntity(Utilisateur.class);
				switch (utilisateur.getUser_type())
				{
				case etudiant:
					break;
				case enseignant:
					Enseignant enseignant = apiResponse.readEntity(Enseignant.class);
					session.setAttribute("utilisateur", enseignant);
					break;
				default:
					break;
				}

				isDone = true;
				message = "Modification réussi.";
			} 
			else
			{
				message = requestResponse.getMessage();
				session.setAttribute("message", message);
			}
			apiResponse.close();
		} 
		else
		{
			message = "Veuillez modifier au moins un champs.";
		}

		session.setAttribute("isDone", isDone);
		session.setAttribute("message", message);
		Redirect.SendRedirect(request, response, "/WEB-INF/espace_enseignant/modifier_profil_enseignant.jsp");
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
