package com.controllers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.ProcessingException;
import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.Entity;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import com.helpers.Dot_Login;
import com.helpers.RequestResponse;

@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Login() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String user = request.getParameter("user");
		String pass = request.getParameter("pass");
		
		//auth
		Client client = ClientBuilder.newClient();
		WebTarget target = client.target("http://localhost:8080/SmartUniversity-API/api/auth");
		Response apiResponse = target.request(MediaType.APPLICATION_JSON).post(Entity.json(new Dot_Login(user, pass)));
		apiResponse.bufferEntity();
		try
		{
			RequestResponse requestResponse = apiResponse.readEntity(RequestResponse.class);
			System.out.println(requestResponse);
		} catch (ProcessingException e)
		{
			String token = apiResponse.readEntity(String.class);
			target = client.target("http://localhost:8080/SmartUniversity-API/api/get/test");
			Response apiResponse2 = target.request(MediaType.APPLICATION_JSON).header(HttpHeaders.AUTHORIZATION, "Bearer "+ token).get();
			System.out.println(apiResponse2.readEntity(String.class));
		}		
		
		response.sendRedirect("index.jsp");
	}

}
