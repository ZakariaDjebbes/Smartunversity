package com.rest.services;

import javax.ws.rs.Consumes;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import com.data.DAO_Enseignant;
import com.data.DAO_User;
import com.dots.Dots_Login_User;
import com.helpers.RequestReponse;
import com.helpers.Utility;
import com.modele.Utilisateur;
import com.rest.annotations.Secured;
import com.rest.exceptions.RequestNotValidException;

@Path("/update")
public class Update
{
	// Access to this service is :
	// http://localhost:8080/SmartUniversity-API/api/update/updateUser
	@Secured
	@PUT
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/updateUser")
	public Response UpdateUser(Utilisateur utilisateur)
	{
		// validation
		Dots_Login_User dots_Login_User = new Dots_Login_User(utilisateur.getUser(), utilisateur.getPass());

		dots_Login_User.Validate();

		// request
		int updatedRows = DAO_User.UpdateUser(utilisateur);

		if (updatedRows == 0)
		{
			throw new RequestNotValidException(Status.BAD_REQUEST,
					new RequestReponse("Update failed due to a bad request"));
		} else
		{
			Utilisateur userFromDB = DAO_User.GetUserByID(utilisateur.getId());
			switch (userFromDB.getUser_type())
			{
			case enseignant:
				userFromDB = DAO_Enseignant.GetEnseignant(userFromDB);
				break;

			default:
				break;
			}

			return Utility.Response(Status.OK, userFromDB);
		}
	}
}
