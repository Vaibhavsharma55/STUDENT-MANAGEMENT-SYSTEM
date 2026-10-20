<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login - Student Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/custom.css" rel="stylesheet">
</head>
<body class="d-flex align-items-center justify-content-center py-5" style="background: linear-gradient(135deg, #e0e7ff 0%, #f1f5f9 100%);">

    <div class="container" style="max-width: 440px;">
        <div class="card card-sms login-card shadow-lg">
            <div class="login-header">
                <i class="fa-solid fa-graduation-cap display-4 mb-2"></i>
                <h3 class="fw-bold mb-1">EduManage SMS</h3>
                <p class="text-white-50 mb-0 small">Student Management System Admin Portal</p>
            </div>

            <div class="card-body p-4 p-md-5">
                <c:if test="${not empty param.msg}">
                    <div class="alert alert-success alert-dismissible fade show small" role="alert">
                        <i class="fa-solid fa-circle-check me-1"></i> ${param.msg}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <c:if test="${not empty param.error}">
                    <div class="alert alert-danger alert-dismissible fade show small" role="alert">
                        <i class="fa-solid fa-circle-exclamation me-1"></i> ${param.error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger alert-dismissible fade show small" role="alert">
                        <i class="fa-solid fa-circle-exclamation me-1"></i> ${errorMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/login" method="post" class="needs-validation">
                    <div class="mb-3">
                        <label for="username" class="form-label fw-semibold small text-muted">Admin Username</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light text-primary"><i class="fa-solid fa-user"></i></span>
                            <input type="text" class="form-control" id="username" name="username" 
                                   value="${username != null ? username : 'admin'}" placeholder="Enter username" required autofocus>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label for="password" class="form-label fw-semibold small text-muted">Password</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light text-primary"><i class="fa-solid fa-lock"></i></span>
                            <input type="password" class="form-control" id="password" name="password" 
                                   placeholder="Enter password" required>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-primary-sms w-100 py-2 fs-6 fw-semibold shadow-sm">
                        <i class="fa-solid fa-right-to-bracket me-2"></i> Sign In to Dashboard
                    </button>
                </form>

                <div class="mt-4 pt-3 border-top text-center">
                    <span class="badge bg-light text-secondary border px-3 py-2 small">
                        <i class="fa-solid fa-key me-1 text-primary"></i> Default: <strong>admin</strong> / <strong>admin123</strong>
                    </span>
                </div>
            </div>
        </div>

        <div class="text-center mt-3 text-muted small">
            &copy; <%= java.time.Year.now() %> EduManage System. Built with Java, JSP, Servlets & MySQL.
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
