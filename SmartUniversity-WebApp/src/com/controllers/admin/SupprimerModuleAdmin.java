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
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import com.controllers.Redirect;
import com.helpers.RequestResponse;
import com.utility.Utility;

@WebServlet("/User/SupprimerModuleAdmin")
public class SupprimerModuleAdmin extends HttpServlet
{
	private static final long serialVersionUID = 1L;

	public SupprimerModuleAdmin()
	{
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		HttpSession session = request.getSession(false);
		String message = "";
		boolean isDone = true;
		String code_module = request.getParameter("code-module");
		String token = session.getAttribute("token").toString();
		Client client = ClientBuilder.newClient();
		WebTarget target = client.target("http://localhost:8080/SmartUniversity-API/api/delete/module")
				.queryParam("code_module", code_module);
		Response apiResponse = target.request().header(HttpHeaders.AUTHORIZATION, "Bearer "+token).delete();
		if (apiResponse.getStatusInfo() != Status.OK)
		{
			isDone = false;
		}
		RequestResponse requestResponse = apiResponse.readEntity(RequestResponse.class);		
		message = requestResponse.getMessage(Utility.GetValueOfCookieWithName(request, "lang"));
		session.setAttribute("message", message);
		session.setAttribute("isDone", isDone);
		Redirect.SendRedirect(request, response, "/User/ConsulterListeModulesAdmin");
	}
}
