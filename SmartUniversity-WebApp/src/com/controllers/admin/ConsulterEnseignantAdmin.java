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
import com.modele.Enseignant;
import com.modele.Utilisateur;
import com.modele.Utilisateur.Code_Departement;
import com.modele.Utilisateur.Type_Utilisateur;

@WebServlet("/User/ConsulterEnseignantAdmin")
public class ConsulterEnseignantAdmin extends HttpServlet
{
	private static final long serialVersionUID = 1L;

	public ConsulterEnseignantAdmin()
	{
		super();
	}

	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		HttpSession session = request.getSession(false);
		ConsulterListeEnseignantsAdmin.UpdateEnseignantsFromAPI(session);
		int id_enseignant = Integer.parseInt(request.getParameter("id_enseignant"));
		ArrayList<Enseignant> enseignants = (ArrayList<Enseignant>) session.getAttribute("enseignants");
		Enseignant enseignant = null;
		
		for (Enseignant item : enseignants)
		{
			if(item.getId_utilisateur() == id_enseignant)
			{
				enseignant = item;
			}
		}
		
		if(enseignant == null)
		{
			//TODO error page?
		}
		session.setAttribute("enseignant", enseignant);
		ArrayList<Type_Utilisateur> types = new ArrayList<Type_Utilisateur>();
		types.add(Type_Utilisateur.enseignant);
		types.add(Type_Utilisateur.chefDepartement);
		types.add(Type_Utilisateur.responsableFormation);

		request.setAttribute("types", types);
		request.setAttribute("departements", new ArrayList<Code_Departement>(EnumSet.allOf(Code_Departement.class)));
		
		request.getRequestDispatcher("/WEB-INF/espace_admin/consulter_enseignant_admin.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		HttpSession session = request.getSession(false);
		Enseignant enseignant = GetEnseignantData(request);
		String message = "";
		boolean isDone = true;

		//TODO check if something changed?
		
		Client client = ClientBuilder.newClient();
		WebTarget target = client.target("http://localhost:8080/SmartUniversity-API/api/update/admin/enseignant");
		Response apiResponse = target.request(MediaType.APPLICATION_JSON)
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + session.getAttribute("token").toString())
				.post(Entity.json(enseignant));
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
		Redirect.SendRedirect(request, response, "/User/ConsulterEnseignantAdmin?id_enseignant=" + enseignant.getId_utilisateur());
	}

	private Enseignant GetEnseignantData(HttpServletRequest request)
	{
		int id_utilisateur = Integer.valueOf(request.getParameter("id_enseignant"));
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
		String grade= request.getParameter("grade");
		Type_Utilisateur type_utilisateur = Type_Utilisateur.valueOf(request.getParameter("type"));
		Code_Departement code_departement = Code_Departement.valueOf(request.getParameter("departement"));
		
		Utilisateur utilisateur = new Utilisateur(id_utilisateur, user, null, nom, prenom, adresse, date_n, email, telephone, type_utilisateur);
		Enseignant enseignant = new Enseignant(utilisateur, grade, code_departement);
		return enseignant;
	}
}
