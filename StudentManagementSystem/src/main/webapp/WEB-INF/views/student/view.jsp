<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="Student Profile - ${student.fullName}" />
<c:set var="activePage" value="students" />
<%@ include file="../common/header.jsp" %>
<%@ include file="../common/navbar.jsp" %>

<div class="main-content">
    <div class="container-fluid px-4">

        <!-- Header -->
        <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center mb-4 pb-2 border-bottom">
            <div>
                <h3 class="fw-bold text-dark mb-1">
                    <i class="fa-solid fa-id-badge text-primary me-2"></i>Student Profile
                </h3>
                <p class="text-muted mb-0 small">Comprehensive academic record, personal details, attendance, and exam marks.</p>
            </div>
            <div class="mt-3 mt-md-0 d-flex gap-2">
                <a href="${pageContext.request.contextPath}/students" class="btn btn-outline-secondary">
                    <i class="fa-solid fa-arrow-left me-1"></i> All Students
                </a>
                <a href="${pageContext.request.contextPath}/students?action=edit&id=${student.id}" class="btn btn-outline-warning">
                    <i class="fa-solid fa-pen me-1"></i> Edit Student
                </a>
                <a href="${pageContext.request.contextPath}/reports?action=student&studentId=${student.id}" class="btn btn-primary-sms">
                    <i class="fa-solid fa-file-invoice me-1"></i> View Report Card
                </a>
            </div>
        </div>

        <div class="row g-4">
            <!-- Left: Personal & Academic Profile Card -->
            <div class="col-12 col-lg-4">
                <div class="card card-sms text-center p-4 mb-4">
                    <div class="rounded-circle bg-primary text-white d-inline-flex align-items-center justify-content-center mx-auto mb-3" 
                         style="width: 80px; height: 80px; font-size: 2rem; font-weight: bold;">
                        ${student.firstName.substring(0,1)}${student.lastName.substring(0,1)}
                    </div>
                    <h4 class="fw-bold mb-1">${student.fullName}</h4>
                    <div class="text-primary fw-bold fs-6 mb-2">${student.rollNo}</div>
                    <div>
                        <span class="badge bg-primary-subtle text-primary border border-primary-subtle px-3 py-2">
                            ${student.courseCode} - Semester ${student.currentSemester}
                        </span>
                    </div>

                    <hr class="my-4">

                    <div class="text-start small">
                        <div class="mb-2 d-flex justify-content-between">
                            <span class="text-muted"><i class="fa-regular fa-envelope me-1"></i>Email:</span>
                            <span class="fw-semibold text-break">${student.email}</span>
                        </div>
                        <div class="mb-2 d-flex justify-content-between">
                            <span class="text-muted"><i class="fa-solid fa-phone me-1"></i>Phone:</span>
                            <span class="fw-semibold">${student.phone}</span>
                        </div>
                        <div class="mb-2 d-flex justify-content-between">
                            <span class="text-muted"><i class="fa-solid fa-venus-mars me-1"></i>Gender:</span>
                            <span class="fw-semibold">${student.gender}</span>
                        </div>
                        <div class="mb-2 d-flex justify-content-between">
                            <span class="text-muted"><i class="fa-regular fa-calendar me-1"></i>DOB:</span>
                            <span class="fw-semibold">${student.dob}</span>
                        </div>
                        <div class="mb-2 d-flex justify-content-between">
                            <span class="text-muted"><i class="fa-solid fa-graduation-cap me-1"></i>Program:</span>
                            <span class="fw-semibold">${student.courseName}</span>
                        </div>
                        <div class="mt-3">
                            <div class="text-muted mb-1"><i class="fa-solid fa-location-dot me-1"></i>Address:</div>
                            <div class="p-2 bg-light rounded text-dark">${student.address != null && !student.address.isEmpty() ? student.address : 'Not specified'}</div>
                        </div>
                    </div>
                </div>

                <!-- Quick Attendance Snapshot Card -->
                <div class="card card-sms p-3">
                    <div class="card-header bg-white border-0 px-1 py-2 fw-bold text-dark d-flex justify-content-between align-items-center">
                        <span><i class="fa-solid fa-calendar-check text-success me-2"></i>Attendance Summary</span>
                        <span class="badge bg-success fs-6">${attStats.percentage}%</span>
                    </div>
                    <div class="card-body p-0 pt-2">
                        <div class="row g-2 text-center small">
                            <div class="col-3">
                                <div class="p-2 bg-light rounded border">
                                    <div class="text-muted">Total</div>
                                    <div class="fw-bold fs-6">${attStats.total}</div>
                                </div>
                            </div>
                            <div class="col-3">
                                <div class="p-2 bg-success-subtle text-success rounded border border-success-subtle">
                                    <div>Present</div>
                                    <div class="fw-bold fs-6">${attStats.present}</div>
                                </div>
                            </div>
                            <div class="col-3">
                                <div class="p-2 bg-danger-subtle text-danger rounded border border-danger-subtle">
                                    <div>Absent</div>
                                    <div class="fw-bold fs-6">${attStats.absent}</div>
                                </div>
                            </div>
                            <div class="col-3">
                                <div class="p-2 bg-warning-subtle text-warning rounded border border-warning-subtle">
                                    <div>Late</div>
                                    <div class="fw-bold fs-6">${attStats.late}</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Right: Academic Performance & Marks Records -->
            <div class="col-12 col-lg-8">
                <!-- Academic Stats Banner -->
                <div class="row g-3 mb-4">
                    <div class="col-12 col-md-4">
                        <div class="stat-card">
                            <div class="stat-icon amber">
                                <i class="fa-solid fa-percent"></i>
                            </div>
                            <div>
                                <div class="stat-title">Overall Score</div>
                                <div class="stat-value">${marksAgg.percentage}%</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-md-4">
                        <div class="stat-card">
                            <div class="stat-icon green">
                                <i class="fa-solid fa-medal"></i>
                            </div>
                            <div>
                                <div class="stat-title">Overall Grade</div>
                                <div class="stat-value">${marksAgg.grade}</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-md-4">
                        <div class="stat-card">
                            <div class="stat-icon blue">
                                <i class="fa-solid fa-chart-pie"></i>
                            </div>
                            <div>
                                <div class="stat-title">Status</div>
                                <div class="fw-bold text-dark fs-5 mt-1">${marksAgg.performanceStatus}</div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Marks Table -->
                <div class="card card-sms">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <span><i class="fa-solid fa-book text-primary me-2"></i>Academic Marks & Evaluations</span>
                        <a href="${pageContext.request.contextPath}/marks?action=new&studentId=${student.id}" class="btn btn-sm btn-primary-sms">
                            <i class="fa-solid fa-plus me-1"></i> Add Subject Marks
                        </a>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-custom table-hover align-middle mb-0">
                                <thead>
                                    <tr>
                                        <th>Sem</th>
                                        <th>Subject Name</th>
                                        <th>Exam Type</th>
                                        <th>Marks Obtained</th>
                                        <th>Max Marks</th>
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
                                                    <td>Sem ${m.semester}</td>
                                                    <td class="fw-semibold text-dark">${m.subjectName}</td>
                                                    <td><span class="badge bg-light text-secondary border">${m.examType}</span></td>
                                                    <td class="fw-bold text-primary">${m.marksObtained}</td>
                                                    <td>${m.maxMarks}</td>
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
                                            <!-- Total summary row -->
                                            <tr class="table-light fw-bold">
                                                <td colspan="3" class="text-end">Total / Overall:</td>
                                                <td class="text-primary">${marksAgg.totalObtained}</td>
                                                <td>${marksAgg.totalMax}</td>
                                                <td>${marksAgg.percentage}%</td>
                                                <td><span class="badge bg-dark">${marksAgg.grade}</span></td>
                                                <td></td>
                                            </tr>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="8" class="text-center py-4 text-muted">
                                                    No exam marks entered for this student yet. Click "Add Subject Marks" above.
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

    </div>
</div>

<%@ include file="../common/footer.jsp" %>
