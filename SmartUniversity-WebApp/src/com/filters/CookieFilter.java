package com.filters;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.utility.Utility;

@WebFilter(filterName =  "CookieFilter", urlPatterns = { "/*" })
public class CookieFilter implements Filter
{
	public CookieFilter()
	{
	}

	public void destroy()
	{
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException
	{
		HttpServletResponse resp = (HttpServletResponse)response;
		HttpServletRequest req = (HttpServletRequest) request;
		
		if(Utility.GetValueOfCookieWithName(req, "lang") == null)
		{
			Cookie c = new Cookie("lang", "en");
			c.setMaxAge(3600*24*365*1000);
			resp.addCookie(c);
		}
		
		chain.doFilter(request, response);
	}

	public void init(FilterConfig fConfig) throws ServletException
	{
	}
}
