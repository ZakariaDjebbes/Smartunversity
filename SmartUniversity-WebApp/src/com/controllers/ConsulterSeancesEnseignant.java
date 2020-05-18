package com.controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

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

import com.helpers.RequestResponse;
import com.helpers.SeanceResponse;
import com.modele.Enseignant;

/**
 * Servlet implementation class ConsulterSeances
 */
@WebServlet("/ConsulterSeancesEnseignant")
public class ConsulterSeancesEnseignant extends HttpServlet
{
	private static final long serialVersionUID = 1L;

	public ConsulterSeancesEnseignant()
	{
		super();
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
	{
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		HttpSession session = request.getSession();
		ConsulterSeancesEnseignant.UpadteSeancesFromAPI(session);
		
		Redirect.SendRedirect(request, response, "/WEB-INF/espace_enseignant/consulter_seance_enseignant.jsp");
	}

	public static void UpadteSeancesFromAPI(HttpSession session)
	{	
		String token = session.getAttribute("token").toString();
		Enseignant enseignant = (Enseignant) session.getAttribute("utilisateur");

		Client client = ClientBuilder.newClient();
		WebTarget target = client.target(
				"http://localhost:8080/SmartUniversity-API/api/get/seances/full/" + enseignant.getId_utilisateur());
		Response apiResponse = target.request(MediaType.APPLICATION_JSON)
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + token).get();
		apiResponse.bufferEntity();
		RequestResponse requestResponse = RequestResponse.GetRequestResponse(apiResponse);
		ArrayList<SeanceResponse> seancesResponse = new ArrayList<SeanceResponse>();
		if (requestResponse == null)
		{
			seancesResponse = apiResponse.readEntity(new GenericType<ArrayList<SeanceResponse>>()
			{
			});
		} else
		{
			System.out.println("erreur GetSeanceFromAPI ???? devrait JAMAIS arrivé MERDE....");
		}
		
		
//		try (FileOutputStream fos = new FileOutputStream("C://Storage/mabite.wordx")) {
//			   try
//			{
//				fos.write(seancesResponse.get(0).getEtudiants().get(1).getAbsences().get(0).getJustification().getFichier());
//			} catch (IOException e)
//			{
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
//			   //fos.close(); There is no more need for this line since you had created the instance of "fos" inside the try. And this will automatically close the OutputStream
//			} catch (FileNotFoundException e1)
//			{
//				// TODO Auto-generated catch block
//				e1.printStackTrace();
//			} catch (IOException e1)
//			{
//				// TODO Auto-generated catch block
//				e1.printStackTrace();
//			}
//		
		if (seancesResponse.size() > 1)
		{
			Collections.sort(seancesResponse, new Comparator<SeanceResponse>()
			{
				@Override
				public int compare(SeanceResponse seance1, SeanceResponse seance2)
				{
					return seance1.getModule().getNom().compareTo(seance2.getModule().getNom());
				}
			});
		}
		
		session.setAttribute("seances", seancesResponse);
	}
	
}
