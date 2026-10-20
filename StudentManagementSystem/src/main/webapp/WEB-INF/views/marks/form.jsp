<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="${formAction == 'update' ? 'Edit Subject Marks' : 'Enter Marks'} - SMS" />
<c:set var="activePage" value="marks" />
<%@ include file="../common/header.jsp" %>
<%@ include file="../common/navbar.jsp" %>

<div class="main-content">
    <div class="container px-4" style="max-width: 720px;">

        <!-- Header -->
        <div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
            <div>
                <h3 class="fw-bold text-dark mb-1">
                    <i class="fa-solid ${formAction == 'update' ? 'fa-pen-to-square' : 'fa-plus-circle'} text-primary me-2"></i>
                    ${formAction == 'update' ? 'Edit Student Marks' : 'Enter Academic Marks'}
                </h3>
                <p class="text-muted mb-0 small">Record subject score, evaluate percentage, and assign academic grades.</p>
            </div>
            <a href="${pageContext.request.contextPath}/marks" class="btn btn-outline-secondary">
                <i class="fa-solid fa-arrow-left me-1"></i> Back to Marks
            </a>
        </div>

        <!-- Marks Form Card -->
        <div class="card card-sms shadow-sm">
            <div class="card-header">
                <i class="fa-solid fa-file-pen text-primary me-2"></i>Examination Score Entry Form
            </div>
            <div class="card-body p-4">
                <form action="${pageContext.request.contextPath}/marks" method="post" class="needs-validation">
                    <input type="hidden" name="action" value="${formAction}">
                    <c:if test="${formAction == 'update'}">
                        <input type="hidden" name="id" value="${marks.id}">
                    </c:if>

                    <!-- Student Selector -->
                    <div class="mb-3">
                        <label for="studentId" class="form-label fw-semibold small">Student <span class="text-danger">*</span></label>
                        <select class="form-select" id="studentId" name="studentId" required ${formAction == 'update' ? 'disabled' : ''}>
                            <option value="">-- Choose Student --</option>
                            <c:forEach var="s" items="${students}">
                                <option value="${s.id}" ${s.id == marks.studentId ? 'selected' : ''}>
                                    ${s.rollNo} - ${s.fullName} (${s.courseCode}, Sem ${s.currentSemester})
                                </option>
                            </c:forEach>
                        </select>
                        <c:if test="${formAction == 'update'}">
                            <input type="hidden" name="studentId" value="${marks.studentId}">
                        </c:if>
                    </div>

                    <div class="row g-3">
                        <!-- Semester -->
                        <div class="col-12 col-md-6">
                            <label for="semester" class="form-label fw-semibold small">Semester <span class="text-danger">*</span></label>
                            <select class="form-select" id="semester" name="semester" required>
                                <c:forEach var="sem" begin="1" end="8">
                                    <option value="${sem}" ${marks.semester == sem ? 'selected' : ''}>Semester ${sem}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <!-- Exam Type -->
                        <div class="col-12 col-md-6">
                            <label for="examType" class="form-label fw-semibold small">Exam Type <span class="text-danger">*</span></label>
                            <select class="form-select" id="examType" name="examType" required>
                                <option value="Semester Exam" ${marks.examType == 'Semester Exam' ? 'selected' : ''}>Semester Exam</option>
                                <option value="Mid-Term Exam" ${marks.examType == 'Mid-Term Exam' ? 'selected' : ''}>Mid-Term Exam</option>
                                <option value="Practical & Theory" ${marks.examType == 'Practical & Theory' ? 'selected' : ''}>Practical & Theory</option>
                                <option value="Quiz / Assignment" ${marks.examType == 'Quiz / Assignment' ? 'selected' : ''}>Quiz / Assignment</option>
                            </select>
                        </div>

                        <!-- Subject Name -->
                        <div class="col-12">
                            <label for="subjectName" class="form-label fw-semibold small">Subject Name <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="subjectName" name="subjectName" 
                                   value="${marks.subjectName}" placeholder="e.g. Data Structures, Database Systems" required>
                        </div>

                        <!-- Marks Obtained -->
                        <div class="col-12 col-md-6">
                            <label for="marksObtained" class="form-label fw-semibold small">Marks Obtained <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <span class="input-group-text bg-light text-primary"><i class="fa-solid fa-check"></i></span>
                                <input type="number" step="0.5" min="0" max="1000" class="form-control" 
                                       id="marksObtained" name="marksObtained" value="${marks.marksObtained}" placeholder="e.g. 85" required>
                            </div>
                        </div>

                        <!-- Max Marks -->
                        <div class="col-12 col-md-6">
                            <label for="maxMarks" class="form-label fw-semibold small">Maximum Total Marks <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <span class="input-group-text bg-light text-muted"><i class="fa-solid fa-flag"></i></span>
                                <input type="number" step="0.5" min="1" max="1000" class="form-control" 
                                       id="maxMarks" name="maxMarks" value="${marks.maxMarks > 0 ? marks.maxMarks : 100}" placeholder="e.g. 100" required>
                            </div>
                        </div>

                        <!-- Live Percentage Badge Indicator -->
                        <div class="col-12">
                            <div class="p-3 bg-light rounded border d-flex justify-content-between align-items-center">
                                <span class="small fw-semibold text-muted">Computed Score Preview:</span>
                                <div>
                                    <span id="livePercentage" class="badge bg-primary fs-6">0%</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="mt-4 pt-3 border-top d-flex justify-content-end gap-2">
                        <a href="${pageContext.request.contextPath}/marks" class="btn btn-light border px-4">Cancel</a>
                        <button type="submit" class="btn btn-primary-sms px-4">
                            <i class="fa-solid fa-floppy-disk me-1"></i> ${formAction == 'update' ? 'Update Marks' : 'Save Marks'}
                        </button>
                    </div>
                </form>
            </div>
        </div>

    </div>
</div>

<%@ include file="../common/footer.jsp" %>
