package com.controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UpdateCookieLocale")
public class UpdateCookieLocale extends HttpServlet
{
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		 if (request.getParameter("cookieLocale") != null) 
	        {
	            Cookie cookie = new Cookie("lang", request.getParameter("cookieLocale"));
	            response.addCookie(cookie);
	        }
		 
		 response.sendRedirect(request.getContextPath());
	}
}
