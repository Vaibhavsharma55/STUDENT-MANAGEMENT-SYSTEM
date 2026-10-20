<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="Class Performance Summary - Student Management System" />
<c:set var="activePage" value="reports" />
<%@ include file="../common/header.jsp" %>
<%@ include file="../common/navbar.jsp" %>

<div class="main-content">
    <div class="container-fluid px-4">

        <!-- Page Header -->
        <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center mb-4 pb-2 border-bottom">
            <div>
                <h3 class="fw-bold text-dark mb-1">
                    <i class="fa-solid fa-table-list text-primary me-2"></i>Class Academic Performance Summary
                </h3>
                <p class="text-muted mb-0 small">Cross-student comparison report showing attendance percentages, scores, and grade standings.</p>
            </div>
            <div class="mt-3 mt-md-0 d-flex gap-2 no-print">
                <a href="${pageContext.request.contextPath}/reports?action=student" class="btn btn-outline-secondary">
                    <i class="fa-solid fa-id-card me-1"></i> Individual Report Card
                </a>
                <button type="button" class="btn btn-primary-sms" onclick="printReport()">
                    <i class="fa-solid fa-print me-1"></i> Print Summary
                </button>
            </div>
        </div>

        <!-- Filter Toolbar -->
        <div class="card card-sms mb-4 no-print">
            <div class="card-body p-3">
                <form action="${pageContext.request.contextPath}/reports" method="get" class="row g-2 align-items-center">
                    <input type="hidden" name="action" value="class">

                    <div class="col-12 col-md-5">
                        <select name="courseId" class="form-select">
                            <option value="">-- All Programs --</option>
                            <c:forEach var="c" items="${courses}">
                                <option value="${c.id}" ${c.id == selectedCourseId ? 'selected' : ''}>
                                    ${c.courseCode} - ${c.courseName}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="col-6 col-md-4">
                        <select name="semester" class="form-select">
                            <option value="">-- All Semesters --</option>
                            <c:forEach var="sem" begin="1" end="8">
                                <option value="${sem}" ${sem == selectedSemester ? 'selected' : ''}>Semester ${sem}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="col-6 col-md-3 d-flex gap-2">
                        <button type="submit" class="btn btn-primary-sms flex-grow-1">
                            <i class="fa-solid fa-filter me-1"></i> Generate
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Class Summary Table Card -->
        <div class="card card-sms">
            <div class="card-header d-flex justify-content-between align-items-center">
                <span>
                    <i class="fa-solid fa-users me-2 text-primary"></i>
                    Student Performance List (${reports.size()} enrolled)
                </span>
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
                                <th class="text-center">Attendance %</th>
                                <th class="text-center">Total Marks</th>
                                <th class="text-center">Exam Score %</th>
                                <th class="text-center">Grade</th>
                                <th>Performance Status</th>
                                <th class="text-end no-print">Report</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty reports}">
                                    <c:forEach var="r" items="${reports}">
                                        <tr>
                                            <td class="fw-bold text-primary">${r.student.rollNo}</td>
                                            <td class="fw-semibold text-dark">${r.student.fullName}</td>
                                            <td><span class="badge bg-light text-dark border">${r.student.courseCode}</span></td>
                                            <td>Sem ${r.student.currentSemester}</td>
                                            <td class="text-center">
                                                <span class="badge ${r.attendancePercentage >= 75 ? 'badge-present' : 'badge-absent'}">
                                                    ${r.attendancePercentage}%
                                                </span>
                                            </td>
                                            <td class="text-center">
                                                <c:choose>
                                                    <c:when test="${r.totalMaxMarks > 0}">
                                                        ${r.totalMarksObtained} / ${r.totalMaxMarks}
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted small">N/A</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="text-center fw-bold">
                                                <c:choose>
                                                    <c:when test="${r.totalMaxMarks > 0}">
                                                        ${r.overallPercentage}%
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted small">N/A</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="text-center">
                                                <c:choose>
                                                    <c:when test="${r.totalMaxMarks > 0}">
                                                        <span class="badge ${r.overallGrade == 'A+' || r.overallGrade == 'A' ? 'bg-success' : 'bg-primary'}">
                                                            ${r.overallGrade}
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        -
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <small class="fw-semibold text-secondary">${r.performanceStatus}</small>
                                            </td>
                                            <td class="text-end no-print">
                                                <a href="${pageContext.request.contextPath}/reports?action=student&studentId=${r.student.id}" 
                                                   class="btn btn-sm btn-light text-primary" title="View Full Transcript">
                                                    <i class="fa-solid fa-file-invoice"></i>
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="10" class="text-center py-5 text-muted">
                                            No student records found matching the filter criteria.
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
