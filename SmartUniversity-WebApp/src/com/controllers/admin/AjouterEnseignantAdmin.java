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
import com.dots.Dot_Create_Enseignant;
import com.dots.Dot_Create_Utilisateur;
import com.helpers.RequestResponse;
import com.modele.Etudiant.Annee;
import com.modele.Etudiant.Specialite;
import com.modele.Utilisateur.Code_Departement;
import com.modele.Utilisateur.Type_Utilisateur;
import com.utility.Utility;

@WebServlet("/User/AjouterEnseignantAdmin")
public class AjouterEnseignantAdmin extends HttpServlet
{
	private static final long serialVersionUID = 1L;

	public AjouterEnseignantAdmin()
	{
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		ArrayList<Type_Utilisateur> types = new ArrayList<Type_Utilisateur>();
		types.add(Type_Utilisateur.enseignant);
		types.add(Type_Utilisateur.chefDepartement);
		types.add(Type_Utilisateur.responsableFormation);

		request.setAttribute("types", types);
		request.setAttribute("departements", new ArrayList<Code_Departement>(EnumSet.allOf(Code_Departement.class)));

		request.getRequestDispatcher("/WEB-INF/espace_admin/ajouter_enseignant_admin.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		HttpSession session = request.getSession(false);
		String token = session.getAttribute("token").toString();
		Dot_Create_Enseignant enseignant = GetEnseignantData(request);
		Annee annee = null;
		Specialite specialite = null;
		
		if(enseignant.getDot_Create_Utilisateur().getUser_type().equals(Type_Utilisateur.responsableFormation))
		{
			String formation = request.getParameter("formation");
			annee = Annee.valueOf(formation.split("-")[0]);
			specialite = Specialite.valueOf(formation.split("-")[1]);
		}
		boolean isDone = true;
		String message = "";
		
		Client client = ClientBuilder.newClient();
		WebTarget target = client.target(
				"http://localhost:8080/SmartUniversity-API/api/create/enseignant")
				.queryParam("annee", annee)
				.queryParam("specialite", specialite);
		
				Response apiResponse = target.request(MediaType.APPLICATION_JSON)
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + token).put(Entity.json(enseignant));
		
				RequestResponse requestResponse = RequestResponse.GetRequestResponse(apiResponse);
		
		if (!(apiResponse.getStatusInfo() == Status.OK))
		{
			isDone = false;
		}	
		
		message = requestResponse.getMessage(Utility.GetValueOfCookieWithName(request, "lang"));
		session.setAttribute("isDone", isDone);
		session.setAttribute("message", message);
		Redirect.SendRedirect(request, response, "/User/AjouterEnseignantAdmin");
	}

	private Dot_Create_Enseignant GetEnseignantData(HttpServletRequest request)
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
		String grade= request.getParameter("grade");
		Type_Utilisateur type_Utilisateur = Type_Utilisateur.valueOf(request.getParameter("type"));
		Code_Departement code_Departement = Code_Departement.valueOf(request.getParameter("departement"));
		
		Dot_Create_Utilisateur utilisateur = new Dot_Create_Utilisateur(nom, prenom, email, date_n, telephone, adresse, type_Utilisateur);
		Dot_Create_Enseignant enseignant = new Dot_Create_Enseignant(utilisateur, grade, code_Departement);
		
		return enseignant;
	}
}
