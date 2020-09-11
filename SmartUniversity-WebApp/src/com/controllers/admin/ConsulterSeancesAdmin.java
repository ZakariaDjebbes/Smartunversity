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
import javax.ws.rs.client.Entity;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.GenericType;
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import com.controllers.Redirect;
import com.helpers.RequestResponse;
import com.helpers.SeanceResponse;
import com.modele.Etudiant.Annee;
import com.modele.Etudiant.Specialite;
import com.modele.Seance.Type_Seance;
import com.utility.Utility;

@WebServlet("/User/ConsulterSeancesAdmin")
public class ConsulterSeancesAdmin extends HttpServlet
{
	private static final long serialVersionUID = 1L;

	public ConsulterSeancesAdmin()
	{
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		HttpSession session = request.getSession(false);
		ConsulterListeModulesAdmin.UpdateModulesFromAPI(session);
		Annee annee = Annee.valueOf(request.getParameter("annee"));
		Specialite specialite = Specialite.valueOf(request.getParameter("specialite"));
		UpdateSeancesFromAPI(session, annee, specialite);
		request.setAttribute("annee", annee);
		request.setAttribute("specialite", specialite);
		request.getRequestDispatcher("/WEB-INF/espace_admin/consulter_seances_admin.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		HttpSession session = request.getSession(false);
		String code_seance = request.getParameter("code_seance");
		String code_module = request.getParameter("code_module");
		Type_Seance type_seance = Type_Seance.valueOf(request.getParameter("type"));
		Annee annee = Annee.valueOf(request.getParameter("annee"));
		Specialite specialite = Specialite.valueOf(request.getParameter("specialite"));
		String message = "";
		boolean isDone = true;
		
		Client client = ClientBuilder.newClient();
		WebTarget target = client.target("http://localhost:8080/SmartUniversity-API/api/update/admin/seance")
				.queryParam("code_module", code_module)
				.queryParam("type_seance", type_seance)
				.queryParam("code_seance", code_seance);
		Response apiResponse = target.request(MediaType.APPLICATION_JSON)
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + session.getAttribute("token").toString())
				.post(Entity.json(null));
		apiResponse.bufferEntity();
		
		if (apiResponse.getStatusInfo() != Status.OK)
		{
			isDone = false;
		}
		
		RequestResponse requestResponse = apiResponse.readEntity(RequestResponse.class);		
		apiResponse.close();
		message = requestResponse.getMessage(Utility.GetValueOfCookieWithName(request, "lang"));
		session.setAttribute("message", message);
		session.setAttribute("isDone", isDone);
		
		Redirect.SendRedirect(request, response, "/User/ConsulterSeancesAdmin?annee=" + annee + "&specialite=" + specialite);			
	}

	public static void UpdateSeancesFromAPI(HttpSession session, Annee annee, Specialite specialite)
	{
		String token = session.getAttribute("token").toString();

		Client client = ClientBuilder.newClient();
		WebTarget target = client.target("http://localhost:8080/SmartUniversity-API/api/get/admin/seances")
				.queryParam("annee", annee)
				.queryParam("specialite", specialite);
		Response apiResponse = target.request(MediaType.APPLICATION_JSON)
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + token).get();
		apiResponse.bufferEntity();
		RequestResponse requestResponse = RequestResponse.GetRequestResponse(apiResponse);
		ArrayList<SeanceResponse> seances = new ArrayList<SeanceResponse>();
		if (requestResponse == null)
		{
			seances = apiResponse.readEntity(new GenericType<ArrayList<SeanceResponse>>()
			{
			});
		} else
		{
			System.out.println("erreur UpdateSeancesFromAPI admin >>> aucune séance dans le systeme?");
		}
		session.setAttribute("seances", seances);
	}
}
