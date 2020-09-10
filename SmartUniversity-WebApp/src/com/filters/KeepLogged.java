package com.filters;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.controllers.Login;
import com.modele.Utilisateur;

@WebFilter(urlPatterns =
{ "/index.jsp", "/nous-contacter.jsp", "/login.jsp" })
public class KeepLogged implements Filter
{
	public KeepLogged()
	{
	}

	public void destroy()
	{
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException
	{
		HttpServletRequest requestS = (HttpServletRequest) request;
		HttpServletResponse responseS = (HttpServletResponse) response;
		HttpSession session = requestS.getSession(false);
		if (!requestS.getServletPath().contains("/User/") && session != null
				&& session.getAttribute("utilisateur") != null)
		{
			Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");

			switch (utilisateur.getUser_type())
			{
			case etudiant:
				Login.SetAbsencesNonJustifier(session);
				Login.SetHasCongeAcademique(session);
				Login.SetAbsencesNonTraite(session);
				requestS.getRequestDispatcher("/WEB-INF/espace_etudiant/index_etudiant.jsp").forward(requestS,
						responseS);
				return;

			case enseignant:
				requestS.getRequestDispatcher("/WEB-INF/espace_enseignant/index_enseignant.jsp").forward(requestS,
						responseS);
				return;
			case chefDepartement:
				Login.SetSeancesSansEnseignant(session);
				Login.SetDemandesNonTraite(session);
				requestS.getRequestDispatcher(
						"/WEB-INF/espace_enseignant/espace_chef_departement/index_chef_departement.jsp")
						.forward(requestS, responseS);
				return;
			case responsableFormation:
				requestS.getRequestDispatcher("/WEB-INF/espace_enseignant/espace_responsable_formation/index_responsable_formation.jsp").forward(requestS,
						responseS);
				return;
			case admin:
				requestS.getRequestDispatcher("/WEB-INF/espace_admin/index_admin.jsp").forward(requestS, responseS);
				return;
			default:
				return;
			}
		} else
		{
			chain.doFilter(request, response);
		}
	}

	public void init(FilterConfig fConfig) throws ServletException
	{
	}
}
