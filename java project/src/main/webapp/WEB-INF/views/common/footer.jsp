<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<footer class="no-print">
    <div class="container-fluid px-4 text-center">
        <div class="d-flex flex-column flex-sm-row justify-content-between align-items-center">
            <span>&copy; <%= java.time.Year.now() %> <strong>EduManage Student Management System</strong>. Designed for Academic Excellence.</span>
            <span class="mt-2 mt-sm-0 text-muted">Powered by Java Servlets, JSP, JDBC & MySQL</span>
        </div>
    </div>
</footer>

<!-- Bootstrap 5.3 JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Main Custom Script -->
<script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
