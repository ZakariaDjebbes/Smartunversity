package com.controllers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
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

import com.helpers.Dot_Login;
import com.helpers.LoginResponse;
import com.helpers.RequestResponse;
import com.modele.Enseignant;
import com.modele.Utilisateur;

@WebServlet("/Login")
public class Login extends HttpServlet
{
	private static final long serialVersionUID = 1L;

	public Login()
	{
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		HttpSession session = request.getSession();
		String message = null;
		String user = request.getParameter("user").toString().toLowerCase();
		String pass = request.getParameter("pass").toString();
		boolean keepLogged = request.getParameter("keepLogged") == null ? false : true;

		Client client = ClientBuilder.newClient();
		WebTarget target = client.target("http://localhost:8080/SmartUniversity-API/api/auth");
		Response apiResponse = target.request(MediaType.APPLICATION_JSON).post(Entity.json(new Dot_Login(user, pass)));
		apiResponse.bufferEntity();
		RequestResponse requestResponse = apiResponse.readEntity(RequestResponse.class);
		if (requestResponse.getMessage() == null)
		{
			if (keepLogged)
			{
				Cookie cookie = new Cookie("JSESSIONID", session.getId());
				cookie.setMaxAge(Integer.MAX_VALUE);
				response.addCookie(cookie);
			}

			LoginResponse loginResponse = apiResponse.readEntity(LoginResponse.class);

			session.setAttribute("token", loginResponse.getToken());
			target = client.target("http://localhost:8080/SmartUniversity-API/api/get/" + loginResponse.getId());
			apiResponse = target.request(MediaType.APPLICATION_JSON)
					.header(HttpHeaders.AUTHORIZATION, "Bearer " + session.getAttribute("token").toString()).get();
			apiResponse.bufferEntity();

			requestResponse = apiResponse.readEntity(RequestResponse.class);

			if (requestResponse.getMessage() == null)
			{
				Utilisateur utilisateur = apiResponse.readEntity(Utilisateur.class);

				switch (utilisateur.getUser_type())
				{
				case enseignant:
					Enseignant enseignant = apiResponse.readEntity(Enseignant.class);
					session.setAttribute("utilisateur", enseignant);
					Redirect.SendRedirect(request, response, "/WEB-INF/espace_enseignant/index_enseignant.jsp");
					return;

				default:
					break;
				}

			} else
			{
				System.out.println(requestResponse.getMessage());
				Redirect.SendRedirect(request, response, "login.jsp");
				return;
			}

			apiResponse.close();
		} else
		{
			message = requestResponse.getMessage();
			session.setAttribute("message", message);
			Redirect.SendRedirect(request, response, "login.jsp");
			return;
		}
	}
}