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
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import com.controllers.Redirect;
import com.helpers.RequestResponse;
import com.modele.Module;
import com.utility.Utility;

@WebServlet("/User/ConsulterModuleAdmin")
public class ConsulterModuleAdmin extends HttpServlet
{
	private static final long serialVersionUID = 1L;
	public ConsulterModuleAdmin()
	{
		super();
	}

	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		HttpSession session = request.getSession(false);
		ConsulterListeModulesAdmin.UpdateModulesFromAPI(session);
		String code_module = request.getParameter("code-module").toString();
		ArrayList<Module> modules = (ArrayList<Module>) session.getAttribute("modules");
		Module module = null;
		
		for (Module item : modules)
		{
			if(item.getCode_module().equals(code_module))
			{
				module = item;
			}
		}
				
		if(module == null)
		{
			//TODO error page?
		}
		session.setAttribute("module", module);
		
		request.getRequestDispatcher("/WEB-INF/espace_admin/consulter_module_admin.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		HttpSession session = request.getSession(false);
		Module oldModule = GetOldModule(request);
		Module newModule = GetNewModule(request);
		String message = "";
		boolean isDone = true;
		
		if(newModule.equals(oldModule))
		{
			isDone = false;
			message = "Veuillez changer au moin un prametre";
		}
		
		Client client = ClientBuilder.newClient();
		WebTarget target = client.target("http://localhost:8080/SmartUniversity-API/api/update/admin/module")
				.queryParam("old_code_module", oldModule.getCode_module());
		Response apiResponse = target.request(MediaType.APPLICATION_JSON)
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + session.getAttribute("token").toString())
				.post(Entity.json(newModule));
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
		if(isDone)
		{
			Redirect.SendRedirect(request, response, "/User/ConsulterModuleAdmin?code-module=" + newModule.getCode_module());			
		}
		else
		{
			Redirect.SendRedirect(request, response, "/User/ConsulterModuleAdmin?code-module=" + oldModule.getCode_module());			
		}
	}
	
	private Module GetNewModule(HttpServletRequest request)
	{
		String nom = request.getParameter("nom");
		String code_module = request.getParameter("code-module");
		return new Module(code_module, nom);
	}
	
	private Module GetOldModule(HttpServletRequest request)
	{
		String code_module = request.getParameter("old-code-module");
		String nom = request.getParameter("old-nom-module");
		return new Module(code_module, nom);
	}
}
