package com.rest.services;

import java.math.BigInteger;
import java.security.SecureRandom;
import java.util.Random;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import com.data.DAO_Etudiant;
import com.data.DAO_Token;
import com.data.DAO_User;
import com.dots.Dot_Login_User;
import com.helpers.LoginResponse;
import com.jsonReaders.MessageReader;
import com.modele.Etudiant;
import com.modele.Etudiant.Etat_Etudiant;
import com.modele.Utilisateur;
import com.modele.Utilisateur.Type_Utilisateur;
import com.rest.exceptions.RequestNotValidException;
import com.utility.Utility;

@Path("/auth")
public class Authentication
{

	@POST
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Response AuthenticationService(Dot_Login_User dots_Login_User)
	{
		// validation
		dots_Login_User.Validate();

		// Authenticate the user using the credentials provided
		Utilisateur userFromDB = Authenticate(dots_Login_User);
		// Issue a token for the user
		String token = IssueToken(userFromDB.getId_utilisateur(), userFromDB.getUser(), dots_Login_User.isAndroid());

		// Return the token on the response
		LoginResponse response = new LoginResponse(token, userFromDB.getId_utilisateur());

		return Utility.Response(Status.OK, response);
	}

	private Utilisateur Authenticate(Dot_Login_User dots_Login_User)
	{
		// Authenticate against a database
		// Throw an Exception if the credentials are invalid
		Utilisateur utilisateur = DAO_User.GetUser(dots_Login_User);
		if (utilisateur == null)
			throw new RequestNotValidException(Status.UNAUTHORIZED, MessageReader.GetNode("invalid_username_password"));
		if (utilisateur.getUser_type() == Type_Utilisateur.etudiant)
		{
			Etudiant etudiant = DAO_Etudiant.GetEtudiantById(utilisateur.getId_utilisateur());
			if (etudiant.getEtat_etudiant() == Etat_Etudiant.bloque)
			{
				throw new RequestNotValidException(Status.UNAUTHORIZED, MessageReader.GetNode("student_blocked"));
			}
		}
		return utilisateur;
	}

	private String IssueToken(int id, String user, boolean isAndroid)
	{
		// Issue a token (can be a random String persisted to a database or a JWT token)
		// The issued token must be associated to a user
		// Return the issued token
		Random random = new SecureRandom();
		String token = new BigInteger(130, random).toString(32 - user.length()) + user.toLowerCase();
		// add token to BD
		if (!isAndroid && DAO_Token.CreateOrUpdateToken(id, token))
			return token;
		else if (isAndroid && DAO_Token.CreateOrUpdateAndroidToken(id, token))
			return token;
		else
			throw new RequestNotValidException(Status.UNAUTHORIZED, MessageReader.GetNode("student_blocked"));
	}
	
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/user")
	public Response CheckUserByEmail(@QueryParam("email") String email)
	{
		int id = DAO_User.CheckUserByEmail(email);
		
		if (id == 0)
		{
			throw new RequestNotValidException(Status.NOT_FOUND, MessageReader.GetNode("email_not_exist"));
		}
		return Utility.Response(Status.OK, id);
	}
	
	@POST
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	@Path("/updatePassword")
	public Response UpdatePassword(@QueryParam("id") int id, @QueryParam("password") String password)
	{
		if(password.length() < Utilisateur.MIN_PASS_LENGHT)
		{
			throw new RequestNotValidException(Status.BAD_REQUEST, MessageReader.GetNode("password_length"));
		}
		
		boolean update = DAO_User.UpdatePassword(id, password);

		if (update == false)
		{
			throw new RequestNotValidException(Status.BAD_REQUEST, MessageReader.GetNode("pass_not_updated"));
		} else
		{
			return Utility.Response(Status.OK, MessageReader.GetNode("pass_updated"));
		}
	}
}