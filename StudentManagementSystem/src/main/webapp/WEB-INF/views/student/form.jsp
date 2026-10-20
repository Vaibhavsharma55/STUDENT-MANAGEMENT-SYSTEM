<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:set var="pageTitle" value="${formAction == 'update' ? 'Edit Student' : 'Add New Student'} - SMS" />
<c:set var="activePage" value="students" />
<%@ include file="../common/header.jsp" %>
<%@ include file="../common/navbar.jsp" %>

<div class="main-content">
    <div class="container px-4" style="max-width: 860px;">

        <!-- Breadcrumb / Header -->
        <div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
            <div>
                <h3 class="fw-bold text-dark mb-1">
                    <i class="fa-solid ${formAction == 'update' ? 'fa-user-pen' : 'fa-user-plus'} text-primary me-2"></i>
                    ${formAction == 'update' ? 'Edit Student Details' : 'Register New Student'}
                </h3>
                <p class="text-muted mb-0 small">
                    ${formAction == 'update' ? 'Update personal, contact and academic details.' : 'Fill in the details to enroll a new student in the system.'}
                </p>
            </div>
            <a href="${pageContext.request.contextPath}/students" class="btn btn-outline-secondary">
                <i class="fa-solid fa-arrow-left me-1"></i> Back to List
            </a>
        </div>

        <!-- Student Form Card -->
        <div class="card card-sms shadow-sm">
            <div class="card-header">
                <i class="fa-solid fa-id-card text-primary me-2"></i>Student Registration Form
            </div>
            <div class="card-body p-4">
                <form action="${pageContext.request.contextPath}/students" method="post" class="needs-validation">
                    <input type="hidden" name="action" value="${formAction}">
                    <c:if test="${formAction == 'update'}">
                        <input type="hidden" name="id" value="${student.id}">
                    </c:if>

                    <div class="row g-3">
                        <!-- Roll Number -->
                        <div class="col-12 col-md-6">
                            <label for="rollNo" class="form-label fw-semibold small">Roll Number <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="rollNo" name="rollNo" 
                                   value="${student.rollNo}" placeholder="e.g. CS202401" required>
                            <div class="form-text small">Unique institutional roll number or registration ID.</div>
                        </div>

                        <!-- Course / Academic Program -->
                        <div class="col-12 col-md-6">
                            <label for="courseId" class="form-label fw-semibold small">Academic Program / Course <span class="text-danger">*</span></label>
                            <select class="form-select" id="courseId" name="courseId" required>
                                <option value="">-- Select Course --</option>
                                <c:forEach var="c" items="${courses}">
                                    <option value="${c.id}" ${c.id == student.courseId ? 'selected' : ''}>
                                        ${c.courseCode} - ${c.courseName}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <!-- First Name -->
                        <div class="col-12 col-md-6">
                            <label for="firstName" class="form-label fw-semibold small">First Name <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="firstName" name="firstName" 
                                   value="${student.firstName}" placeholder="First name" required>
                        </div>

                        <!-- Last Name -->
                        <div class="col-12 col-md-6">
                            <label for="lastName" class="form-label fw-semibold small">Last Name <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="lastName" name="lastName" 
                                   value="${student.lastName}" placeholder="Last name" required>
                        </div>

                        <!-- Email -->
                        <div class="col-12 col-md-6">
                            <label for="email" class="form-label fw-semibold small">Email Address <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <span class="input-group-text bg-light text-muted"><i class="fa-regular fa-envelope"></i></span>
                                <input type="email" class="form-control" id="email" name="email" 
                                       value="${student.email}" placeholder="student@example.com" required>
                            </div>
                        </div>

                        <!-- Phone -->
                        <div class="col-12 col-md-6">
                            <label for="phone" class="form-label fw-semibold small">Phone Number <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <span class="input-group-text bg-light text-muted"><i class="fa-solid fa-phone"></i></span>
                                <input type="tel" class="form-control" id="phone" name="phone" 
                                       value="${student.phone}" placeholder="e.g. 9876543210" required>
                            </div>
                        </div>

                        <!-- Gender -->
                        <div class="col-12 col-md-4">
                            <label for="gender" class="form-label fw-semibold small">Gender <span class="text-danger">*</span></label>
                            <select class="form-select" id="gender" name="gender" required>
                                <option value="Male" ${student.gender == 'Male' ? 'selected' : ''}>Male</option>
                                <option value="Female" ${student.gender == 'Female' ? 'selected' : ''}>Female</option>
                                <option value="Other" ${student.gender == 'Other' ? 'selected' : ''}>Other</option>
                            </select>
                        </div>

                        <!-- Date of Birth -->
                        <div class="col-12 col-md-4">
                            <label for="dob" class="form-label fw-semibold small">Date of Birth <span class="text-danger">*</span></label>
                            <input type="date" class="form-control" id="dob" name="dob" 
                                   value="${student.dob}" required>
                        </div>

                        <!-- Current Semester -->
                        <div class="col-12 col-md-4">
                            <label for="currentSemester" class="form-label fw-semibold small">Current Semester <span class="text-danger">*</span></label>
                            <select class="form-select" id="currentSemester" name="currentSemester" required>
                                <c:forEach var="sem" begin="1" end="8">
                                    <option value="${sem}" ${student.currentSemester == sem ? 'selected' : ''}>Semester ${sem}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <!-- Address -->
                        <div class="col-12">
                            <label for="address" class="form-label fw-semibold small">Residential Address</label>
                            <textarea class="form-control" id="address" name="address" rows="3" 
                                      placeholder="Full street address, city, state, postal code">${student.address}</textarea>
                        </div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="mt-4 pt-3 border-top d-flex justify-content-end gap-2">
                        <a href="${pageContext.request.contextPath}/students" class="btn btn-light border px-4">Cancel</a>
                        <button type="submit" class="btn btn-primary-sms px-4">
                            <i class="fa-solid fa-floppy-disk me-1"></i> ${formAction == 'update' ? 'Update Student' : 'Save Student'}
                        </button>
                    </div>
                </form>
            </div>
        </div>

    </div>
</div>

<%@ include file="../common/footer.jsp" %>
