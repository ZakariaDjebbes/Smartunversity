package com.controllers.etudiant;

import java.io.IOException;
import java.util.Scanner;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.Entity;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import org.apache.commons.io.FilenameUtils;
import org.glassfish.jersey.media.multipart.FormDataMultiPart;
import org.glassfish.jersey.media.multipart.MultiPart;
import org.glassfish.jersey.media.multipart.MultiPartFeature;
import org.glassfish.jersey.media.multipart.file.StreamDataBodyPart;

import com.controllers.Redirect;
import com.dots.Dot_Create_CongeAcademique;
import com.helpers.RequestResponse;
import com.utility.Utility;

@WebServlet("/User/DemanderCongeAcademique")
@MultipartConfig
public class DemanderCongeAcademique extends HttpServlet
{
	private static final long serialVersionUID = 1L;

	public DemanderCongeAcademique()
	{
		super();
	}
	
	@SuppressWarnings("resource")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		HttpSession session = request.getSession(false);
		String token = session.getAttribute("token").toString();
		String message = "";
		boolean isDone = true;

		Part p_id_etidant = request.getPart("id-etudiant");
		int id_etudiant = -1;

		try (Scanner scanner = new Scanner(p_id_etidant.getInputStream()))
		{
			id_etudiant = scanner.nextInt();
		}
		Part filePart = request.getPart("fichier-congeAcademique");
		Dot_Create_CongeAcademique dot_Create_CongeAcademique= new Dot_Create_CongeAcademique(id_etudiant, 
				FilenameUtils.getExtension(filePart.getSubmittedFileName()));
		StreamDataBodyPart sdbp = new StreamDataBodyPart("fichier_congeAcademique", filePart.getInputStream());
		
		MultiPart multipartEntity = new FormDataMultiPart()
				.field("detail_congeAcademique", dot_Create_CongeAcademique, MediaType.APPLICATION_JSON_TYPE)
				.bodyPart(sdbp);
		
		Client client = ClientBuilder.newClient();
		client.register(MultiPartFeature.class);
		WebTarget target = client.target("http://localhost:8080/SmartUniversity-API/api/upload/congeAcademique");
		Response apiResponse = target.request(MediaType.APPLICATION_JSON)
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + token)
				.post(Entity.entity(multipartEntity, MediaType.MULTIPART_FORM_DATA));
		RequestResponse requestResponse = apiResponse.readEntity(RequestResponse.class);

		if (apiResponse.getStatusInfo() == Status.OK)
		{
			message = requestResponse.getMessage(Utility.GetValueOfCookieWithName(request, "lang"));
		} else
		{
			isDone = false;
			message = requestResponse.getMessage(Utility.GetValueOfCookieWithName(request, "lang"));
		}

		session.setAttribute("isDone", isDone);
		session.setAttribute("message", message);
		Redirect.SendRedirect(request, response, "/User/ConsulterCongeAcademique");		
	}
}
