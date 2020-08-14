package com.rest.services;

import java.io.InputStream;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import org.glassfish.jersey.media.multipart.FormDataBodyPart;
import org.glassfish.jersey.media.multipart.FormDataContentDisposition;
import org.glassfish.jersey.media.multipart.FormDataParam;

import com.data.DAO_CongeAcademique;
import com.data.DAO_Justification;
import com.dots.Dot_Create_CongeAcademique;
import com.dots.Dot_Create_Justification;
import com.rest.annotations.Secured;
import com.utility.JsonReader;
import com.utility.Utility;

@Path("/upload")
public class Upload
{
	@POST
	@Secured
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	@Produces(MediaType.APPLICATION_JSON)
	@Path("justification")
	public Response UploadJustificationFile(@FormDataParam("fichier_justification") InputStream uploadedInputStream,
			@FormDataParam("fichier_justification") FormDataContentDisposition fichierJustification,
			@FormDataParam("detail_justification") FormDataBodyPart bodyPart)
	{
		bodyPart.setMediaType(MediaType.APPLICATION_JSON_TYPE);
		Dot_Create_Justification detailJustification = bodyPart.getValueAs(Dot_Create_Justification.class);
		//validation
		detailJustification.Validate();
		//creating
		if(DAO_Justification.CreateJustification(detailJustification, uploadedInputStream))
		{
			return Utility.Response(Status.OK,
					JsonReader.GetNode("justification_created"));
		}
		else 
		{
			return Utility.Response(Status.BAD_REQUEST, 
					JsonReader.GetNode("justification_not_created"));			
		}		
	}	
	
	@POST
	@Secured
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	@Produces(MediaType.APPLICATION_JSON)
	@Path("congeAcademique")
	public Response UploadCongeAcademiqueFile(@FormDataParam("fichier_congeAcademique") InputStream uploadedInputStream,
			@FormDataParam("fichier_congeAcademique") FormDataContentDisposition fichierJustification,
			@FormDataParam("detail_congeAcademique") FormDataBodyPart bodyPart)
	{
		bodyPart.setMediaType(MediaType.APPLICATION_JSON_TYPE);
		Dot_Create_CongeAcademique detailcongeAcademique = bodyPart.getValueAs(Dot_Create_CongeAcademique.class);
		//validation
		detailcongeAcademique.Validate();
		//creating
		if(DAO_CongeAcademique.CreateCongeAcademique(detailcongeAcademique, uploadedInputStream))
		{
			return Utility.Response(Status.OK,
					JsonReader.GetNode("academic_leave_request_created"));
		}
		else 
		{
			return Utility.Response(Status.BAD_REQUEST, 
					JsonReader.GetNode("academic_leave_request_not_created"));			
		}		
	}	
}
