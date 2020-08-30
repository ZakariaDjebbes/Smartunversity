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
import javax.ws.rs.client.Entity;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import com.google.gson.Gson;
import com.helpers.NotificationResponse;
import com.helpers.RequestResponse;

@WebServlet("/User/SetNotificationVue")
public class SetNotificationVue extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		HttpSession session = request.getSession(false);
		String token = session.getAttribute("token").toString();
		int id_notification = Integer.parseInt(request.getParameter("id_notification"));
		
		Client client = ClientBuilder.newClient();
		WebTarget target = client.target(
				"http://localhost:8080/SmartUniversity-API/api/update/notification/setVue")
				.queryParam("id_notification", id_notification);
		Response apiResponse = target.request(MediaType.APPLICATION_JSON)
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + token).post(Entity.json(null));
		apiResponse.bufferEntity();
		RequestResponse requestResponse = RequestResponse.GetRequestResponse(apiResponse);
		
		NotificationResponse notificationsReponse;
		
		if(requestResponse == null)
		{
			notificationsReponse = apiResponse.readEntity(NotificationResponse.class);
			String jsont_notifs = new Gson().toJson(notificationsReponse);
			response.setContentType("application/json");
		    response.setCharacterEncoding("UTF-8");
		    response.getWriter().write(jsont_notifs);
		}
	}
}
