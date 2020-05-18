package com.controllers;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/CallServlet")
@MultipartConfig
public class CallServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public CallServlet() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		Part filePart = request.getPart("file");
		String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
		
		File uploads = new File(getServletContext().getInitParameter("upload.location") + fileName);

		
		try (InputStream input = filePart.getInputStream()) 
		{
		    Files.copy(input, uploads.toPath());
		}
//		//auth
//		Client client = ClientBuilder.newClient();
//		WebTarget target = client.target("http://localhost:8080/SmartUniversity-API/api/auth");
//		Response apiResponse = target.request(MediaType.APPLICATION_JSON).post(Entity.json(new Dot_Login(user, pass)));
//		apiResponse.bufferEntity();
//		try
//		{
//			RequestResponse requestResponse = apiResponse.readEntity(RequestResponse.class);
//			System.out.println(requestResponse);
//		} catch (ProcessingException e)
//		{
//			String token = apiResponse.readEntity(String.class);
//			target = client.target("http://localhost:8080/SmartUniversity-API/api/get/test");
//			Response apiResponse2 = target.request(MediaType.APPLICATION_JSON).header(HttpHeaders.AUTHORIZATION, "Bearer "+ token).get();
//			System.out.println(apiResponse2.readEntity(String.class));
//		}		
		
		response.sendRedirect("index.jsp");
	}

}
