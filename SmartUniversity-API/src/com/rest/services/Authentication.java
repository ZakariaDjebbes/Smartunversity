package com.rest.services;

import java.math.BigInteger;
import java.security.SecureRandom;
import java.util.Random;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import com.data.DAO_Token;
import com.data.DAO_User;
import com.dots.Dots_Login_User;
import com.helpers.LoginResponse;
import com.helpers.RequestReponse;
import com.helpers.Utility;
import com.modele.Utilisateur;
import com.rest.exceptions.RequestNotValidException;

@Path("/auth")
public class Authentication
{

	@POST
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Response AuthenticationService(Dots_Login_User dots_Login_User)
	{
		//validation
		dots_Login_User.Validate();
		
		// Authenticate the user using the credentials provided
		Utilisateur userFromDB = Authenticate(dots_Login_User);
		// Issue a token for the user
		String token = IssueToken(userFromDB.getId_utilisateur(), userFromDB.getUser());

		// Return the token on the response
		LoginResponse response = new LoginResponse(token, userFromDB.getId_utilisateur());
		
		return Utility.Response(Status.OK, response);
	}

	private Utilisateur Authenticate(Dots_Login_User dots_Login_User)
	{
		// Authenticate against a database
		// Throw an Exception if the credentials are invalid
		Utilisateur utilisateur = DAO_User.GetUser(dots_Login_User);
		if (utilisateur == null)
			throw new RequestNotValidException(Status.UNAUTHORIZED,
					new RequestReponse("Invalid username and password combination"));
		
		return utilisateur;
	}

	private String IssueToken(int id, String user)
	{
		// Issue a token (can be a random String persisted to a database or a JWT token)
		// The issued token must be associated to a user
		// Return the issued token
		Random random = new SecureRandom();
		String token = new BigInteger(130, random).toString(32 - user.length()) + user.toLowerCase();
		// add token to BD
		if(DAO_Token.CreateOrUpdateToken(id, token))
			return token;
		else 
			throw new RequestNotValidException(Status.UNAUTHORIZED,
						new RequestReponse("Unable to create or update authorization token"));
	}
}