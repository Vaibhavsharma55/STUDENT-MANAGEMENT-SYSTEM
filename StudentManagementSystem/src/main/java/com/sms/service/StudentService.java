package com.sms.service;

import com.sms.dao.StudentDAO;
import com.sms.model.Student;

import java.sql.SQLException;
import java.util.List;

/**
 * Service handling Student business operations.
 */
public class StudentService {

    private final StudentDAO studentDAO;

    public StudentService() {
        this.studentDAO = new StudentDAO();
    }

    public StudentService(StudentDAO studentDAO) {
        this.studentDAO = studentDAO;
    }

    public List<Student> getAllStudents(String search, Integer courseId, Integer semester) throws SQLException {
        return studentDAO.findAll(search, courseId, semester);
    }

    public List<Student> getRecentStudents(int limit) throws SQLException {
        return studentDAO.findRecent(limit);
    }

    public Student getStudentById(int id) throws SQLException {
        return studentDAO.findById(id);
    }

    public Student getStudentByRollNo(String rollNo) throws SQLException {
        if (rollNo == null || rollNo.trim().isEmpty()) return null;
        return studentDAO.findByRollNo(rollNo.trim());
    }

    public void addStudent(Student student) throws SQLException {
        validateStudent(student);

        Student existingRoll = studentDAO.findByRollNo(student.getRollNo());
        if (existingRoll != null) {
            throw new IllegalArgumentException("A student with Roll Number '" + student.getRollNo() + "' already exists.");
        }

        Student existingEmail = studentDAO.findByEmail(student.getEmail());
        if (existingEmail != null) {
            throw new IllegalArgumentException("A student with Email '" + student.getEmail() + "' already exists.");
        }

        studentDAO.insert(student);
    }

    public void updateStudent(Student student) throws SQLException {
        validateStudent(student);

        Student existingRoll = studentDAO.findByRollNo(student.getRollNo());
        if (existingRoll != null && existingRoll.getId() != student.getId()) {
            throw new IllegalArgumentException("Another student already has Roll Number '" + student.getRollNo() + "'.");
        }

        Student existingEmail = studentDAO.findByEmail(student.getEmail());
        if (existingEmail != null && existingEmail.getId() != student.getId()) {
            throw new IllegalArgumentException("Another student already has Email '" + student.getEmail() + "'.");
        }

        studentDAO.update(student);
    }

    public void deleteStudent(int id) throws SQLException {
        studentDAO.delete(id);
    }

    public int getTotalStudents() throws SQLException {
        return studentDAO.count();
    }

    private void validateStudent(Student s) {
        if (s.getRollNo() == null || s.getRollNo().trim().isEmpty()) {
            throw new IllegalArgumentException("Roll number is required.");
        }
        if (s.getFirstName() == null || s.getFirstName().trim().isEmpty()) {
            throw new IllegalArgumentException("First name is required.");
        }
        if (s.getLastName() == null || s.getLastName().trim().isEmpty()) {
            throw new IllegalArgumentException("Last name is required.");
        }
        if (s.getEmail() == null || !s.getEmail().matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            throw new IllegalArgumentException("Valid email address is required.");
        }
        if (s.getPhone() == null || s.getPhone().trim().isEmpty()) {
            throw new IllegalArgumentException("Phone number is required.");
        }
        if (s.getCourseId() <= 0) {
            throw new IllegalArgumentException("Please select a valid course.");
        }
        if (s.getCurrentSemester() <= 0) {
            throw new IllegalArgumentException("Semester must be greater than zero.");
        }
        if (s.getDob() == null) {
            throw new IllegalArgumentException("Date of birth is required.");
        }

        s.setRollNo(s.getRollNo().trim().toUpperCase());
        s.setFirstName(s.getFirstName().trim());
        s.setLastName(s.getLastName().trim());
        s.setEmail(s.getEmail().trim().toLowerCase());
        s.setPhone(s.getPhone().trim());
    }
}
