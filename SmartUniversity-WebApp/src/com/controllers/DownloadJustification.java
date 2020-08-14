package com.controllers;

import java.io.BufferedInputStream;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLConnection;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import com.modele.Etudiant;
import com.modele.Justification;

/**
 * Servlet implementation class DownloadJustification
 */
@WebServlet("/User/DownloadJustification")
public class DownloadJustification extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public DownloadJustification() 
    {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		HttpSession session = request.getSession();
		String token = session.getAttribute("token").toString();
		int numero_absence = Integer.parseInt(request.getParameter("numero-absence"));
		int numero_justification = Integer.parseInt(request.getParameter("numero-justification"));
		int id_etudiant = Integer.parseInt(request.getParameter("id-etudiant"));
		
		Client client = ClientBuilder.newClient();
		WebTarget target = client.target(
				"http://localhost:8080/SmartUniversity-API/api/get/justification")
				.queryParam("numero_absence", numero_absence)
				.queryParam("numero_justification", numero_justification);
		Response apiResponse = target.request(MediaType.APPLICATION_JSON)
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + token).get();
		apiResponse.bufferEntity();
		
		Justification justification = apiResponse.readEntity(Justification.class);
		
		target = client.target(
				"http://localhost:8080/SmartUniversity-API/api/get/user/" + id_etudiant);
		apiResponse = target.request(MediaType.APPLICATION_JSON)
				.header(HttpHeaders.AUTHORIZATION, "Bearer " + token).get();
		
		Etudiant etudiant = apiResponse.readEntity(Etudiant.class);
		
		byte[] byteArrayFile = justification.getFichier();
		InputStream inputStream = new BufferedInputStream(new ByteArrayInputStream(byteArrayFile));
		String fileName = String.format("%s-%s-%s",
				etudiant.getNom(), 
				etudiant.getPrenom(), 
				new SimpleDateFormat("yyyy-MM-dd").format(justification.getDate_justification()));
		
		String fileType = URLConnection.guessContentTypeFromStream(inputStream);
		String fileExtension = justification.getExtension();
		
		ServletOutputStream outStream = response.getOutputStream();
		response.setContentType(fileType);
		response.setHeader("Content-Disposition", "attachment; filename="+ fileName + "." + fileExtension +" ");
		outStream.write(justification.getFichier());
		outStream.flush();
	}
}
