package com.controllers;

import java.io.IOException;
import java.util.Date;
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

import com.dots.Dot_Create_Justification;
import com.helpers.RequestResponse;
import com.utility.Utility;

@MultipartConfig
@WebServlet("/User/UploadJustification")
public class UploadJustification extends HttpServlet
{
	private static final long serialVersionUID = 1L;

	public UploadJustification()
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

		Part s_numero_absence = request.getPart("numero-absence");
		int numero_absence = -1;

		try (Scanner scanner = new Scanner(s_numero_absence.getInputStream()))
		{
			numero_absence = scanner.nextInt();
		}
		Part filePart = request.getPart("ficiher-justification");
		Dot_Create_Justification dot_Create_Justification = new Dot_Create_Justification(numero_absence, new Date(), FilenameUtils.getExtension(filePart.getSubmittedFileName()));
		StreamDataBodyPart sdbp = new StreamDataBodyPart("fichier_justification", filePart.getInputStream());
		
		MultiPart multipartEntity = new FormDataMultiPart().field("detail_justification", dot_Create_Justification, MediaType.APPLICATION_JSON_TYPE)
				.bodyPart(sdbp);
		
		Client client = ClientBuilder.newClient();
		client.register(MultiPartFeature.class);
		WebTarget target = client.target("http://localhost:8080/SmartUniversity-API/api/upload/justification");
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
		Redirect.SendRedirect(request, response, "/User/ConsulterAbsence?numero-absence=" + numero_absence);
	}
}
