package com.mailer;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

public class Mailer
{
	private static InputStream is =  Mailer.class.getClassLoader().getResourceAsStream("/config.json");
	private static BufferedReader br = new BufferedReader(new InputStreamReader(is));
	private static Gson gson = new Gson();
	private static JsonObject body = gson.fromJson(br, JsonObject.class);
	private static JsonObject config = body.getAsJsonObject("mailerConfig");
	
	public static void SendMail(String recepient, String mailSubject, String mailBody) throws MessagingException
	{
		Properties properties = new Properties();
		properties.put("mail.smtp.auth", config.get("mail.smtp.auth").getAsString());
		properties.put("mail.smtp.starttls.enable", config.get("mail.smtp.starttls.enable").getAsString());
		properties.put("mail.smtp.host", config.get("mail.smtp.host").getAsString());
		properties.put("mail.smtp.port", config.get("mail.smtp.port").getAsString());
		
		String user = config.get("user").getAsString();
		String password = config.get("password").getAsString();
		Session session = Session.getDefaultInstance(properties, new Authenticator()
		{
			@Override
			protected javax.mail.PasswordAuthentication getPasswordAuthentication()
			{
				return new javax.mail.PasswordAuthentication(user, password);
			}
		});
		
		Message message = PrepareMessage(session, user, recepient, mailSubject, mailBody);
		Transport.send(message);
	}
	
	private static Message PrepareMessage(Session session, String user, String recepient, String mailSubject, String mailBody)
	{
		try
		{
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(user));
			message.setRecipient(Message.RecipientType.TO, new InternetAddress(recepient));
			message.setSubject(mailSubject);
			message.setContent(mailBody, config.get("mailBody").getAsString());
			
			return message;
		} 
		catch (Exception e)
		{
			System.out.println("Erreur dans l'envoi du mail ! " + e.getMessage());
		} 
		return null;
	}
	
	/*
	String email = membre.getAdress();
	String mailBody = String.format("<h1>Bonjour %s %s</h1>"
			+ "<p>Votre réservation pour l'activité <b>%s</b> "
			+ "<br>"
			+ "a été annuler en raison de problèmes internes, nous nous excusons de la gêne occasionné."
			+ "<br>"
			+ "Vous pouvez consulter votre page de Gestion des Réservation pour plus d'informations sur vos Réservations!"
			+ "<br>"
			+ "<p>Nous vous souhaitons une bonne journée,</p>"
			+ "<br>"
			+ "<p>Cordialement, L'équipe Belair Club</p>", membre.getNom(), membre.getPrenom(), activite.getDesigniation());
	String mailSubject = "Confirmation D'annulation de Reservation BelairClub";
	try
	{
		JavaMailUtility.SendMail(email, mailSubject, mailBody);
	} 
	catch (MessagingException e)
	{
		System.out.println("Erreur dans l'envoi du mail >>> " + e.getMessage());
	}
	*/
}
