package com.controllers.enseignant;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.Response;

import com.controllers.Redirect;
import com.helpers.RequestResponse;
import com.modele.Utilisateur;
import com.utility.Utility;

@WebServlet("/User/SupprimerProfil")
public class SupprimerProfil extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
       
    public SupprimerProfil() 
    {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		HttpSession session = request.getSession();
		String message = "";
		Utilisateur utilisateur = (Utilisateur)session.getAttribute("utilisateur");
		String token = session.getAttribute("token").toString();
		Client client = ClientBuilder.newClient();
		WebTarget target = client.target("http://localhost:8080/SmartUniversity-API/api/delete/utilisateur/"+utilisateur.getId_utilisateur());
		Response apiResponse = target.request().header(HttpHeaders.AUTHORIZATION, "Bearer "+token).delete();
		RequestResponse requestResponse = apiResponse.readEntity(RequestResponse.class);
		session.invalidate();
		
		session = request.getSession();
		message = requestResponse.getMessage(Utility.GetValueOfCookieWithName(request, "lang"));
		session.setAttribute("message", message);
		Redirect.SendRedirect(request, response, "index.jsp");
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
	{
		doGet(req, resp);
	}
}
