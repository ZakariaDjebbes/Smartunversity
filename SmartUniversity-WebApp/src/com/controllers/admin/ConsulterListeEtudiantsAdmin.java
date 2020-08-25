package com.controllers.admin;

import java.io.IOException;
import java.util.ArrayList;

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

import com.helpers.RequestResponse;
import com.modele.Etudiant;

@WebServlet("/User/ConsulterListeEtudiantsAdmin")
public class ConsulterListeEtudiantsAdmin extends HttpServlet
{
	private static final long serialVersionUID = 1L;

	public ConsulterListeEtudiantsAdmin()
	{
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		HttpSession session = request.getSession(false);
		UpdateEtudiantsFromAPI(session);
		
		request.getRequestDispatcher("/WEB-INF/espace_admin/consulter_liste_étudiants_admin.jsp").forward(request, response);
	}

	public static void UpdateEtudiantsFromAPI(HttpSession session)
	{	
		String token = session.getAttribute("token").toString();

		Client client = ClientBuilder.newClient();
		WebTarget target = client.target(
				"http://localhost:8080/SmartUniversity-API/api/get/admin/etudiants");
		Response apiResponse = target.request(MediaType.APPLICATION_JSON)
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + token).get();
		apiResponse.bufferEntity();
		RequestResponse requestResponse = RequestResponse.GetRequestResponse(apiResponse);
		ArrayList<Etudiant> etudiants = new ArrayList<Etudiant>();
		if (requestResponse == null)
		{
			etudiants = apiResponse.readEntity(new GenericType<ArrayList<Etudiant>>()
			{
			});
		} else
		{
			System.out.println("erreur UpadteEtudiantsFromAPI >>> aucun étudiant?");
		}
		
		session.setAttribute("etudiants", etudiants);
	}
}
