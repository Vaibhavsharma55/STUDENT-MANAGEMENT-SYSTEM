package com.sms.controller;

import com.sms.model.Course;
import com.sms.service.CourseService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

/**
 * Controller for Courses and Semesters management.
 */
@WebServlet(name = "CourseServlet", urlPatterns = {"/courses"})
public class CourseServlet extends HttpServlet {

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
                    deleteCourse(req, resp);
                    break;
                case "list":
                default:
                    listCourses(req, resp);
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
                    insertCourse(req, resp);
                    break;
                case "update":
                    updateCourse(req, resp);
                    break;
                default:
                    resp.sendRedirect(req.getContextPath() + "/courses");
                    break;
            }
        } catch (Exception e) {
            req.setAttribute("errorMessage", e.getMessage());
            req.getRequestDispatcher("/WEB-INF/views/course/form.jsp").forward(req, resp);
        }
    }

    private void listCourses(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        List<Course> courses = courseService.getAllCourses();
        req.setAttribute("courses", courses);
        req.getRequestDispatcher("/WEB-INF/views/course/list.jsp").forward(req, resp);
    }

    private void showNewForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("course", new Course());
        req.setAttribute("formAction", "insert");
        req.getRequestDispatcher("/WEB-INF/views/course/form.jsp").forward(req, resp);
    }

    private void showEditForm(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        int id = Integer.parseInt(req.getParameter("id"));
        Course course = courseService.getCourseById(id);
        if (course == null) {
            resp.sendRedirect(req.getContextPath() + "/courses?error=Course not found.");
            return;
        }
        req.setAttribute("course", course);
        req.setAttribute("formAction", "update");
        req.getRequestDispatcher("/WEB-INF/views/course/form.jsp").forward(req, resp);
    }

    private void insertCourse(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        Course c = extractCourse(req);
        try {
            courseService.addCourse(c);
            resp.sendRedirect(req.getContextPath() + "/courses?msg=Course added successfully.");
        } catch (IllegalArgumentException e) {
            req.setAttribute("errorMessage", e.getMessage());
            req.setAttribute("course", c);
            req.setAttribute("formAction", "insert");
            req.getRequestDispatcher("/WEB-INF/views/course/form.jsp").forward(req, resp);
        }
    }

    private void updateCourse(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        Course c = extractCourse(req);
        c.setId(Integer.parseInt(req.getParameter("id")));

        try {
            courseService.updateCourse(c);
            resp.sendRedirect(req.getContextPath() + "/courses?msg=Course updated successfully.");
        } catch (IllegalArgumentException e) {
            req.setAttribute("errorMessage", e.getMessage());
            req.setAttribute("course", c);
            req.setAttribute("formAction", "update");
            req.getRequestDispatcher("/WEB-INF/views/course/form.jsp").forward(req, resp);
        }
    }

    private void deleteCourse(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        int id = Integer.parseInt(req.getParameter("id"));
        try {
            courseService.deleteCourse(id);
            resp.sendRedirect(req.getContextPath() + "/courses?msg=Course deleted successfully.");
        } catch (IllegalStateException e) {
            resp.sendRedirect(req.getContextPath() + "/courses?error=" + java.net.URLEncoder.encode(e.getMessage(), "UTF-8"));
        }
    }

    private Course extractCourse(HttpServletRequest req) {
        Course c = new Course();
        c.setCourseCode(req.getParameter("courseCode"));
        c.setCourseName(req.getParameter("courseName"));
        
        String sems = req.getParameter("totalSemesters");
        if (sems != null && !sems.trim().isEmpty()) {
            c.setTotalSemesters(Integer.parseInt(sems.trim()));
        } else {
            c.setTotalSemesters(8);
        }

        c.setDescription(req.getParameter("description"));
        return c;
    }
}
