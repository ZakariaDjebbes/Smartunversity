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

@WebFilter("/User/*")
public class CheckLogged implements Filter {

    public CheckLogged() {
    }

	public void destroy() {
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest requestS = (HttpServletRequest) request;
		HttpServletResponse responseS = (HttpServletResponse) response;
		HttpSession session = requestS.getSession(false);
		
		/*check session*/
		if(session == null || session.getAttribute("utilisateur") == null)
		{
			//if no session or no attritube user then none is logged therefore redirect to login page...
            responseS.sendRedirect(requestS.getContextPath() + "/login.jsp");
		}
		else
		{
			//if someone is logged, whenever they do something that requiries loggin check their token from the API
			//TODO do this
			chain.doFilter(request, response);	
		}
	}
	public void init(FilterConfig fConfig) throws ServletException {
	}
}
