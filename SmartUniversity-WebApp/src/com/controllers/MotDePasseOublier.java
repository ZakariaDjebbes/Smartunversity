package com.controllers;

import java.io.IOException;

import javax.mail.MessagingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import com.helpers.RequestResponse;
import com.mailer.Mailer;
import com.utility.Utility;

@WebServlet("/MotDePasseOublier")
public class MotDePasseOublier extends HttpServlet
{
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		request.getRequestDispatcher("/WEB-INF/pass_oublier.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		HttpSession session = request.getSession();
		
		String email = request.getParameter("email");
				
		Client client = ClientBuilder.newClient();
		WebTarget target = client.target(
				"http://localhost:8080/SmartUniversity-API/api/auth/user")
				.queryParam("email", email);
				Response apiResponse = target.request(MediaType.APPLICATION_JSON).get();
		apiResponse.bufferEntity();
		RequestResponse requestResponse = RequestResponse.GetRequestResponse(apiResponse);
		
		response.setContentType("text/plain");
	    response.setCharacterEncoding("UTF-8");
		
	    if(requestResponse == null)
		{
			int id = apiResponse.readEntity(Integer.class);
			String code = Utility.generateRandomString(8);
			
			session.setAttribute("id", id);
			session.setAttribute("code", code);
			
			String mailBody = String.format(
					"<h1>Modification de votre mot de passe</h1>"
				   +"<p>Vous avez demander une réinitialisation de mot de passe pour votre compte du système de gestion d'absences NTIC</p>"
				   +"<p><b>Code: </b> %s</p>"
				   +"<h3>Si vous n'avez pas fait cette demande, veuillez ignorer ce message.</h3>", code);

			String mailSubject = "Réinitialisation de votre mot de passe Faculté NTIC";
			try
			{
				Mailer.SendMail(email, mailSubject, mailBody);
			} catch (MessagingException e)
			{
				System.out.println("Erreur dans l'envoi du mail >>> " + e.getMessage());
			}
			
		    response.getWriter().write("");    
		}
		else
		{
		    response.getWriter().write(requestResponse.getMessage_fr());    
		}
	}
}
