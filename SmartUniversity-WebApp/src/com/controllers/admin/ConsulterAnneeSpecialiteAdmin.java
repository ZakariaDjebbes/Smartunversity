package com.controllers.admin;

import java.io.IOException;
import java.util.ArrayList;
import java.util.EnumSet;
import java.util.TreeMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.modele.Etudiant.Annee;
import com.modele.Etudiant.Specialite;
import com.utility.Utility;

@WebServlet("/User/ConsulterAnneeSpecialiteAdmin")
public class ConsulterAnneeSpecialiteAdmin extends HttpServlet
{
	private static final long serialVersionUID = 1L;

	public ConsulterAnneeSpecialiteAdmin()
	{
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		TreeMap<Annee, ArrayList<Specialite>> specialitesByAnnee = new TreeMap<Annee, ArrayList<Specialite>>();

		for (Annee annee :  new ArrayList<Annee>(EnumSet.allOf(Annee.class)))
		{
			ArrayList<Specialite> specialites = Utility.GetSpecialitesOfAnnee(annee);
			specialitesByAnnee.put(annee, specialites);
		}
		
		
		request.setAttribute("specialitesByAnnee", specialitesByAnnee);
		request.getRequestDispatcher("/WEB-INF/espace_admin/consulter_annee_specialite_admin.jsp").forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
	}
}
