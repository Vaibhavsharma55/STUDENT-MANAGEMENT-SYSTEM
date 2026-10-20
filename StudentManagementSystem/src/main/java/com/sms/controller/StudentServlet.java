package com.sms.controller;

import com.sms.model.Course;
import com.sms.model.Marks;
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
import java.sql.Date;
import java.util.List;
import java.util.Map;

/**
 * Controller for Student CRUD, search, and profile view.
 */
@WebServlet(name = "StudentServlet", urlPatterns = {"/students"})
public class StudentServlet extends HttpServlet {

    private final StudentService studentService = new StudentService();
    private final CourseService courseService = new CourseService();
    private final AttendanceService attendanceService = new AttendanceService();
    private final MarksService marksService = new MarksService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "new":
                    showNewForm(req, resp);
                    break;
                case "edit":
                    showEditForm(req, resp);
                    break;
                case "delete":
                    deleteStudent(req, resp);
                    break;
                case "view":
                    viewStudentProfile(req, resp);
                    break;
                case "list":
                default:
                    listStudents(req, resp);
                    break;
            }
        } catch (Exception e) {
            req.setAttribute("errorMessage", "Error processing request: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "insert":
                    insertStudent(req, resp);
                    break;
                case "update":
                    updateStudent(req, resp);
                    break;
                default:
                    resp.sendRedirect(req.getContextPath() + "/students");
                    break;
            }
        } catch (Exception e) {
            req.setAttribute("errorMessage", "Operation failed: " + e.getMessage());
            try {
                req.setAttribute("courses", courseService.getAllCourses());
            } catch (Exception ignored) {}
            req.getRequestDispatcher("/WEB-INF/views/student/form.jsp").forward(req, resp);
        }
    }

    private void listStudents(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        String keyword = req.getParameter("keyword");
        if (keyword == null) keyword = req.getParameter("search");

        Integer courseId = null;
        String courseParam = req.getParameter("courseId");
        if (courseParam != null && !courseParam.trim().isEmpty()) {
            try { courseId = Integer.parseInt(courseParam.trim()); } catch (NumberFormatException ignored) {}
        }

        Integer semester = null;
        String semParam = req.getParameter("semester");
        if (semParam != null && !semParam.trim().isEmpty()) {
            try { semester = Integer.parseInt(semParam.trim()); } catch (NumberFormatException ignored) {}
        }

        List<Student> students = studentService.getAllStudents(keyword, courseId, semester);
        List<Course> courses = courseService.getAllCourses();

        req.setAttribute("students", students);
        req.setAttribute("courses", courses);
        req.setAttribute("keyword", keyword);
        req.setAttribute("selectedCourseId", courseId);
        req.setAttribute("selectedSemester", semester);

        req.getRequestDispatcher("/WEB-INF/views/student/list.jsp").forward(req, resp);
    }

    private void showNewForm(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        List<Course> courses = courseService.getAllCourses();
        req.setAttribute("courses", courses);
        req.setAttribute("student", new Student());
        req.setAttribute("formAction", "insert");
        req.getRequestDispatcher("/WEB-INF/views/student/form.jsp").forward(req, resp);
    }

    private void showEditForm(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        int id = Integer.parseInt(req.getParameter("id"));
        Student student = studentService.getStudentById(id);
        if (student == null) {
            resp.sendRedirect(req.getContextPath() + "/students?error=Student not found.");
            return;
        }

        List<Course> courses = courseService.getAllCourses();
        req.setAttribute("courses", courses);
        req.setAttribute("student", student);
        req.setAttribute("formAction", "update");
        req.getRequestDispatcher("/WEB-INF/views/student/form.jsp").forward(req, resp);
    }

    private void insertStudent(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        Student s = extractStudentFromRequest(req);
        try {
            studentService.addStudent(s);
            resp.sendRedirect(req.getContextPath() + "/students?msg=Student added successfully.");
        } catch (IllegalArgumentException e) {
            req.setAttribute("errorMessage", e.getMessage());
            req.setAttribute("student", s);
            req.setAttribute("courses", courseService.getAllCourses());
            req.setAttribute("formAction", "insert");
            req.getRequestDispatcher("/WEB-INF/views/student/form.jsp").forward(req, resp);
        }
    }

    private void updateStudent(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        Student s = extractStudentFromRequest(req);
        s.setId(Integer.parseInt(req.getParameter("id")));

        try {
            studentService.updateStudent(s);
            resp.sendRedirect(req.getContextPath() + "/students?msg=Student updated successfully.");
        } catch (IllegalArgumentException e) {
            req.setAttribute("errorMessage", e.getMessage());
            req.setAttribute("student", s);
            req.setAttribute("courses", courseService.getAllCourses());
            req.setAttribute("formAction", "update");
            req.getRequestDispatcher("/WEB-INF/views/student/form.jsp").forward(req, resp);
        }
    }

    private void deleteStudent(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        int id = Integer.parseInt(req.getParameter("id"));
        studentService.deleteStudent(id);
        resp.sendRedirect(req.getContextPath() + "/students?msg=Student deleted successfully.");
    }

    private void viewStudentProfile(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        int id = Integer.parseInt(req.getParameter("id"));
        Student student = studentService.getStudentById(id);
        if (student == null) {
            resp.sendRedirect(req.getContextPath() + "/students?error=Student not found.");
            return;
        }

        Map<String, Object> attStats = attendanceService.getStudentAttendanceStats(id);
        List<Marks> marksList = marksService.getMarksForStudent(id);
        Map<String, Object> marksAgg = marksService.calculateAggregates(marksList);

        req.setAttribute("student", student);
        req.setAttribute("attStats", attStats);
        req.setAttribute("marksList", marksList);
        req.setAttribute("marksAgg", marksAgg);

        req.getRequestDispatcher("/WEB-INF/views/student/view.jsp").forward(req, resp);
    }

    private Student extractStudentFromRequest(HttpServletRequest req) {
        Student s = new Student();
        s.setRollNo(req.getParameter("rollNo"));
        s.setFirstName(req.getParameter("firstName"));
        s.setLastName(req.getParameter("lastName"));
        s.setEmail(req.getParameter("email"));
        s.setPhone(req.getParameter("phone"));
        s.setGender(req.getParameter("gender"));
        
        String dobStr = req.getParameter("dob");
        if (dobStr != null && !dobStr.trim().isEmpty()) {
            s.setDob(Date.valueOf(dobStr.trim()));
        }

        String courseIdStr = req.getParameter("courseId");
        if (courseIdStr != null && !courseIdStr.trim().isEmpty()) {
            s.setCourseId(Integer.parseInt(courseIdStr.trim()));
        }

        String semStr = req.getParameter("currentSemester");
        if (semStr != null && !semStr.trim().isEmpty()) {
            s.setCurrentSemester(Integer.parseInt(semStr.trim()));
        }

        s.setAddress(req.getParameter("address"));
        return s;
    }
}
