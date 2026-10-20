package com.sms.controller;

import com.sms.model.Student;
import com.sms.service.AttendanceService;
import com.sms.service.CourseService;
import com.sms.service.MarksService;
import com.sms.service.StudentService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * Controller for the main Admin Dashboard.
 */
@WebServlet(name = "DashboardServlet", urlPatterns = {"/dashboard"})
public class DashboardServlet extends HttpServlet {

    private final StudentService studentService = new StudentService();
    private final CourseService courseService = new CourseService();
    private final AttendanceService attendanceService = new AttendanceService();
    private final MarksService marksService = new MarksService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int totalStudents = studentService.getTotalStudents();
            int totalCourses = courseService.getTotalCourses();
            int totalMarksRecords = marksService.getTotalMarksRecords();
            double avgPercentage = marksService.getAveragePercentage();

            Map<String, Integer> attSummary = attendanceService.getTodayAttendanceSummary();
            int presentToday = attSummary.getOrDefault("presentToday", 0);

            double todayAttendancePct = 0.0;
            if (totalStudents > 0) {
                todayAttendancePct = Math.round(((double) presentToday / totalStudents) * 1000.0) / 10.0;
            }

            List<Student> recentStudents = studentService.getRecentStudents(5);

            req.setAttribute("totalStudents", totalStudents);
            req.setAttribute("totalCourses", totalCourses);
            req.setAttribute("totalMarksRecords", totalMarksRecords);
            req.setAttribute("avgPercentage", avgPercentage);
            req.setAttribute("presentToday", presentToday);
            req.setAttribute("todayAttendancePct", todayAttendancePct);
            req.setAttribute("recentStudents", recentStudents);

            req.getRequestDispatcher("/WEB-INF/views/dashboard.jsp").forward(req, resp);
        } catch (Exception e) {
            req.setAttribute("errorMessage", "Failed to load dashboard data: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(req, resp);
        }
    }
}
