<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.modele.Utilisateur"%>
<%
if(session.getAttribute("utilisateur") != null)
{
	Utilisateur utilisateur = (Utilisateur)session.getAttribute("utilisateur");

	switch(utilisateur.getUser_type())
	{
		case etudiant:
			return;
		
		case enseignant:
			session.setAttribute("link", "/WEB-INF/espace_enseignant/index_enseignant.jsp");
			response.sendRedirect("Redirect");
			return;
		case chefDepartement:
			return;
		case responsableFormation:
			return;
		case admin:
			return;
		default:
			return;
	}
}
%>