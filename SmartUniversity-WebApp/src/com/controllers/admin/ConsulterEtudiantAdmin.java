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
import com.helpers.RequestResponse;
import com.modele.Etudiant;
import com.modele.Etudiant.Annee;
import com.modele.Etudiant.Etat_Etudiant;
import com.modele.Etudiant.Specialite;
import com.modele.Utilisateur;
import com.modele.Utilisateur.Type_Utilisateur;

@WebServlet("/User/ConsulterEtudiantAdmin")
public class ConsulterEtudiantAdmin extends HttpServlet
{
	private static final long serialVersionUID = 1L;

	public ConsulterEtudiantAdmin()
	{
		super();
	}

	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		HttpSession session = request.getSession(false);
		ConsulterListeEtudiantsAdmin.UpdateEtudiantsFromAPI(session);
		int id_etudiant = Integer.parseInt(request.getParameter("id_etudiant"));
		ArrayList<Etudiant> etudiants = (ArrayList<Etudiant>) session.getAttribute("etudiants");
		Etudiant etudiant = null;
		
		for (Etudiant item : etudiants)
		{
			if(item.getId_utilisateur() == id_etudiant)
			{
				etudiant = item;
			}
		}
		
		if(etudiant == null)
		{
			//TODO error page?
		}
		session.setAttribute("etudiant", etudiant);
		request.setAttribute("annees", new ArrayList<Annee>(EnumSet.allOf(Annee.class)));
		request.setAttribute("etats", new ArrayList<Etat_Etudiant>(EnumSet.allOf(Etat_Etudiant.class)));
		request.setAttribute("specialites", new ArrayList<Specialite>(EnumSet.allOf(Specialite.class)));
		
		
		request.getRequestDispatcher("/WEB-INF/espace_admin/consulter_etudiant_admin.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		HttpSession session = request.getSession(false);
		Etudiant etudiant = GetEtudiantData(request);
		String message = "";
		boolean isDone = true;
		
		Client client = ClientBuilder.newClient();
		WebTarget target = client.target("http://localhost:8080/SmartUniversity-API/api/update/admin/etudiant");
		Response apiResponse = target.request(MediaType.APPLICATION_JSON)
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + session.getAttribute("token").toString())
				.post(Entity.json(etudiant));
		apiResponse.bufferEntity();
		
		if (apiResponse.getStatusInfo() != Status.OK)
		{
			isDone = false;
		}
		
		RequestResponse requestResponse = apiResponse.readEntity(RequestResponse.class);		
		apiResponse.close();
		message = requestResponse.getMessage_fr();
		session.setAttribute("message", message);
		session.setAttribute("isDone", isDone);
		Redirect.SendRedirect(request, response, "/User/ConsulterEtudiantAdmin?id_etudiant=" + etudiant.getId_utilisateur());
	}

	private Etudiant GetEtudiantData(HttpServletRequest request)
	{
		int id_utilisateur = Integer.valueOf(request.getParameter("id_etudiant"));
		String user = request.getParameter("user");
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
		Etat_Etudiant etat_etudiant = Etat_Etudiant.valueOf(request.getParameter("etat"));
		
		Utilisateur utilisateur = new Utilisateur(id_utilisateur, user, null, nom, prenom, adresse, date_n, email, telephone, Type_Utilisateur.etudiant);
		Etudiant etudiant = new Etudiant(utilisateur, annee, specialite, 0, groupe, etat_etudiant, null);
		
		return etudiant;
	}
}
