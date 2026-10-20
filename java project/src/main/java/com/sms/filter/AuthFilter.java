package com.sms.filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Authentication filter protecting all administrative pages and actions.
 */
@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        // Force UTF-8 character encoding
        req.setCharacterEncoding("UTF-8");
        res.setCharacterEncoding("UTF-8");

        String path = req.getRequestURI().substring(req.getContextPath().length());

        // Allow static resources
        if (path.startsWith("/css/") || path.startsWith("/js/") || path.startsWith("/images/") 
                || path.endsWith(".css") || path.endsWith(".js") || path.endsWith(".png") 
                || path.endsWith(".jpg") || path.endsWith(".ico")) {
            chain.doFilter(request, response);
            return;
        }

        // Allow public pages: login, login action, root redirect
        boolean isLoginRequest = path.equals("/login") || path.equals("/login.jsp") || path.equals("/");

        HttpSession session = req.getSession(false);
        boolean isLoggedIn = (session != null && session.getAttribute("admin") != null);

        if (isLoggedIn) {
            // If already logged in and visiting login or root, redirect to dashboard
            if (isLoginRequest && !path.equals("/dashboard")) {
                res.sendRedirect(req.getContextPath() + "/dashboard");
                return;
            }
            chain.doFilter(request, response);
        } else {
            // Not logged in
            if (isLoginRequest) {
                chain.doFilter(request, response);
            } else {
                res.sendRedirect(req.getContextPath() + "/login?error=Session expired. Please log in.");
            }
        }
    }

    @Override
    public void destroy() {
    }
}
