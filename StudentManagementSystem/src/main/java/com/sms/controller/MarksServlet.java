package com.sms.controller;

import com.sms.model.Course;
import com.sms.model.Marks;
import com.sms.model.Student;
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

/**
 * Controller for Managing Student Marks and Percentages.
 */
@WebServlet(name = "MarksServlet", urlPatterns = {"/marks"})
public class MarksServlet extends HttpServlet {

    private final MarksService marksService = new MarksService();
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
                case "new":
                    showNewForm(req, resp);
                    break;
                case "edit":
                    showEditForm(req, resp);
                    break;
                case "delete":
                    deleteMarks(req, resp);
                    break;
                case "list":
                default:
                    listMarks(req, resp);
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
            action = "list";
        }

        try {
            switch (action) {
                case "insert":
                    insertMarks(req, resp);
                    break;
                case "update":
                    updateMarks(req, resp);
                    break;
                default:
                    resp.sendRedirect(req.getContextPath() + "/marks");
                    break;
            }
        } catch (Exception e) {
            req.setAttribute("errorMessage", e.getMessage());
            try {
                req.setAttribute("students", studentService.getAllStudents(null, null, null));
            } catch (Exception ignored) {}
            req.getRequestDispatcher("/WEB-INF/views/marks/form.jsp").forward(req, resp);
        }
    }

    private void listMarks(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        String keyword = req.getParameter("keyword");
        if (keyword == null) keyword = req.getParameter("search");

        Integer courseId = parseInteger(req.getParameter("courseId"));
        Integer semester = parseInteger(req.getParameter("semester"));

        List<Marks> marksList = marksService.getAllMarks(courseId, semester, keyword);
        List<Course> courses = courseService.getAllCourses();

        req.setAttribute("marksList", marksList);
        req.setAttribute("courses", courses);
        req.setAttribute("keyword", keyword);
        req.setAttribute("selectedCourseId", courseId);
        req.setAttribute("selectedSemester", semester);

        req.getRequestDispatcher("/WEB-INF/views/marks/list.jsp").forward(req, resp);
    }

    private void showNewForm(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        List<Student> students = studentService.getAllStudents(null, null, null);
        req.setAttribute("students", students);

        Marks marks = new Marks();
        String preSelectedStudent = req.getParameter("studentId");
        if (preSelectedStudent != null && !preSelectedStudent.trim().isEmpty()) {
            try {
                int sId = Integer.parseInt(preSelectedStudent.trim());
                marks.setStudentId(sId);
                Student s = studentService.getStudentById(sId);
                if (s != null) {
                    marks.setSemester(s.getCurrentSemester());
                }
            } catch (NumberFormatException ignored) {}
        }

        req.setAttribute("marks", marks);
        req.setAttribute("formAction", "insert");
        req.getRequestDispatcher("/WEB-INF/views/marks/form.jsp").forward(req, resp);
    }

    private void showEditForm(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        int id = Integer.parseInt(req.getParameter("id"));
        Marks marks = marksService.getMarksById(id);
        if (marks == null) {
            resp.sendRedirect(req.getContextPath() + "/marks?error=Record not found.");
            return;
        }

        List<Student> students = studentService.getAllStudents(null, null, null);
        req.setAttribute("students", students);
        req.setAttribute("marks", marks);
        req.setAttribute("formAction", "update");
        req.getRequestDispatcher("/WEB-INF/views/marks/form.jsp").forward(req, resp);
    }

    private void insertMarks(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        Marks m = extractMarks(req);
        try {
            marksService.addMarks(m);
            resp.sendRedirect(req.getContextPath() + "/marks?msg=Marks added successfully.");
        } catch (IllegalArgumentException e) {
            req.setAttribute("errorMessage", e.getMessage());
            req.setAttribute("marks", m);
            req.setAttribute("students", studentService.getAllStudents(null, null, null));
            req.setAttribute("formAction", "insert");
            req.getRequestDispatcher("/WEB-INF/views/marks/form.jsp").forward(req, resp);
        }
    }

    private void updateMarks(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        Marks m = extractMarks(req);
        m.setId(Integer.parseInt(req.getParameter("id")));

        try {
            marksService.updateMarks(m);
            resp.sendRedirect(req.getContextPath() + "/marks?msg=Marks updated successfully.");
        } catch (IllegalArgumentException e) {
            req.setAttribute("errorMessage", e.getMessage());
            req.setAttribute("marks", m);
            req.setAttribute("students", studentService.getAllStudents(null, null, null));
            req.setAttribute("formAction", "update");
            req.getRequestDispatcher("/WEB-INF/views/marks/form.jsp").forward(req, resp);
        }
    }

    private void deleteMarks(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        int id = Integer.parseInt(req.getParameter("id"));
        marksService.deleteMarks(id);
        resp.sendRedirect(req.getContextPath() + "/marks?msg=Marks record deleted.");
    }

    private Marks extractMarks(HttpServletRequest req) {
        Marks m = new Marks();
        m.setStudentId(Integer.parseInt(req.getParameter("studentId")));
        m.setSemester(Integer.parseInt(req.getParameter("semester")));
        m.setSubjectName(req.getParameter("subjectName"));
        m.setMarksObtained(Double.parseDouble(req.getParameter("marksObtained")));
        m.setMaxMarks(Double.parseDouble(req.getParameter("maxMarks")));
        m.setExamType(req.getParameter("examType"));
        return m;
    }

    private Integer parseInteger(String val) {
        if (val != null && !val.trim().isEmpty()) {
            try { return Integer.parseInt(val.trim()); } catch (NumberFormatException ignored) {}
        }
        return null;
    }
}
