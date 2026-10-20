<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="Manage Students - Student Management System" />
<c:set var="activePage" value="students" />
<%@ include file="../common/header.jsp" %>
<%@ include file="../common/navbar.jsp" %>

<div class="main-content">
    <div class="container-fluid px-4">

        <!-- Page Header -->
        <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center mb-4 pb-2 border-bottom">
            <div>
                <h3 class="fw-bold text-dark mb-1">
                    <i class="fa-solid fa-user-graduate text-primary me-2"></i>Student Directory
                </h3>
                <p class="text-muted mb-0 small">Manage, search, edit, and view enrolled students across all courses.</p>
            </div>
            <div class="mt-3 mt-md-0">
                <a href="${pageContext.request.contextPath}/students?action=new" class="btn btn-primary-sms shadow-sm">
                    <i class="fa-solid fa-user-plus me-1"></i> Register New Student
                </a>
            </div>
        </div>

        <!-- Filter & Search Toolbar -->
        <div class="card card-sms mb-4">
            <div class="card-body p-3">
                <form action="${pageContext.request.contextPath}/students" method="get" class="row g-2 align-items-center">
                    <div class="col-12 col-md-4">
                        <div class="input-group">
                            <span class="input-group-text bg-white text-muted border-end-0">
                                <i class="fa-solid fa-magnifying-glass"></i>
                            </span>
                            <input type="text" name="keyword" class="form-control border-start-0" 
                                   placeholder="Search by Roll No, Name or Email..." value="${keyword}">
                        </div>
                    </div>

                    <div class="col-6 col-md-3">
                        <select name="courseId" class="form-select">
                            <option value="">-- All Programs --</option>
                            <c:forEach var="c" items="${courses}">
                                <option value="${c.id}" ${c.id == selectedCourseId ? 'selected' : ''}>
                                    ${c.courseCode} - ${c.courseName}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="col-6 col-md-2">
                        <select name="semester" class="form-select">
                            <option value="">-- All Semesters --</option>
                            <c:forEach var="sem" begin="1" end="8">
                                <option value="${sem}" ${sem == selectedSemester ? 'selected' : ''}>Semester ${sem}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="col-12 col-md-3 d-flex gap-2">
                        <button type="submit" class="btn btn-primary-sms flex-grow-1">
                            <i class="fa-solid fa-filter me-1"></i> Filter
                        </button>
                        <a href="${pageContext.request.contextPath}/students" class="btn btn-outline-secondary" title="Reset Filters">
                            <i class="fa-solid fa-rotate-left"></i>
                        </a>
                    </div>
                </form>
            </div>
        </div>

        <!-- Students Table Card -->
        <div class="card card-sms">
            <div class="card-header d-flex justify-content-between align-items-center">
                <span><i class="fa-solid fa-list me-2 text-primary"></i>Enrolled Students List (${students.size()} found)</span>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-custom table-hover align-middle mb-0">
                        <thead>
                            <tr>
                                <th>Roll Number</th>
                                <th>Student Name</th>
                                <th>Program</th>
                                <th>Semester</th>
                                <th>Gender</th>
                                <th>Contact Details</th>
                                <th class="text-center" style="width: 170px;">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty students}">
                                    <c:forEach var="s" items="${students}">
                                        <tr>
                                            <td class="fw-bold text-primary">
                                                <a href="${pageContext.request.contextPath}/students?action=view&id=${s.id}" class="text-decoration-none">
                                                    ${s.rollNo}
                                                </a>
                                            </td>
                                            <td>
                                                <div class="fw-semibold text-dark">${s.fullName}</div>
                                                <div class="text-muted small"><i class="fa-regular fa-calendar me-1"></i>DOB: ${s.dob}</div>
                                            </td>
                                            <td>
                                                <span class="badge bg-primary-subtle text-primary border border-primary-subtle fw-semibold">
                                                    ${s.courseCode}
                                                </span>
                                            </td>
                                            <td>
                                                <span class="badge bg-light text-dark border">Semester ${s.currentSemester}</span>
                                            </td>
                                            <td>${s.gender}</td>
                                            <td>
                                                <div><i class="fa-regular fa-envelope me-1 text-muted"></i>${s.email}</div>
                                                <div class="text-muted small"><i class="fa-solid fa-phone me-1 text-muted"></i>${s.phone}</div>
                                            </td>
                                            <td class="text-center">
                                                <div class="btn-group btn-group-sm">
                                                    <a href="${pageContext.request.contextPath}/students?action=view&id=${s.id}" 
                                                       class="btn btn-light text-primary" title="View Profile">
                                                        <i class="fa-solid fa-eye"></i>
                                                    </a>
                                                    <a href="${pageContext.request.contextPath}/reports?action=student&studentId=${s.id}" 
                                                       class="btn btn-light text-success" title="Report Card">
                                                        <i class="fa-solid fa-file-invoice"></i>
                                                    </a>
                                                    <a href="${pageContext.request.contextPath}/marks?action=new&studentId=${s.id}" 
                                                       class="btn btn-light text-info" title="Add Marks">
                                                        <i class="fa-solid fa-plus"></i>
                                                    </a>
                                                    <a href="${pageContext.request.contextPath}/students?action=edit&id=${s.id}" 
                                                       class="btn btn-light text-warning" title="Edit Student">
                                                        <i class="fa-solid fa-pen"></i>
                                                    </a>
                                                    <a href="${pageContext.request.contextPath}/students?action=delete&id=${s.id}" 
                                                       class="btn btn-light text-danger" title="Delete Student"
                                                       onclick="return confirmAction('Are you sure you want to delete student ${s.rollNo}? This will also delete related attendance and marks records.');">
                                                        <i class="fa-solid fa-trash"></i>
                                                    </a>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="7" class="text-center py-5">
                                            <div class="text-muted">
                                                <i class="fa-solid fa-user-slash display-6 mb-3 text-secondary d-block"></i>
                                                <p class="mb-2 fs-6">No students found matching your criteria.</p>
                                                <a href="${pageContext.request.contextPath}/students?action=new" class="btn btn-sm btn-primary-sms">
                                                    Register New Student
                                                </a>
                                            </div>
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
