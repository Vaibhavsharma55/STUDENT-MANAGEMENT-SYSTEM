<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="Record Attendance - Student Management System" />
<c:set var="activePage" value="attendance" />
<%@ include file="../common/header.jsp" %>
<%@ include file="../common/navbar.jsp" %>

<div class="main-content">
    <div class="container-fluid px-4">

        <!-- Header -->
        <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center mb-4 pb-2 border-bottom">
            <div>
                <h3 class="fw-bold text-dark mb-1">
                    <i class="fa-solid fa-clipboard-user text-primary me-2"></i>Mark Class Attendance
                </h3>
                <p class="text-muted mb-0 small">Select course and date, then mark presence for enrolled students.</p>
            </div>
            <div class="mt-3 mt-md-0">
                <a href="${pageContext.request.contextPath}/attendance" class="btn btn-outline-secondary">
                    <i class="fa-solid fa-arrow-left me-1"></i> Back to Attendance Log
                </a>
            </div>
        </div>

        <!-- Class Selection Form -->
        <div class="card card-sms mb-4">
            <div class="card-body p-3">
                <form action="${pageContext.request.contextPath}/attendance" method="get" class="row g-2 align-items-end">
                    <input type="hidden" name="action" value="record">

                    <div class="col-12 col-md-3">
                        <label class="form-label small fw-semibold text-muted mb-1">Attendance Date <span class="text-danger">*</span></label>
                        <input type="date" name="date" class="form-control" value="${selectedDate}" required>
                    </div>

                    <div class="col-6 col-md-4">
                        <label class="form-label small fw-semibold text-muted mb-1">Select Program</label>
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

                    <div class="col-12 col-md-3 d-flex gap-2">
                        <button type="submit" class="btn btn-primary-sms flex-grow-1">
                            <i class="fa-solid fa-users-viewfinder me-1"></i> Load Students
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Batch Attendance Sheet -->
        <div class="card card-sms">
            <div class="card-header d-flex flex-column flex-sm-row justify-content-between align-items-sm-center gap-2">
                <span>
                    <i class="fa-solid fa-list-check text-primary me-2"></i>
                    Student Attendance Sheet for <strong>${selectedDate}</strong> (${students.size()} students)
                </span>
                <c:if test="${not empty students}">
                    <div class="d-flex gap-2">
                        <button type="button" class="btn btn-sm btn-outline-success" onclick="markAll('Present')">
                            <i class="fa-solid fa-check-double me-1"></i> All Present
                        </button>
                        <button type="button" class="btn btn-sm btn-outline-danger" onclick="markAll('Absent')">
                            <i class="fa-solid fa-xmark me-1"></i> All Absent
                        </button>
                    </div>
                </c:if>
            </div>

            <div class="card-body p-0">
                <c:choose>
                    <c:when test="${not empty students}">
                        <form action="${pageContext.request.contextPath}/attendance" method="post">
                            <input type="hidden" name="action" value="saveBatch">
                            <input type="hidden" name="attendanceDate" value="${selectedDate}">

                            <div class="table-responsive">
                                <table class="table table-custom table-hover align-middle mb-0">
                                    <thead>
                                        <tr>
                                            <th style="width: 140px;">Roll No</th>
                                            <th>Student Name</th>
                                            <th style="width: 100px;">Program</th>
                                            <th style="width: 320px;">Status</th>
                                            <th>Remarks (Optional)</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="s" items="${students}">
                                            <c:set var="prevAtt" value="${existingMap[s.id]}" />
                                            <c:set var="curStatus" value="${prevAtt != null ? prevAtt.status : 'Present'}" />
                                            <c:set var="curRemarks" value="${prevAtt != null ? prevAtt.remarks : ''}" />

                                            <tr>
                                                <td class="fw-bold text-primary">
                                                    <input type="hidden" name="studentId" value="${s.id}">
                                                    ${s.rollNo}
                                                </td>
                                                <td>
                                                    <div class="fw-semibold">${s.fullName}</div>
                                                    <div class="text-muted small">Sem ${s.currentSemester}</div>
                                                </td>
                                                <td><span class="badge bg-light text-dark border">${s.courseCode}</span></td>
                                                <td>
                                                    <div class="btn-group btn-group-sm w-100" role="group">
                                                        <input type="radio" class="btn-check status-radio" name="status_${s.id}" 
                                                               id="p_${s.id}" value="Present" ${curStatus == 'Present' ? 'checked' : ''}>
                                                        <label class="btn btn-outline-success" for="p_${s.id}">Present</label>

                                                        <input type="radio" class="btn-check status-radio" name="status_${s.id}" 
                                                               id="a_${s.id}" value="Absent" ${curStatus == 'Absent' ? 'checked' : ''}>
                                                        <label class="btn btn-outline-danger" for="a_${s.id}">Absent</label>

                                                        <input type="radio" class="btn-check status-radio" name="status_${s.id}" 
                                                               id="l_${s.id}" value="Late" ${curStatus == 'Late' ? 'checked' : ''}>
                                                        <label class="btn btn-outline-warning" for="l_${s.id}">Late</label>

                                                        <input type="radio" class="btn-check status-radio" name="status_${s.id}" 
                                                               id="e_${s.id}" value="Excused" ${curStatus == 'Excused' ? 'checked' : ''}>
                                                        <label class="btn btn-outline-info" for="e_${s.id}">Excused</label>
                                                    </div>
                                                </td>
                                                <td>
                                                    <input type="text" name="remarks_${s.id}" class="form-control form-control-sm" 
                                                           value="${curRemarks}" placeholder="Notes, e.g. Medical leave, late 10m">
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>

                            <div class="p-3 bg-light border-top d-flex justify-content-end gap-2">
                                <a href="${pageContext.request.contextPath}/attendance" class="btn btn-light border px-4">Cancel</a>
                                <button type="submit" class="btn btn-primary-sms px-4">
                                    <i class="fa-solid fa-floppy-disk me-1"></i> Save Attendance
                                </button>
                            </div>
                        </form>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center py-5 text-muted">
                            <i class="fa-solid fa-users-slash display-6 mb-3 text-secondary d-block"></i>
                            <p class="mb-2">No students found matching your selected filters.</p>
                            <span class="small">Try selecting "All Programs" and click "Load Students".</span>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

    </div>
</div>

<script>
function markAll(status) {
    document.querySelectorAll('.status-radio').forEach(function(radio) {
        if (radio.value === status) {
            radio.checked = true;
        }
    });
}
</script>

<%@ include file="../common/footer.jsp" %>
