package com.sms.service;

import com.sms.dao.CourseDAO;
import com.sms.model.Course;

import java.sql.SQLException;
import java.util.List;

/**
 * Service for course and semester management.
 */
public class CourseService {

    private final CourseDAO courseDAO;

    public CourseService() {
        this.courseDAO = new CourseDAO();
    }

    public CourseService(CourseDAO courseDAO) {
        this.courseDAO = courseDAO;
    }

    public List<Course> getAllCourses() throws SQLException {
        return courseDAO.findAll();
    }

    public Course getCourseById(int id) throws SQLException {
        return courseDAO.findById(id);
    }

    public void addCourse(Course course) throws SQLException {
        validateCourse(course);

        Course existing = courseDAO.findByCode(course.getCourseCode());
        if (existing != null) {
            throw new IllegalArgumentException("A course with code '" + course.getCourseCode() + "' already exists.");
        }

        courseDAO.insert(course);
    }

    public void updateCourse(Course course) throws SQLException {
        validateCourse(course);

        Course existing = courseDAO.findByCode(course.getCourseCode());
        if (existing != null && existing.getId() != course.getId()) {
            throw new IllegalArgumentException("Another course is already using code '" + course.getCourseCode() + "'.");
        }

        courseDAO.update(course);
    }

    public void deleteCourse(int id) throws SQLException {
        if (courseDAO.hasStudents(id)) {
            throw new IllegalStateException("Cannot delete course because students are currently enrolled in it.");
        }
        courseDAO.delete(id);
    }

    public int getTotalCourses() throws SQLException {
        return courseDAO.count();
    }

    private void validateCourse(Course course) {
        if (course.getCourseCode() == null || course.getCourseCode().trim().isEmpty()) {
            throw new IllegalArgumentException("Course code is required.");
        }
        if (course.getCourseName() == null || course.getCourseName().trim().isEmpty()) {
            throw new IllegalArgumentException("Course name is required.");
        }
        if (course.getTotalSemesters() <= 0 || course.getTotalSemesters() > 12) {
            throw new IllegalArgumentException("Total semesters must be between 1 and 12.");
        }
        course.setCourseCode(course.getCourseCode().trim().toUpperCase());
        course.setCourseName(course.getCourseName().trim());
    }
}
