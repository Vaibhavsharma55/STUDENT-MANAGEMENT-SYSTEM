<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="Attendance Register - Student Management System" />
<c:set var="activePage" value="attendance" />
<%@ include file="../common/header.jsp" %>
<%@ include file="../common/navbar.jsp" %>

<div class="main-content">
    <div class="container-fluid px-4">

        <!-- Page Header -->
        <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center mb-4 pb-2 border-bottom">
            <div>
                <h3 class="fw-bold text-dark mb-1">
                    <i class="fa-solid fa-calendar-check text-primary me-2"></i>Attendance Log
                </h3>
                <p class="text-muted mb-0 small">Daily class attendance monitoring, presence records, and status reports.</p>
            </div>
            <div class="mt-3 mt-md-0">
                <a href="${pageContext.request.contextPath}/attendance?action=record" class="btn btn-primary-sms shadow-sm">
                    <i class="fa-solid fa-clipboard-user me-1"></i> Mark Class Attendance
                </a>
            </div>
        </div>

        <!-- Filter Toolbar -->
        <div class="card card-sms mb-4">
            <div class="card-body p-3">
                <form action="${pageContext.request.contextPath}/attendance" method="get" class="row g-2 align-items-center">
                    <div class="col-12 col-md-3">
                        <label class="form-label small fw-semibold text-muted mb-1">Attendance Date</label>
                        <input type="date" name="date" class="form-control" value="${selectedDate}">
                    </div>

                    <div class="col-6 col-md-4">
                        <label class="form-label small fw-semibold text-muted mb-1">Program</label>
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
                        <label class="form-label small fw-semibold text-muted mb-1">Semester</label>
                        <select name="semester" class="form-select">
                            <option value="">-- All Semesters --</option>
                            <c:forEach var="sem" begin="1" end="8">
                                <option value="${sem}" ${sem == selectedSemester ? 'selected' : ''}>Semester ${sem}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="col-12 col-md-3 d-flex align-items-end gap-2 pt-md-4">
                        <button type="submit" class="btn btn-primary-sms flex-grow-1">
                            <i class="fa-solid fa-filter me-1"></i> Filter Date
                        </button>
                        <a href="${pageContext.request.contextPath}/attendance" class="btn btn-outline-secondary" title="Reset">
                            <i class="fa-solid fa-rotate-left"></i>
                        </a>
                    </div>
                </form>
            </div>
        </div>

        <!-- Attendance Table Card -->
        <div class="card card-sms">
            <div class="card-header d-flex justify-content-between align-items-center">
                <span>
                    <i class="fa-solid fa-clipboard-list me-2 text-primary"></i>
                    Records for Date: <strong class="text-primary">${selectedDate}</strong> (${attendanceList.size()} entries)
                </span>
                <div>
                    <a href="${pageContext.request.contextPath}/attendance?action=record&date=${selectedDate}&courseId=${selectedCourseId}&semester=${selectedSemester}" 
                       class="btn btn-sm btn-outline-sms">
                        <i class="fa-solid fa-pen-to-square me-1"></i> Update This Date
                    </a>
                </div>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-custom table-hover align-middle mb-0">
                        <thead>
                            <tr>
                                <th>Roll Number</th>
                                <th>Student Name</th>
                                <th>Program</th>
                                <th>Date</th>
                                <th>Status</th>
                                <th>Teacher Remarks</th>
                                <th class="text-end">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty attendanceList}">
                                    <c:forEach var="a" items="${attendanceList}">
                                        <tr>
                                            <td class="fw-bold text-primary">${a.studentRollNo}</td>
                                            <td class="fw-semibold text-dark">${a.studentName}</td>
                                            <td><span class="badge bg-light text-dark border">${a.courseCode}</span></td>
                                            <td>${a.attendanceDate}</td>
                                            <td>
                                                <span class="badge badge-status 
                                                    ${a.status == 'Present' ? 'badge-present' : 
                                                      (a.status == 'Absent' ? 'badge-absent' : 
                                                      (a.status == 'Late' ? 'badge-late' : 'badge-excused'))}">
                                                    <i class="fa-solid ${a.status == 'Present' ? 'fa-check' : (a.status == 'Absent' ? 'fa-xmark' : 'fa-clock')} me-1"></i>
                                                    ${a.status}
                                                </span>
                                            </td>
                                            <td class="text-muted small">${not empty a.remarks ? a.remarks : '-'}</td>
                                            <td class="text-end">
                                                <a href="${pageContext.request.contextPath}/attendance?action=delete&id=${a.id}&date=${selectedDate}" 
                                                   class="btn btn-sm btn-light text-danger" title="Remove Entry"
                                                   onclick="return confirmAction('Delete this attendance entry?');">
                                                    <i class="fa-solid fa-trash"></i>
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="7" class="text-center py-5">
                                            <div class="text-muted">
                                                <i class="fa-regular fa-calendar-xmark display-6 mb-3 text-secondary d-block"></i>
                                                <p class="mb-2">No attendance logged for <strong>${selectedDate}</strong>.</p>
                                                <a href="${pageContext.request.contextPath}/attendance?action=record&date=${selectedDate}&courseId=${selectedCourseId}&semester=${selectedSemester}" 
                                                   class="btn btn-sm btn-primary-sms">
                                                    Record Attendance Now
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
