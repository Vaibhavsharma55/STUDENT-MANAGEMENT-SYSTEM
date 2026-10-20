<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="Admin Dashboard - Student Management System" />
<c:set var="activePage" value="dashboard" />
<%@ include file="common/header.jsp" %>
<%@ include file="common/navbar.jsp" %>

<div class="main-content">
    <div class="container-fluid px-4">
        
        <!-- Welcome Header Banner -->
        <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center mb-4 pb-2 border-bottom">
            <div>
                <h3 class="fw-bold text-dark mb-1">
                    <i class="fa-solid fa-gauge-high text-primary me-2"></i>Dashboard Overview
                </h3>
                <p class="text-muted mb-0 small">Welcome back, <strong>${sessionScope.admin.fullName}</strong>! Here is an overview of the academic portal.</p>
            </div>
            <div class="mt-3 mt-md-0 d-flex gap-2">
                <a href="${pageContext.request.contextPath}/students?action=new" class="btn btn-primary-sms">
                    <i class="fa-solid fa-user-plus me-1"></i> Add Student
                </a>
                <a href="${pageContext.request.contextPath}/attendance?action=record" class="btn btn-outline-sms">
                    <i class="fa-solid fa-clipboard-user me-1"></i> Mark Attendance
                </a>
                <a href="${pageContext.request.contextPath}/reports?action=student" class="btn btn-outline-secondary">
                    <i class="fa-solid fa-file-invoice me-1"></i> View Report
                </a>
            </div>
        </div>

        <!-- 4 Key Statistic Cards -->
        <div class="row g-3 mb-4">
            <!-- 1. Total Students -->
            <div class="col-12 col-sm-6 col-xl-3">
                <div class="stat-card">
                    <div class="stat-icon blue">
                        <i class="fa-solid fa-user-graduate"></i>
                    </div>
                    <div>
                        <div class="stat-title">Total Enrolled</div>
                        <div class="stat-value">${totalStudents}</div>
                        <a href="${pageContext.request.contextPath}/students" class="small text-decoration-none text-primary fw-semibold">
                            View All Students <i class="fa-solid fa-arrow-right ms-1"></i>
                        </a>
                    </div>
                </div>
            </div>

            <!-- 2. Total Courses -->
            <div class="col-12 col-sm-6 col-xl-3">
                <div class="stat-card">
                    <div class="stat-icon green">
                        <i class="fa-solid fa-book-open-reader"></i>
                    </div>
                    <div>
                        <div class="stat-title">Active Courses</div>
                        <div class="stat-value">${totalCourses}</div>
                        <a href="${pageContext.request.contextPath}/courses" class="small text-decoration-none text-success fw-semibold">
                            Manage Programs <i class="fa-solid fa-arrow-right ms-1"></i>
                        </a>
                    </div>
                </div>
            </div>

            <!-- 3. Today's Attendance -->
            <div class="col-12 col-sm-6 col-xl-3">
                <div class="stat-card">
                    <div class="stat-icon purple">
                        <i class="fa-solid fa-calendar-check"></i>
                    </div>
                    <div>
                        <div class="stat-title">Present Today</div>
                        <div class="stat-value">${presentToday} <span class="fs-6 text-muted fw-normal">(${todayAttendancePct}%)</span></div>
                        <a href="${pageContext.request.contextPath}/attendance" class="small text-decoration-none text-purple fw-semibold" style="color: #9333ea;">
                            Attendance Sheet <i class="fa-solid fa-arrow-right ms-1"></i>
                        </a>
                    </div>
                </div>
            </div>

            <!-- 4. Average Academic Performance -->
            <div class="col-12 col-sm-6 col-xl-3">
                <div class="stat-card">
                    <div class="stat-icon amber">
                        <i class="fa-solid fa-award"></i>
                    </div>
                    <div>
                        <div class="stat-title">Avg. Exam Score</div>
                        <div class="stat-value">${avgPercentage}%</div>
                        <a href="${pageContext.request.contextPath}/marks" class="small text-decoration-none text-warning fw-semibold" style="color: #d97706;">
                            Marks Register <i class="fa-solid fa-arrow-right ms-1"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Main Content Area: Recent Students Table + Quick Actions Sidebar -->
        <div class="row g-4">
            <!-- Left: Recently Enrolled Students Table -->
            <div class="col-12 col-lg-8">
                <div class="card card-sms">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <span><i class="fa-solid fa-clock-rotate-left me-2 text-primary"></i>Recently Registered Students</span>
                        <a href="${pageContext.request.contextPath}/students" class="btn btn-sm btn-outline-sms">View All</a>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-custom table-hover align-middle mb-0">
                                <thead>
                                    <tr>
                                        <th>Roll No</th>
                                        <th>Student Name</th>
                                        <th>Program</th>
                                        <th>Sem</th>
                                        <th class="text-end">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${not empty recentStudents}">
                                            <c:forEach var="s" items="${recentStudents}">
                                                <tr>
                                                    <td class="fw-bold text-primary">${s.rollNo}</td>
                                                    <td>
                                                        <div class="fw-semibold">${s.fullName}</div>
                                                        <div class="text-muted small">${s.email}</div>
                                                    </td>
                                                    <td><span class="badge bg-light text-dark border">${s.courseCode}</span></td>
                                                    <td>Sem ${s.currentSemester}</td>
                                                    <td class="text-end">
                                                        <a href="${pageContext.request.contextPath}/students?action=view&id=${s.id}" 
                                                           class="btn btn-sm btn-light text-primary" title="View Profile">
                                                            <i class="fa-solid fa-eye"></i>
                                                        </a>
                                                        <a href="${pageContext.request.contextPath}/students?action=edit&id=${s.id}" 
                                                           class="btn btn-sm btn-light text-warning" title="Edit Student">
                                                            <i class="fa-solid fa-pen"></i>
                                                        </a>
                                                        <a href="${pageContext.request.contextPath}/reports?action=student&studentId=${s.id}" 
                                                           class="btn btn-sm btn-light text-success" title="Academic Report Card">
                                                            <i class="fa-solid fa-file-lines"></i>
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="5" class="text-center py-4 text-muted">
                                                    No students enrolled yet. Click "Add Student" to begin.
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

            <!-- Right: Quick Navigation & Portal Stats -->
            <div class="col-12 col-lg-4">
                <!-- Quick Tasks -->
                <div class="card card-sms mb-4">
                    <div class="card-header">
                        <i class="fa-solid fa-bolt text-warning me-2"></i>Quick Tasks
                    </div>
                    <div class="list-group list-group-flush rounded-bottom">
                        <a href="${pageContext.request.contextPath}/students?action=new" 
                           class="list-group-item list-group-item-action d-flex align-items-center py-3">
                            <div class="stat-icon blue me-3" style="width: 38px; height: 38px; font-size: 1rem;">
                                <i class="fa-solid fa-user-plus"></i>
                            </div>
                            <div>
                                <div class="fw-semibold text-dark">Register New Student</div>
                                <div class="text-muted small">Add admission, course & semester</div>
                            </div>
                        </a>
                        <a href="${pageContext.request.contextPath}/attendance?action=record" 
                           class="list-group-item list-group-item-action d-flex align-items-center py-3">
                            <div class="stat-icon green me-3" style="width: 38px; height: 38px; font-size: 1rem;">
                                <i class="fa-solid fa-calendar-check"></i>
                            </div>
                            <div>
                                <div class="fw-semibold text-dark">Take Class Attendance</div>
                                <div class="text-muted small">Batch record daily class presence</div>
                            </div>
                        </a>
                        <a href="${pageContext.request.contextPath}/marks?action=new" 
                           class="list-group-item list-group-item-action d-flex align-items-center py-3">
                            <div class="stat-icon amber me-3" style="width: 38px; height: 38px; font-size: 1rem;">
                                <i class="fa-solid fa-pen-nib"></i>
                            </div>
                            <div>
                                <div class="fw-semibold text-dark">Enter Subject Marks</div>
                                <div class="text-muted small">Add exam scores & compute grades</div>
                            </div>
                        </a>
                        <a href="${pageContext.request.contextPath}/reports?action=student" 
                           class="list-group-item list-group-item-action d-flex align-items-center py-3">
                            <div class="stat-icon purple me-3" style="width: 38px; height: 38px; font-size: 1rem;">
                                <i class="fa-solid fa-file-invoice"></i>
                            </div>
                            <div>
                                <div class="fw-semibold text-dark">Print Student Report Card</div>
                                <div class="text-muted small">Consolidated transcript & attendance</div>
                            </div>
                        </a>
                    </div>
                </div>

                <!-- Academic System Info -->
                <div class="card card-sms">
                    <div class="card-header">
                        <i class="fa-solid fa-circle-info text-info me-2"></i>System Architecture
                    </div>
                    <div class="card-body small">
                        <ul class="list-unstyled mb-0">
                            <li class="mb-2 d-flex justify-content-between">
                                <span class="text-muted">Environment:</span>
                                <span class="fw-semibold">Apache Tomcat 11</span>
                            </li>
                            <li class="mb-2 d-flex justify-content-between">
                                <span class="text-muted">Database Engine:</span>
                                <span class="fw-semibold text-success"><i class="fa-solid fa-database me-1"></i>MySQL (sms_db)</span>
                            </li>
                            <li class="mb-2 d-flex justify-content-between">
                                <span class="text-muted">Architecture:</span>
                                <span class="fw-semibold">MVC (Model-View-Controller)</span>
                            </li>
                            <li class="d-flex justify-content-between">
                                <span class="text-muted">Design Theme:</span>
                                <span class="fw-semibold text-primary">Responsive Blue & White</span>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

<%@ include file="common/footer.jsp" %>
