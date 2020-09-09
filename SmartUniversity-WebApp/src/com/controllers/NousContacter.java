package com.controllers;

import java.io.IOException;

import javax.mail.MessagingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jsonReaders.ConfigReader;
import com.mailer.Mailer;

@WebServlet("/NousContacter")
public class NousContacter extends HttpServlet
{
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		boolean isDone = false;
		String nom = request.getParameter("nom");
		String message = request.getParameter("message");
		String sujet = request.getParameter("sujet");
		String email = request.getParameter("email");
		
		String mailBody = String.format(
				"<h1>Message du système de gestion d'absences de la faculté NTIC</h1>"
			   +"<b>Nom: </b> %s"
			   +"<br>"
			   +"<b>Email: </b> %s"
			   +"<br>"
			   +"<hr>"
			   +"<h3>Sujet: %s</h3>"
			   +"<p>%s</p>", nom, email, sujet, message);
		String mailSubject = String.format("Message de contact de la faculté NTIC [%s]", nom);
		try
		{
			
			Mailer.SendMail(ConfigReader.GetNode("mailerConfig", "user"), mailSubject, mailBody);
			isDone = true;
		} catch (MessagingException e)
		{
			System.out.println("Erreur dans l'envoi du mail >>> " + e.getMessage());
		}
		
		request.setAttribute("isDone", isDone);
		request.getRequestDispatcher("nous-contacter.jsp").forward(request, response);
	}
}
