package com.controllers.enseignant;

import java.io.IOException;
import java.util.ArrayList;
import java.util.EnumSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.modele.Seance.Jour;

@WebServlet("/User/ConsulterStatistiquesEnseignant")
public class ConsulterStatistiquesEnseignant extends HttpServlet
{
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		HttpSession session = request.getSession(false);
		ConsulterSeancesEnseignant.UpadteSeancesFromAPI(session);
		
		request.setAttribute("jours", new ArrayList<Jour>(EnumSet.allOf(Jour.class)));
		request.getRequestDispatcher("/WEB-INF/espace_enseignant/consulter_statistiques_enseignant.jsp").forward(request, response);
	}
}
