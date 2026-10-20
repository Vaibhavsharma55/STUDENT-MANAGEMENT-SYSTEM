<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Redirect to dashboard if logged in, or login if not logged in (handled by AuthFilter)
    response.sendRedirect(request.getContextPath() + "/dashboard");
%>
