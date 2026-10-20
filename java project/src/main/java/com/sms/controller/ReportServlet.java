package com.sms.controller;

import com.sms.model.Course;
import com.sms.model.Student;
import com.sms.model.StudentReport;
import com.sms.service.CourseService;
import com.sms.service.ReportService;
import com.sms.service.StudentService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Controller for Generating Simple Student Reports and Academic Summaries.
 */
@WebServlet(name = "ReportServlet", urlPatterns = {"/reports"})
public class ReportServlet extends HttpServlet {

    private final ReportService reportService = new ReportService();
    private final StudentService studentService = new StudentService();
    private final CourseService courseService = new CourseService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "student";
        }

        try {
            switch (action) {
                case "class":
                    generateClassReport(req, resp);
                    break;
                case "student":
                default:
                    generateStudentReport(req, resp);
                    break;
            }
        } catch (Exception e) {
            req.setAttribute("errorMessage", "Error generating report: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(req, resp);
        }
    }

    private void generateStudentReport(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        List<Student> students = studentService.getAllStudents(null, null, null);
        req.setAttribute("students", students);

        int studentId = 0;
        String idParam = req.getParameter("studentId");
        if (idParam != null && !idParam.trim().isEmpty()) {
            studentId = Integer.parseInt(idParam.trim());
        } else if (!students.isEmpty()) {
            studentId = students.get(0).getId();
        }

        Integer semester = null;
        String semParam = req.getParameter("semester");
        if (semParam != null && !semParam.trim().isEmpty()) {
            semester = Integer.parseInt(semParam.trim());
        }

        if (studentId > 0) {
            StudentReport report = reportService.generateStudentReport(studentId, semester);
            req.setAttribute("report", report);
            req.setAttribute("selectedStudentId", studentId);
            req.setAttribute("selectedSemester", semester);
        }

        req.getRequestDispatcher("/WEB-INF/views/report/student-report.jsp").forward(req, resp);
    }

    private void generateClassReport(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        Integer courseId = parseInteger(req.getParameter("courseId"));
        Integer semester = parseInteger(req.getParameter("semester"));

        List<Course> courses = courseService.getAllCourses();
        List<Student> students = studentService.getAllStudents(null, courseId, semester);

        List<StudentReport> reports = new ArrayList<>();
        for (Student s : students) {
            StudentReport r = reportService.generateStudentReport(s.getId(), semester);
            if (r != null) {
                reports.add(r);
            }
        }

        req.setAttribute("courses", courses);
        req.setAttribute("reports", reports);
        req.setAttribute("selectedCourseId", courseId);
        req.setAttribute("selectedSemester", semester);

        req.getRequestDispatcher("/WEB-INF/views/report/class-report.jsp").forward(req, resp);
    }

    private Integer parseInteger(String val) {
        if (val != null && !val.trim().isEmpty()) {
            try { return Integer.parseInt(val.trim()); } catch (NumberFormatException ignored) {}
        }
        return null;
    }
}
