<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="Manage Courses - Student Management System" />
<c:set var="activePage" value="courses" />
<%@ include file="../common/header.jsp" %>
<%@ include file="../common/navbar.jsp" %>

<div class="main-content">
    <div class="container-fluid px-4">

        <!-- Page Header -->
        <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center mb-4 pb-2 border-bottom">
            <div>
                <h3 class="fw-bold text-dark mb-1">
                    <i class="fa-solid fa-book-open text-primary me-2"></i>Academic Courses & Programs
                </h3>
                <p class="text-muted mb-0 small">Manage degrees, curriculum departments, and semester structures.</p>
            </div>
            <div class="mt-3 mt-md-0">
                <a href="${pageContext.request.contextPath}/courses?action=new" class="btn btn-primary-sms shadow-sm">
                    <i class="fa-solid fa-plus me-1"></i> Add New Course
                </a>
            </div>
        </div>

        <!-- Courses Table Card -->
        <div class="card card-sms">
            <div class="card-header d-flex justify-content-between align-items-center">
                <span><i class="fa-solid fa-layer-group me-2 text-primary"></i>Available Academic Programs (${courses.size()})</span>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-custom table-hover align-middle mb-0">
                        <thead>
                            <tr>
                                <th style="width: 140px;">Course Code</th>
                                <th>Program Name</th>
                                <th style="width: 160px;">Duration / Semesters</th>
                                <th>Program Description</th>
                                <th class="text-end" style="width: 140px;">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty courses}">
                                    <c:forEach var="c" items="${courses}">
                                        <tr>
                                            <td class="fw-bold text-primary">
                                                <span class="badge bg-primary-subtle text-primary border border-primary-subtle fs-6">
                                                    ${c.courseCode}
                                                </span>
                                            </td>
                                            <td class="fw-semibold text-dark">${c.courseName}</td>
                                            <td>
                                                <span class="badge bg-light text-dark border">
                                                    <i class="fa-solid fa-calendar-days me-1 text-primary"></i>${c.totalSemesters} Semesters
                                                </span>
                                            </td>
                                            <td class="text-muted small">${c.description}</td>
                                            <td class="text-end">
                                                <div class="btn-group btn-group-sm">
                                                    <a href="${pageContext.request.contextPath}/students?courseId=${c.id}" 
                                                       class="btn btn-light text-primary" title="View Enrolled Students">
                                                        <i class="fa-solid fa-users"></i>
                                                    </a>
                                                    <a href="${pageContext.request.contextPath}/courses?action=edit&id=${c.id}" 
                                                       class="btn btn-light text-warning" title="Edit Course">
                                                        <i class="fa-solid fa-pen"></i>
                                                    </a>
                                                    <a href="${pageContext.request.contextPath}/courses?action=delete&id=${c.id}" 
                                                       class="btn btn-light text-danger" title="Delete Course"
                                                       onclick="return confirmAction('Delete course ${c.courseCode}? This cannot be undone if students are enrolled.');">
                                                        <i class="fa-solid fa-trash"></i>
                                                    </a>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="5" class="text-center py-4 text-muted">
                                            No courses found. Click "Add New Course" to add one.
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    </div>
</div>

<%@ include file="../common/footer.jsp" %>
