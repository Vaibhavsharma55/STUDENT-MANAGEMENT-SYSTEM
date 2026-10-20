<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="${formAction == 'update' ? 'Edit Course' : 'Add New Course'} - SMS" />
<c:set var="activePage" value="courses" />
<%@ include file="../common/header.jsp" %>
<%@ include file="../common/navbar.jsp" %>

<div class="main-content">
    <div class="container px-4" style="max-width: 700px;">

        <!-- Header -->
        <div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
            <div>
                <h3 class="fw-bold text-dark mb-1">
                    <i class="fa-solid ${formAction == 'update' ? 'fa-pen-to-square' : 'fa-folder-plus'} text-primary me-2"></i>
                    ${formAction == 'update' ? 'Edit Academic Program' : 'Add New Course / Program'}
                </h3>
                <p class="text-muted mb-0 small">Define program code, title, and semester curriculum structure.</p>
            </div>
            <a href="${pageContext.request.contextPath}/courses" class="btn btn-outline-secondary">
                <i class="fa-solid fa-arrow-left me-1"></i> Back to Courses
            </a>
        </div>

        <!-- Course Form Card -->
        <div class="card card-sms shadow-sm">
            <div class="card-header">
                <i class="fa-solid fa-graduation-cap text-primary me-2"></i>Course Configuration
            </div>
            <div class="card-body p-4">
                <form action="${pageContext.request.contextPath}/courses" method="post" class="needs-validation">
                    <input type="hidden" name="action" value="${formAction}">
                    <c:if test="${formAction == 'update'}">
                        <input type="hidden" name="id" value="${course.id}">
                    </c:if>

                    <div class="mb-3">
                        <label for="courseCode" class="form-label fw-semibold small">Course Code <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="courseCode" name="courseCode" 
                               value="${course.courseCode}" placeholder="e.g. CSE, IT, ME, BCA" required>
                        <div class="form-text small">Short unique identifier for the department / program.</div>
                    </div>

                    <div class="mb-3">
                        <label for="courseName" class="form-label fw-semibold small">Full Course Name <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="courseName" name="courseName" 
                               value="${course.courseName}" placeholder="e.g. B.Tech Computer Science & Engineering" required>
                    </div>

                    <div class="mb-3">
                        <label for="totalSemesters" class="form-label fw-semibold small">Total Semesters <span class="text-danger">*</span></label>
                        <select class="form-select" id="totalSemesters" name="totalSemesters" required>
                            <c:forEach var="s" begin="1" end="10">
                                <option value="${s}" ${course.totalSemesters == s ? 'selected' : (course.totalSemesters == 0 && s == 8 ? 'selected' : '')}>
                                    ${s} Semesters (${s / 2} Year${s > 2 ? 's' : ''})
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="mb-4">
                        <label for="description" class="form-label fw-semibold small">Description / Curriculum Overview</label>
                        <textarea class="form-control" id="description" name="description" rows="3" 
                                  placeholder="Summary of this program, target careers, or syllabus overview...">${course.description}</textarea>
                    </div>

                    <div class="pt-3 border-top d-flex justify-content-end gap-2">
                        <a href="${pageContext.request.contextPath}/courses" class="btn btn-light border px-4">Cancel</a>
                        <button type="submit" class="btn btn-primary-sms px-4">
                            <i class="fa-solid fa-floppy-disk me-1"></i> ${formAction == 'update' ? 'Update Program' : 'Save Program'}
                        </button>
                    </div>
                </form>
            </div>
        </div>

    </div>
</div>

<%@ include file="../common/footer.jsp" %>
