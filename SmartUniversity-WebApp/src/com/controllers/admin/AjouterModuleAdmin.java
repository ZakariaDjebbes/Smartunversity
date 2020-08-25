package com.controllers.admin;

import java.io.IOException;

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
import com.modele.Module;

@WebServlet("/User/AjouterModuleAdmin")
public class AjouterModuleAdmin extends HttpServlet
{
	private static final long serialVersionUID = 1L;
	public AjouterModuleAdmin()
	{
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		request.getRequestDispatcher("/WEB-INF/espace_admin/ajouter_module_admin.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		HttpSession session = request.getSession(false);
		String token = session.getAttribute("token").toString();
		Module module = GetModuleData(request);
		boolean isDone = true;
		String message = "";
		
		Client client = ClientBuilder.newClient();
		WebTarget target = client.target(
				"http://localhost:8080/SmartUniversity-API/api/create/module");
				Response apiResponse = target.request(MediaType.APPLICATION_JSON)
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + token).put(Entity.json(module));
		
				RequestResponse requestResponse = RequestResponse.GetRequestResponse(apiResponse);
		
		if (!(apiResponse.getStatusInfo() == Status.OK))
		{
			isDone = false;
		}	
		
		message = requestResponse.getMessage_fr();
		session.setAttribute("isDone", isDone);
		session.setAttribute("message", message);
		Redirect.SendRedirect(request, response, "/User/AjouterModuleAdmin");
	}
	
	private Module GetModuleData(HttpServletRequest request)
	{
		String nom = request.getParameter("nom");
		String code_module = request.getParameter("code-module");
		Module module = new Module(code_module, nom);
		return module;
	}
}
