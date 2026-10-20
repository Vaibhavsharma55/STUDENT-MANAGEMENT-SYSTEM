<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="Marks & Performance - Student Management System" />
<c:set var="activePage" value="marks" />
<%@ include file="../common/header.jsp" %>
<%@ include file="../common/navbar.jsp" %>

<div class="main-content">
    <div class="container-fluid px-4">

        <!-- Page Header -->
        <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center mb-4 pb-2 border-bottom">
            <div>
                <h3 class="fw-bold text-dark mb-1">
                    <i class="fa-solid fa-chart-column text-primary me-2"></i>Marks & Academic Evaluations
                </h3>
                <p class="text-muted mb-0 small">Manage examination scores, subject evaluations, percentage computations, and grades.</p>
            </div>
            <div class="mt-3 mt-md-0">
                <a href="${pageContext.request.contextPath}/marks?action=new" class="btn btn-primary-sms shadow-sm">
                    <i class="fa-solid fa-plus me-1"></i> Enter Subject Marks
                </a>
            </div>
        </div>

        <!-- Filter Toolbar -->
        <div class="card card-sms mb-4">
            <div class="card-body p-3">
                <form action="${pageContext.request.contextPath}/marks" method="get" class="row g-2 align-items-center">
                    <div class="col-12 col-md-4">
                        <div class="input-group">
                            <span class="input-group-text bg-white text-muted border-end-0">
                                <i class="fa-solid fa-magnifying-glass"></i>
                            </span>
                            <input type="text" name="keyword" class="form-control border-start-0" 
                                   placeholder="Search by Roll No, Student Name or Subject..." value="${keyword}">
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
                        <a href="${pageContext.request.contextPath}/marks" class="btn btn-outline-secondary" title="Reset Filters">
                            <i class="fa-solid fa-rotate-left"></i>
                        </a>
                    </div>
                </form>
            </div>
        </div>

        <!-- Marks Table Card -->
        <div class="card card-sms">
            <div class="card-header d-flex justify-content-between align-items-center">
                <span><i class="fa-solid fa-list-ol me-2 text-primary"></i>Recorded Marks List (${marksList.size()} entries)</span>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-custom table-hover align-middle mb-0">
                        <thead>
                            <tr>
                                <th>Roll Number</th>
                                <th>Student Name</th>
                                <th>Program</th>
                                <th>Sem</th>
                                <th>Subject Name</th>
                                <th>Exam Type</th>
                                <th>Score</th>
                                <th>Percentage</th>
                                <th>Grade</th>
                                <th class="text-end">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty marksList}">
                                    <c:forEach var="m" items="${marksList}">
                                        <tr>
                                            <td class="fw-bold text-primary">
                                                <a href="${pageContext.request.contextPath}/students?action=view&id=${m.studentId}" class="text-decoration-none">
                                                    ${m.studentRollNo}
                                                </a>
                                            </td>
                                            <td class="fw-semibold text-dark">${m.studentName}</td>
                                            <td><span class="badge bg-light text-dark border">${m.courseCode}</span></td>
                                            <td>Sem ${m.semester}</td>
                                            <td class="fw-semibold">${m.subjectName}</td>
                                            <td><span class="badge bg-light text-secondary border small">${m.examType}</span></td>
                                            <td>
                                                <strong class="text-primary">${m.marksObtained}</strong> / ${m.maxMarks}
                                            </td>
                                            <td>
                                                <fmt:formatNumber value="${m.percentage}" maxFractionDigits="1" />%
                                            </td>
                                            <td>
                                                <span class="badge ${m.grade == 'A+' || m.grade == 'A' ? 'bg-success' : (m.grade == 'B' || m.grade == 'C' ? 'bg-primary' : 'bg-warning text-dark')}">
                                                    ${m.grade}
                                                </span>
                                            </td>
                                            <td class="text-end">
                                                <div class="btn-group btn-group-sm">
                                                    <a href="${pageContext.request.contextPath}/reports?action=student&studentId=${m.studentId}" 
                                                       class="btn btn-light text-success" title="Student Report Card">
                                                        <i class="fa-solid fa-file-invoice"></i>
                                                    </a>
                                                    <a href="${pageContext.request.contextPath}/marks?action=edit&id=${m.id}" 
                                                       class="btn btn-light text-warning" title="Edit Mark">
                                                        <i class="fa-solid fa-pen"></i>
                                                    </a>
                                                    <a href="${pageContext.request.contextPath}/marks?action=delete&id=${m.id}" 
                                                       class="btn btn-light text-danger" title="Delete Mark"
                                                       onclick="return confirmAction('Delete mark record for ${m.subjectName}?');">
                                                        <i class="fa-solid fa-trash"></i>
                                                    </a>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="10" class="text-center py-5 text-muted">
                                            <i class="fa-solid fa-file-circle-xmark display-6 mb-3 text-secondary d-block"></i>
                                            <p class="mb-2">No marks records found.</p>
                                            <a href="${pageContext.request.contextPath}/marks?action=new" class="btn btn-sm btn-primary-sms">
                                                Enter Subject Marks
                                            </a>
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
