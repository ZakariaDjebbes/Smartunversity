package com.controllers.chefDepartement;

import java.io.IOException;
import java.util.ArrayList;
import java.util.EnumSet;

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

import com.helpers.StatistiquesResponse;
import com.helpers.RequestResponse;
import com.modele.ChefDepartement;
import com.modele.Seance.Jour;

@WebServlet("/User/ConsulterStatistiquesChefDepartement")
public class ConsulterStatistiquesChefDepartement extends HttpServlet
{
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		HttpSession session = request.getSession(false);
		UpdateDataFromAPI(session, request);

		request.setAttribute("jours", new ArrayList<Jour>(EnumSet.allOf(Jour.class)));
		request.getRequestDispatcher(
				"/WEB-INF/espace_enseignant/espace_chef_departement/consulter_statistiques_chef_departement.jsp")
				.forward(request, response);
	}

	private void UpdateDataFromAPI(HttpSession session, HttpServletRequest request)
	{
		ChefDepartement chefDepartement = (ChefDepartement) session.getAttribute("utilisateur");
		
		Client client = ClientBuilder.newClient();
		WebTarget target = client.target("http://localhost:8080/SmartUniversity-API/api/get/data/departement")
				.queryParam("code_departement", chefDepartement.getCode_departement());
		Response apiResponse = target.request(MediaType.APPLICATION_JSON)
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + session.getAttribute("token")).get();
		apiResponse.bufferEntity();
		
		RequestResponse requestResponse = RequestResponse.GetRequestResponse(apiResponse);
		
		ArrayList<StatistiquesResponse> data= new ArrayList<StatistiquesResponse>();

		if (requestResponse == null)
		{
			data = apiResponse.readEntity(new GenericType<ArrayList<StatistiquesResponse>>() {});
		} else
		{
			System.out.println("Séance sans enseignant avec absences, c'est normal !");
		}

		request.setAttribute("data", data);
	}
}
