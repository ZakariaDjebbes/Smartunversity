package com.filters;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletResponse;

@WebFilter("/*")
public class PreventCaching implements Filter {
    public PreventCaching() {
    }

	public void destroy() {
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletResponse responseS = (HttpServletResponse) response;

        responseS.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
        responseS.setHeader("Pragma", "no-cache"); // HTTP 1.0.
        responseS.setDateHeader("Expires", 0); // Proxies.

        chain.doFilter(request, response);
	}

	public void init(FilterConfig fConfig) throws ServletException {
	}

}
