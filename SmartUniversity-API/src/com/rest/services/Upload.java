package com.rest.services;

import java.io.InputStream;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
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
import com.data.DAO_QR;
import com.dots.Dot_CongeAcademique_Android;
import com.dots.Dot_Create_CongeAcademique;
import com.dots.Dot_Create_Justification;
import com.dots.Dot_Create_QR;
import com.dots.Dot_Justification_Android;
import com.jsonReaders.MessageReader;
import com.rest.annotations.Secured;
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
		// validation
		detailJustification.Validate();
		// creating
		if (DAO_Justification.CreateJustification(detailJustification, uploadedInputStream))
		{
			return Utility.Response(Status.OK, MessageReader.GetNode("justification_created"));
		} else
		{
			return Utility.Response(Status.BAD_REQUEST, MessageReader.GetNode("justification_not_created"));
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
		// validation
		detailcongeAcademique.Validate();
		// creating
		if (DAO_CongeAcademique.CreateCongeAcademique(detailcongeAcademique, uploadedInputStream))
		{
			return Utility.Response(Status.OK, MessageReader.GetNode("academic_leave_request_created"));
		} else
		{
			return Utility.Response(Status.BAD_REQUEST, MessageReader.GetNode("academic_leave_request_not_created"));
		}
	}

	@PUT
	@Secured
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Path("justification/android")
	public Response UploadJustificationFile(Dot_Justification_Android justification)
	{
		// creating
		if (DAO_Justification.CreateJustification(justification))
		{
			return Utility.Response(Status.OK, null);
		} else
		{
			return Utility.Response(Status.BAD_REQUEST, null);
		}
	}

	@PUT
	@Secured
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Path("congeAcademique/android")
	public Response UploadCongeAcademiqueFile(Dot_CongeAcademique_Android congeAcademique)
	{
		congeAcademique.Validate();
		
		if (DAO_CongeAcademique.CreateCongeAcademique(congeAcademique))
		{
			return Utility.Response(Status.OK, null);
		} else
		{
			return Utility.Response(Status.BAD_REQUEST, null);
		}
	}

	@PUT
	@Secured
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Path("qr/android")
	public Response CreateCodeQR(Dot_Create_QR dot_create_qr)

	{

		if (DAO_QR.createCodeQR(dot_create_qr))
		{
			return Utility.Response(Status.OK, null);
		} else
		{
			return Utility.Response(Status.BAD_REQUEST, null);
		}
	}

}
