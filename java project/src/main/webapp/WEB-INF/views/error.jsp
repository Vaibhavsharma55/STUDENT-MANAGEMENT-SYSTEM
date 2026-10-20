<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="Error Occurred - Student Management System" />
<%@ include file="common/header.jsp" %>
<%@ include file="common/navbar.jsp" %>

<div class="main-content">
    <div class="container py-5 text-center" style="max-width: 600px;">
        <div class="card card-sms p-4 p-md-5">
            <div class="text-danger mb-3">
                <i class="fa-solid fa-triangle-exclamation display-3"></i>
            </div>
            <h3 class="fw-bold text-dark mb-2">Something Went Wrong</h3>
            <p class="text-muted mb-4">An error occurred while processing your request.</p>

            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger text-start small mb-4">
                    <strong>Error details:</strong><br>
                    ${errorMessage}
                </div>
            </c:if>

            <div class="d-flex justify-content-center gap-2">
                <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-primary-sms px-4">
                    <i class="fa-solid fa-house me-1"></i> Return to Dashboard
                </a>
                <a href="javascript:history.back()" class="btn btn-light border px-4">
                    <i class="fa-solid fa-arrow-left me-1"></i> Go Back
                </a>
            </div>
        </div>
    </div>
</div>

<%@ include file="common/footer.jsp" %>
