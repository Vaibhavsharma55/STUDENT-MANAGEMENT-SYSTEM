<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="pageTitle" value="Student Academic Report - ${report.student.fullName}" />
<c:set var="activePage" value="reports" />
<%@ include file="../common/header.jsp" %>
<%@ include file="../common/navbar.jsp" %>

<div class="main-content">
    <div class="container-fluid px-4" style="max-width: 950px;">

        <!-- Selector Toolbar (Hidden during print) -->
        <div class="card card-sms mb-4 no-print">
            <div class="card-body p-3">
                <form action="${pageContext.request.contextPath}/reports" method="get" class="row g-2 align-items-center">
                    <input type="hidden" name="action" value="student">

                    <div class="col-12 col-md-6">
                        <label class="form-label small fw-semibold text-muted mb-1">Select Student</label>
                        <select name="studentId" class="form-select" onchange="this.form.submit()">
                            <c:forEach var="s" items="${students}">
                                <option value="${s.id}" ${s.id == selectedStudentId ? 'selected' : ''}>
                                    ${s.rollNo} - ${s.fullName} (${s.courseCode}, Sem ${s.currentSemester})
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="col-6 col-md-3">
                        <label class="form-label small fw-semibold text-muted mb-1">Semester Filter</label>
                        <select name="semester" class="form-select" onchange="this.form.submit()">
                            <option value="">-- All Semesters --</option>
                            <c:forEach var="sem" begin="1" end="8">
                                <option value="${sem}" ${sem == selectedSemester ? 'selected' : ''}>Semester ${sem}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="col-6 col-md-3 d-flex align-items-end gap-2 pt-md-4">
                        <button type="button" class="btn btn-primary-sms flex-grow-1" onclick="printReport()">
                            <i class="fa-solid fa-print me-1"></i> Print / Save PDF
                        </button>
                        <a href="${pageContext.request.contextPath}/reports?action=class" class="btn btn-outline-secondary" title="Class Summary Report">
                            <i class="fa-solid fa-table-list"></i>
                        </a>
                    </div>
                </form>
            </div>
        </div>

        <c:choose>
            <c:when test="${not empty report}">
                <!-- Printable Academic Report Card Sheet -->
                <div class="card card-sms p-4 p-md-5 mb-4 shadow-sm" style="border: 2px solid var(--border-color);">
                    
                    <!-- Institute Header -->
                    <div class="text-center pb-4 mb-4 border-bottom">
                        <div class="d-flex justify-content-center align-items-center mb-2">
                            <i class="fa-solid fa-graduation-cap display-5 text-primary me-3"></i>
                            <div>
                                <h2 class="fw-bold mb-0 text-dark" style="letter-spacing: 1px;">EDUMANAGE INSTITUTE OF TECHNOLOGY</h2>
                                <p class="text-muted mb-0 small text-uppercase">Affiliated to State Technical University | Department of Academic Affairs</p>
                            </div>
                        </div>
                        <div class="badge bg-primary px-3 py-2 fs-6 text-uppercase tracking-wider mt-2">
                            Official Student Academic Performance Report
                        </div>
                    </div>

                    <!-- Student Profile Meta Table -->
                    <div class="row g-3 mb-4">
                        <div class="col-12 col-md-6">
                            <table class="table table-sm table-borderless mb-0">
                                <tr>
                                    <td class="text-muted" style="width: 140px;">Student Name:</td>
                                    <td class="fw-bold text-dark">${report.student.fullName}</td>
                                </tr>
                                <tr>
                                    <td class="text-muted">Roll Number:</td>
                                    <td class="fw-bold text-primary">${report.student.rollNo}</td>
                                </tr>
                                <tr>
                                    <td class="text-muted">Program / Degree:</td>
                                    <td class="fw-semibold">${report.student.courseName}</td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-12 col-md-6">
                            <table class="table table-sm table-borderless mb-0">
                                <tr>
                                    <td class="text-muted" style="width: 140px;">Current Semester:</td>
                                    <td class="fw-bold">Semester ${report.student.currentSemester}</td>
                                </tr>
                                <tr>
                                    <td class="text-muted">Email / Contact:</td>
                                    <td>${report.student.email} | ${report.student.phone}</td>
                                </tr>
                                <tr>
                                    <td class="text-muted">Date of Report:</td>
                                    <td><fmt:formatDate value="<%= new java.util.Date() %>" pattern="dd MMMM yyyy" /></td>
                                </tr>
                            </table>
                        </div>
                    </div>

                    <!-- Attendance Summary Box -->
                    <div class="p-3 bg-light rounded border mb-4">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <h6 class="fw-bold text-primary mb-0">
                                <i class="fa-solid fa-calendar-check me-2"></i>Attendance Record
                            </h6>
                            <span class="badge ${report.attendancePercentage >= 75 ? 'bg-success' : 'bg-warning text-dark'} fs-6">
                                ${report.attendancePercentage}% Attendance Rate
                            </span>
                        </div>
                        <div class="row text-center small g-2">
                            <div class="col-3">
                                <div class="bg-white p-2 rounded border">
                                    <div class="text-muted">Total Working Days</div>
                                    <div class="fw-bold fs-6">${report.totalAttendanceDays}</div>
                                </div>
                            </div>
                            <div class="col-3">
                                <div class="bg-white p-2 rounded border text-success">
                                    <div>Days Present</div>
                                    <div class="fw-bold fs-6">${report.presentDays}</div>
                                </div>
                            </div>
                            <div class="col-3">
                                <div class="bg-white p-2 rounded border text-danger">
                                    <div>Days Absent</div>
                                    <div class="fw-bold fs-6">${report.absentDays}</div>
                                </div>
                            </div>
                            <div class="col-3">
                                <div class="bg-white p-2 rounded border text-warning">
                                    <div>Days Late</div>
                                    <div class="fw-bold fs-6">${report.lateDays}</div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Subject Marks Transcript Table -->
                    <h6 class="fw-bold text-primary mb-3">
                        <i class="fa-solid fa-file-lines me-2"></i>Subject-Wise Marks Transcript
                    </h6>
                    <div class="table-responsive mb-4">
                        <table class="table table-bordered table-custom align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th style="width: 70px;">Sem</th>
                                    <th>Course Subject</th>
                                    <th>Examination</th>
                                    <th class="text-center" style="width: 130px;">Marks Obtained</th>
                                    <th class="text-center" style="width: 120px;">Max Marks</th>
                                    <th class="text-center" style="width: 110px;">Percentage</th>
                                    <th class="text-center" style="width: 90px;">Grade</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${not empty report.marksList}">
                                        <c:forEach var="m" items="${report.marksList}">
                                            <tr>
                                                <td class="text-center">${m.semester}</td>
                                                <td class="fw-semibold">${m.subjectName}</td>
                                                <td><span class="badge bg-light text-muted border">${m.examType}</span></td>
                                                <td class="text-center fw-bold text-primary">${m.marksObtained}</td>
                                                <td class="text-center">${m.maxMarks}</td>
                                                <td class="text-center">
                                                    <fmt:formatNumber value="${m.percentage}" maxFractionDigits="1" />%
                                                </td>
                                                <td class="text-center">
                                                    <span class="badge ${m.grade == 'A+' || m.grade == 'A' ? 'bg-success' : (m.grade == 'B' || m.grade == 'C' ? 'bg-primary' : 'bg-warning text-dark')}">
                                                        ${m.grade}
                                                    </span>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="7" class="text-center py-3 text-muted">
                                                No marks recorded for this semester yet.
                                            </td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                            <tfoot class="table-light fw-bold">
                                <tr>
                                    <td colspan="3" class="text-end">Aggregate Academic Score:</td>
                                    <td class="text-center text-primary fs-6">${report.totalMarksObtained}</td>
                                    <td class="text-center fs-6">${report.totalMaxMarks}</td>
                                    <td class="text-center fs-6 text-primary">${report.overallPercentage}%</td>
                                    <td class="text-center fs-6"><span class="badge bg-dark">${report.overallGrade}</span></td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>

                    <!-- Performance Evaluation Box -->
                    <div class="row g-3 mb-5">
                        <div class="col-12 col-md-6">
                            <div class="p-3 border rounded h-100 bg-light">
                                <div class="text-muted small">Overall Academic Standing:</div>
                                <div class="fw-bold fs-5 text-dark mt-1">${report.performanceStatus}</div>
                                <div class="small text-muted mt-2">
                                    Minimum 75% attendance and 40% in each course component required for graduation clearance.
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-6">
                            <div class="p-3 border rounded h-100 bg-light">
                                <div class="text-muted small">Grading Scale Reference:</div>
                                <div class="small mt-1 text-secondary">
                                    <strong>A+</strong>: 90%+ | <strong>A</strong>: 80-89% | <strong>B</strong>: 70-79% | <strong>C</strong>: 60-69% | <strong>D</strong>: 50-59% | <strong>F</strong>: &lt;40%
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Printable Signatures Block -->
                    <div class="row mt-5 pt-4 text-center">
                        <div class="col-4">
                            <div class="border-top pt-2 text-muted small fw-semibold">Class Coordinator</div>
                        </div>
                        <div class="col-4">
                            <div class="border-top pt-2 text-muted small fw-semibold">Head of Department</div>
                        </div>
                        <div class="col-4">
                            <div class="border-top pt-2 text-muted small fw-semibold">Controller of Examinations</div>
                        </div>
                    </div>

                </div>
            </c:when>
            <c:otherwise>
                <div class="alert alert-info text-center py-5">
                    <h5>No student selected or found.</h5>
                    <p>Please select a student from the dropdown above to view the report.</p>
                </div>
            </c:otherwise>
        </c:choose>

    </div>
</div>

<%@ include file="../common/footer.jsp" %>
