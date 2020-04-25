package com.controllers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/FormLink")
public class FormLink extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public FormLink() {
        super();
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	String link = request.getParameter("link");
    	Redirect.SendRedirect(request, response, link);
    }

}
