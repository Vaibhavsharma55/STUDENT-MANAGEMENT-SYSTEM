<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<nav class="navbar navbar-expand-lg navbar-dark navbar-custom no-print">
    <div class="container-fluid px-4">
        <a class="navbar-brand d-flex align-items-center" href="${pageContext.request.contextPath}/dashboard">
            <i class="fa-solid fa-graduation-cap me-2 fs-4"></i>
            <span>EduManage SMS</span>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#smsNavbar" 
                aria-controls="smsNavbar" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="smsNavbar">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-3">
                <li class="nav-item">
                    <a class="nav-link ${activePage == 'dashboard' ? 'active' : ''}" href="${pageContext.request.contextPath}/dashboard">
                        <i class="fa-solid fa-gauge me-1"></i> Dashboard
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${activePage == 'students' ? 'active' : ''}" href="${pageContext.request.contextPath}/students">
                        <i class="fa-solid fa-user-graduate me-1"></i> Students
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${activePage == 'courses' ? 'active' : ''}" href="${pageContext.request.contextPath}/courses">
                        <i class="fa-solid fa-book-open me-1"></i> Courses
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${activePage == 'attendance' ? 'active' : ''}" href="${pageContext.request.contextPath}/attendance">
                        <i class="fa-solid fa-calendar-check me-1"></i> Attendance
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${activePage == 'marks' ? 'active' : ''}" href="${pageContext.request.contextPath}/marks">
                        <i class="fa-solid fa-chart-column me-1"></i> Marks
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${activePage == 'reports' ? 'active' : ''}" href="${pageContext.request.contextPath}/reports">
                        <i class="fa-solid fa-file-lines me-1"></i> Reports
                    </a>
                </li>
            </ul>

            <div class="d-flex align-items-center text-white">
                <div class="me-3 text-end d-none d-md-block">
                    <div class="fw-semibold small">${sessionScope.admin != null ? sessionScope.admin.fullName : "Admin"}</div>
                    <div class="text-white-50" style="font-size: 0.75rem;">Administrator</div>
                </div>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-sm btn-light text-primary fw-semibold" title="Logout">
                    <i class="fa-solid fa-right-from-bracket me-1"></i> Logout
                </a>
            </div>
        </div>
    </div>
</nav>

<!-- System Flash Messages -->
<div class="container-fluid px-4 mt-3 no-print">
    <c:if test="${not empty param.msg}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="fa-solid fa-circle-check me-2"></i> ${param.msg}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${not empty param.error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="fa-solid fa-circle-exclamation me-2"></i> ${param.error}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="fa-solid fa-circle-exclamation me-2"></i> ${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
</div>
