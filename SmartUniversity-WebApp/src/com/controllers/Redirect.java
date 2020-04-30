package com.controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/Redirect")
public class Redirect extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public Redirect() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String link = null;
		
		try
		{
			link = session.getAttribute("link").toString();			
		} 
		catch (Exception e)
		{
			link = "index.jsp";
		}
		
		request.getRequestDispatcher(link).forward(request, response);
	}
	
	public static void SendRedirect(HttpServletRequest request,HttpServletResponse response, String link)
	{
		HttpSession session = request.getSession();
	
		session.setAttribute("link", link);
		try
		{
			response.sendRedirect("Redirect");
		} 
		catch (IOException e)
		{
			e.printStackTrace();
		}
	}
}
