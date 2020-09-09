package com.controllers;

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
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import com.helpers.RequestResponse;

@WebServlet("/ModifierMotDePasse")
public class ModifierMotDePasse extends HttpServlet
{
	private static final long serialVersionUID = 1L;

	public ModifierMotDePasse()
	{
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		HttpSession session = request.getSession(false);
		response.setContentType("text/plain");
	    response.setCharacterEncoding("UTF-8");
		String error = "Le code reçu n'est pas valide";
		String error_interne = "Une erreur interne est survenue";

		if(session == null)
		{
			response.getWriter().write(error_interne);
		}
		
		String received_code = request.getParameter("code");
		String created_code = session.getAttribute("code").toString();
			    
		if(received_code.equals(created_code))
		{
			response.getWriter().write("");
		}
		else
		{
			response.getWriter().write(error);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		HttpSession session = request.getSession(false);
		String id = session.getAttribute("id").toString();
		String pass = request.getParameter("pass");
		
		Client client = ClientBuilder.newClient();
		WebTarget target = client.target(
				"http://localhost:8080/SmartUniversity-API/api/auth/updatePassword")
				.queryParam("id", id)
				.queryParam("password", pass);
				Response apiResponse = target.request(MediaType.APPLICATION_JSON).post(Entity.json(null));
		apiResponse.bufferEntity();
		RequestResponse requestResponse = RequestResponse.GetRequestResponse(apiResponse);
		
		if(apiResponse.getStatusInfo() == Status.OK)
		{
			session.invalidate();
		}
		
		response.setContentType("text/plain");
	    response.setCharacterEncoding("UTF-8");
		response.getWriter().write(requestResponse.getMessage_fr());
	}
}
