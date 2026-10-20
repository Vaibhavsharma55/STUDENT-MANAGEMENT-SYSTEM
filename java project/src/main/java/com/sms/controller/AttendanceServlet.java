package com.sms.controller;

import com.sms.model.Attendance;
import com.sms.model.Course;
import com.sms.model.Student;
import com.sms.service.AttendanceService;
import com.sms.service.CourseService;
import com.sms.service.StudentService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Controller for Recording and Viewing Student Attendance.
 */
@WebServlet(name = "AttendanceServlet", urlPatterns = {"/attendance"})
public class AttendanceServlet extends HttpServlet {

    private final AttendanceService attendanceService = new AttendanceService();
    private final StudentService studentService = new StudentService();
    private final CourseService courseService = new CourseService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "record":
                    showRecordSheet(req, resp);
                    break;
                case "delete":
                    deleteAttendance(req, resp);
                    break;
                case "list":
                default:
                    listAttendance(req, resp);
                    break;
            }
        } catch (Exception e) {
            req.setAttribute("errorMessage", "Error: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "saveBatch";
        }

        try {
            if ("saveBatch".equals(action)) {
                saveBatchAttendance(req, resp);
            } else {
                resp.sendRedirect(req.getContextPath() + "/attendance");
            }
        } catch (Exception e) {
            req.setAttribute("errorMessage", "Failed to save attendance: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(req, resp);
        }
    }

    private void listAttendance(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        String dateStr = req.getParameter("date");
        Date date;
        if (dateStr != null && !dateStr.trim().isEmpty()) {
            date = Date.valueOf(dateStr.trim());
        } else {
            date = new Date(System.currentTimeMillis());
        }

        Integer courseId = parseInteger(req.getParameter("courseId"));
        Integer semester = parseInteger(req.getParameter("semester"));

        List<Attendance> attendanceList = attendanceService.getAttendanceByDate(date, courseId, semester);
        List<Course> courses = courseService.getAllCourses();

        req.setAttribute("attendanceList", attendanceList);
        req.setAttribute("courses", courses);
        req.setAttribute("selectedDate", date.toString());
        req.setAttribute("selectedCourseId", courseId);
        req.setAttribute("selectedSemester", semester);

        req.getRequestDispatcher("/WEB-INF/views/attendance/list.jsp").forward(req, resp);
    }

    private void showRecordSheet(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        String dateStr = req.getParameter("date");
        Date date;
        if (dateStr != null && !dateStr.trim().isEmpty()) {
            date = Date.valueOf(dateStr.trim());
        } else {
            date = new Date(System.currentTimeMillis());
        }

        Integer courseId = parseInteger(req.getParameter("courseId"));
        Integer semester = parseInteger(req.getParameter("semester"));

        List<Course> courses = courseService.getAllCourses();
        req.setAttribute("courses", courses);
        req.setAttribute("selectedDate", date.toString());
        req.setAttribute("selectedCourseId", courseId);
        req.setAttribute("selectedSemester", semester);

        // If course or semester is specified, load students
        List<Student> students = studentService.getAllStudents(null, courseId, semester);
        req.setAttribute("students", students);

        // Also fetch any existing records for this date so form is pre-populated
        List<Attendance> existing = attendanceService.getAttendanceByDate(date, courseId, semester);
        Map<Integer, Attendance> existingMap = new HashMap<>();
        for (Attendance a : existing) {
            existingMap.put(a.getStudentId(), a);
        }
        req.setAttribute("existingMap", existingMap);

        req.getRequestDispatcher("/WEB-INF/views/attendance/record.jsp").forward(req, resp);
    }

    private void saveBatchAttendance(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        String dateStr = req.getParameter("attendanceDate");
        Date date = (dateStr != null && !dateStr.trim().isEmpty()) ? Date.valueOf(dateStr.trim()) : new Date(System.currentTimeMillis());

        String[] studentIds = req.getParameterValues("studentId");
        if (studentIds != null) {
            List<Attendance> list = new ArrayList<>();
            for (String sid : studentIds) {
                int sId = Integer.parseInt(sid);
                String status = req.getParameter("status_" + sId);
                String remarks = req.getParameter("remarks_" + sId);

                Attendance att = new Attendance();
                att.setStudentId(sId);
                att.setAttendanceDate(date);
                att.setStatus(status != null ? status : "Present");
                att.setRemarks(remarks != null ? remarks.trim() : "");
                list.add(att);
            }
            attendanceService.recordBatchAttendance(list);
        }

        resp.sendRedirect(req.getContextPath() + "/attendance?date=" + date + "&msg=Attendance saved successfully.");
    }

    private void deleteAttendance(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        int id = Integer.parseInt(req.getParameter("id"));
        attendanceService.deleteAttendance(id);
        String date = req.getParameter("date");
        resp.sendRedirect(req.getContextPath() + "/attendance?date=" + (date != null ? date : "") + "&msg=Attendance deleted successfully.");
    }

    private Integer parseInteger(String val) {
        if (val != null && !val.trim().isEmpty()) {
            try {
                return Integer.parseInt(val.trim());
            } catch (NumberFormatException ignored) {}
        }
        return null;
    }
}
