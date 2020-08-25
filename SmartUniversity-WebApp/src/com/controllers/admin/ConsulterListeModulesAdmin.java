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
import com.modele.Module;

@WebServlet("/User/ConsulterListeModulesAdmin")
public class ConsulterListeModulesAdmin extends HttpServlet
{
	private static final long serialVersionUID = 1L;

	public ConsulterListeModulesAdmin()
	{
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		HttpSession session = request.getSession(false);
		UpdateModulesFromAPI(session);
		
		request.getRequestDispatcher("/WEB-INF/espace_admin/consulter_liste_modules_admin.jsp").forward(request, response);
	}
	
	public static void UpdateModulesFromAPI(HttpSession session)
	{	
		String token = session.getAttribute("token").toString();

		Client client = ClientBuilder.newClient();
		WebTarget target = client.target(
				"http://localhost:8080/SmartUniversity-API/api/get/admin/modules");
		Response apiResponse = target.request(MediaType.APPLICATION_JSON)
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + token).get();
		apiResponse.bufferEntity();
		RequestResponse requestResponse = RequestResponse.GetRequestResponse(apiResponse);
		ArrayList<Module> modules = new ArrayList<Module>();
		if (requestResponse == null)
		{
			modules = apiResponse.readEntity(new GenericType<ArrayList<Module>>()
			{
			});
		} else
		{
			System.out.println("erreur UpdateModulesFromAPI >>> aucun étudiant?");
		}
		
		session.setAttribute("modules", modules);
	}
}
