
--SECTION:  REFERENCE DATA INSERTION


INSERT INTO GoalCategoryLookup (CategoryName, Description) VALUES
('Academic', 'Goals related to study, GPA, and grades'),
('Skill Development', 'Professional and technical skill development'),
('Career', 'Career goals, internships, and employment'),
('Personal', 'Personal goals, health, and self-improvement'),
('Project', 'Project completion and assignment goals'),
('Certificate', 'Professional certification goals');

INSERT INTO GoalStatusLookup (StatusName, Description) VALUES
('Active', 'Goal is currently in progress'),
('Completed', 'Goal has been successfully completed'),
('Failed', 'Goal has failed'),
('Cancelled', 'Goal has been cancelled');

INSERT INTO SemesterLookup (SemesterCode, StartDate, EndDate) VALUES
('Fall2024', '2024-09-01', '2024-12-31'),
('Spring2025', '2025-01-01', '2025-05-31'),
('Summer2025', '2025-06-01', '2025-08-31'),
('Fall2025', '2025-09-01', '2025-12-31');
GO


-- SECTION: SAMPLE DATA INSERTION


-- Instructor Sample Data (5 instructors)
INSERT INTO Instructor (InstructorID, FirstName, LastName, Email, Department, Phone, HireDate) VALUES
('INS00001', 'John', 'Smith', 'john.smith@fptu.edu.vn', 'Software Engineering', '0912345678', '2020-01-15'),
('INS00002', 'Mary', 'Johnson', 'mary.johnson@fptu.edu.vn', 'Information Systems', '0923456789', '2019-08-20'),
('INS00003', 'David', 'Williams', 'david.williams@fptu.edu.vn', 'Artificial Intelligence', '0934567890', '2021-03-10'),
('INS00004', 'Sarah', 'Brown', 'sarah.brown@fptu.edu.vn', 'Software Engineering', '0945678901', '2022-06-01'),
('INS00005', 'Robert', 'Davis', 'robert.davis@fptu.edu.vn', 'Data Science', '0956789012', '2021-11-15');

-- Student Sample Data (8 students)
INSERT INTO Student (StudentID, FirstName, LastName, Email, Major, GPA, Phone, EnrollmentDate) VALUES
('SE160001', 'Nguyen', 'Van A', 'anvse160001@fpt.edu.vn', 'Software Engineering', 3.50, '0901234567', '2023-09-01'),
('SE160002', 'Tran', 'Thi B', 'bttse160002@fpt.edu.vn', 'Software Engineering', 3.75, '0901234568', '2023-09-01'),
('SE160003', 'Le', 'Van C', 'cvlse160003@fpt.edu.vn', 'Software Engineering', 3.20, '0901234569', '2023-09-01'),
('HE160001', 'Pham', 'Thi D', 'dtphe160001@fpt.edu.vn', 'Information Systems', 3.60, '0901234570', '2023-09-01'),
('HE160002', 'Hoang', 'Minh E', 'emhe160002@fpt.edu.vn', 'Information Systems', 3.40, '0901234571', '2023-09-01'),
('SS160001', 'Vu', 'Thanh F', 'ftvss160001@fpt.edu.vn', 'Software Engineering', 3.80, '0901234572', '2023-09-01'),
('SE160004', 'Dang', 'Hong G', 'ghdse160004@fpt.edu.vn', 'Software Engineering', 2.90, '0901234573', '2023-09-01'),
('HE160003', 'Bui', 'Linh H', 'lhbhe160003@fpt.edu.vn', 'Information Systems', 3.95, '0901234574', '2023-09-01');

-- Course Sample Data (8 courses)

INSERT INTO Course (CourseID, CourseName, Credits, Description) VALUES
('DBI202', 'Introduction to Databases', 3, 'Database design, SQL, normalization, Chapter 3-6'),
('PRJ301', 'Java Web Application', 3, 'Web application development with Java and Spring'),
('SWE201', 'Software Engineering', 3, 'Software development process, Agile, and SDLC'),
('MAE101', 'Mathematics for Engineers', 4, 'Advanced mathematics, linear algebra, calculus'),
('AID101', 'Artificial Intelligence Basics', 3, 'Introduction to AI and machine learning'),
('DSA201', 'Data Structures and Algorithms', 3, 'Data structures and algorithm optimization'),
('WEB301', 'Web Development Advanced', 3, 'Advanced web technologies React, Angular, Node.js'),
('MLE401', 'Machine Learning Engineering', 3, 'Neural networks, deep learning, TensorFlow');

-- Enrollment Sample Data (16 enrollments)

INSERT INTO Enrollment (StudentID, CourseID, SemesterID, InstructorID, MidtermScore, FinalScore) VALUES
-- Fall 2024 (SemesterID=1)
('SE160001', 'DBI202', 1, 'INS00001', 8.5, 9.0),
('SE160001', 'PRJ301', 1, 'INS00002', 7.5, 8.0),
('SE160002', 'DBI202', 1, 'INS00001', 9.0, 9.5),
('SE160002', 'SWE201', 1, 'INS00004', 8.0, 8.5),
('HE160001', 'MAE101', 1, 'INS00003', 6.5, 7.0),
('HE160002', 'DBI202', 1, 'INS00001', 7.0, 7.5),
('SE160003', 'DSA201', 1, 'INS00001', 8.2, 8.8),
('SS160001', 'AID101', 1, 'INS00003', 9.2, 9.5),
-- Spring 2025 (SemesterID=2)
('SE160001', 'WEB301', 2, 'INS00002', NULL, NULL),
('SE160002', 'MLE401', 2, 'INS00005', 8.8, 9.2),
('HE160001', 'PRJ301', 2, 'INS00002', 7.2, 7.8),
('SE160003', 'SWE201', 2, 'INS00004', 7.8, 8.2),
('SS160001', 'WEB301', 2, 'INS00002', 8.5, 9.0),
('HE160003', 'DBI202', 2, 'INS00001', 9.3, 9.8),
('SE160004', 'MAE101', 2, 'INS00003', 5.5, 6.0),
('HE160002', 'DSA201', 2, 'INS00001', 7.3, 7.9);

-- Advisor Assignment Sample Data (8 assignments)
INSERT INTO AdvisorAssignment (StudentID, InstructorID, AssignedDate, UnassignedDate) VALUES
('SE160001', 'INS00001', '2024-09-01', NULL),
('SE160002', 'INS00001', '2024-09-01', NULL),
('SE160003', 'INS00002', '2024-09-01', NULL),
('HE160001', 'INS00002', '2024-09-01', '2025-01-31'),
('HE160002', 'INS00003', '2024-09-01', NULL),
('SS160001', 'INS00004', '2024-09-01', NULL),
('SE160004', 'INS00001', '2024-09-15', NULL),
('HE160003', 'INS00005', '2024-10-01', NULL);

-- Learning Goal Sample Data (12 goals)
INSERT INTO LearningGoal (StudentID, CategoryID, GoalTitle, GoalDescription, TargetValue, StartDate, Deadline, StatusID) VALUES
('SE160001', 1, 'Achieve GPA 3.8', 'Improve GPA from 3.5 to 3.8', 'GPA: 3.8', '2024-09-01', '2024-12-31', 1),
('SE160001', 2, 'AWS Certification', 'Pass AWS Solutions Architect exam', 'Certificate', '2024-09-01', '2025-03-31', 1),
('SE160001', 3, 'FPT Internship', 'Secure internship at FPT', 'Job Offer', '2024-10-01', '2025-02-28', 1),
('SE160002', 1, 'Maintain GPA 3.7', 'Keep high GPA consistent', 'GPA: 3.7+', '2024-09-01', '2024-12-31', 2),
('SE160002', 5, 'Capstone Project', 'Complete capstone project with A grade', 'Grade: A', '2024-09-01', '2025-05-31', 1),
('SE160002', 2, 'Docker Kubernetes', 'Learn DevOps tools Docker and Kubernetes', 'Certificate', '2024-10-15', '2025-06-30', 1),
('HE160001', 4, 'Lose 5kg Weight', 'Health and fitness improvement', 'Weight: -5kg', '2024-09-01', '2025-01-31', 1),
('HE160001', 1, 'DBI202 Excellence', 'Achieve A grade in DBI202', 'Grade: A', '2025-01-06', '2025-05-15', 1),
('SS160001', 2, 'Complete 2 AI Projects', 'Build two machine learning models', 'Projects: 2', '2024-09-01', '2025-03-31', 1),
('SS160001', 3, 'AI Internship', 'Find AI internship at tech company', 'Job Offer', '2024-11-01', '2025-05-31', 1),
('SE160003', 1, 'Improve GPA to 3.5', 'Raise GPA from 3.2 to 3.5', 'GPA: 3.5', '2024-09-01', '2024-12-31', 1),
('HE160003', 1, 'Excellent GPA', 'Achieve GPA above 3.9', 'GPA: 3.9+', '2024-09-01', '2024-12-31', 1);

-- Progress Tracking Sample Data (17 records)
INSERT INTO ProgressTracking (GoalID, ProgressPercent, Notes, TrackingDate, UpdatedBy) VALUES
(1, 25.00, 'Completed 2 of 8 courses, average 3.5', '2024-10-15', 'SE160001'),
(1, 50.00, 'Midterm results good, current GPA 3.6', '2024-11-01', 'SE160001'),
(1, 75.00, 'Continued progress, 5 of 8 courses completed', '2024-11-20', 'INS00001'),
(1, 100.00, 'Completed. Final GPA 3.82', '2024-12-25', 'SE160001'),
(2, 20.00, 'Completed module 1 on Udemy', '2024-10-20', 'SE160001'),
(2, 50.00, 'Course 50 percent complete', '2024-11-15', 'SE160001'),
(3, 30.00, 'Submitted CV to 5 companies', '2024-11-01', 'SE160001'),
(4, 100.00, 'GPA maintained at 3.75', '2024-12-20', 'SE160002'),
(5, 35.00, 'Architecture design completed', '2024-11-10', 'SE160002'),
(5, 60.00, 'Coding progress 60 percent', '2024-12-01', 'SE160002'),
(6, 15.00, 'Started Docker course on Pluralsight', '2024-10-20', 'SE160002'),
(7, 40.00, 'Lost 2kg, exercising 3 times per week', '2024-11-15', 'HE160001'),
(8, 50.00, 'Understood Chapter 3, 4, and 6', '2025-02-15', 'HE160001'),
(9, 50.00, 'Project 1 completed Image Recognition', '2024-11-20', 'SS160001'),
(10, 25.00, 'Updated LinkedIn, applied to 3 companies', '2024-12-01', 'SS160001'),
(11, 55.00, 'Current GPA 3.45, approaching target', '2024-12-10', 'SE160003'),
(12, 98.00, 'Current GPA 3.95, near target', '2024-12-20', 'HE160003');

-- Milestone Sample Data (17 milestones)

INSERT INTO Milestone (GoalID, MilestoneName, Description, DueDate, CompletedDate, CreatedDate) VALUES
(1, 'Midterm Exams', 'Pass all midterm exams with score >= 8.0', '2024-10-31', '2024-10-30', '2024-09-01'),
(1, 'Final Exams', 'Pass all final exams with score >= 8.5', '2024-12-20', '2024-12-25', '2024-09-01'),
(1, 'Final GPA Check', 'Verify final semester GPA', '2024-12-31', '2024-12-26', '2024-09-01'),
(2, 'Complete AWS Course', 'Finish all AWS course videos and quizzes', '2024-12-31', NULL, '2024-09-01'),
(2, 'Practice Exam', 'Score 80 percent on practice exam', '2025-01-31', NULL, '2024-09-01'),
(2, 'Official Exam', 'Pass official AWS certification exam', '2025-03-31', NULL, '2024-09-01'),
(3, 'Submit CVs', 'Send CV to 10 companies', '2024-11-30', NULL, '2024-10-01'),
(3, 'Interview Invitations', 'Receive 3 interview invitations', '2025-01-15', NULL, '2024-10-01'),
(3, 'Job Offer', 'Secure job offer', '2025-02-28', NULL, '2024-10-01'),
(5, 'Design Document', 'Complete system design document', '2024-10-30', '2024-10-28', '2024-09-01'),
(5, 'Code Implementation', 'Implement 80 percent of code', '2024-12-15', NULL, '2024-09-01'),
(5, 'Testing Phase', 'Complete unit and integration tests', '2025-04-30', NULL, '2024-09-01'),
(5, 'Final Submission', 'Present and submit project', '2025-05-31', NULL, '2024-09-01'),
(7, 'First Weight Loss', 'Lose 2kg with gym 3 times weekly', '2024-10-31', '2024-11-10', '2024-09-01'),
(7, 'Target Weight', 'Achieve 5kg weight loss', '2025-01-31', NULL, '2024-09-01'),
(9, 'Project 1 Complete', 'Finish image recognition model', '2024-11-30', '2024-11-20', '2024-09-01'),
(9, 'Project 2 Complete', 'Finish NLP or time series project', '2025-03-31', NULL, '2024-09-01');

-- Audit Log Sample Data (7 initial records)
INSERT INTO AuditLog (TableName, Operation, RecordID, OldValue, NewValue, ModifiedBy) VALUES
('LearningGoal', 'INSERT', '1', NULL, 'Goal: Achieve GPA 3.8, Deadline: 2024-12-31', 'SE160001'),
('LearningGoal', 'UPDATE', '1', 'StatusID: 1', 'StatusID: 2', 'SE160001'),
('ProgressTracking', 'INSERT', '4', NULL, 'GoalID: 1, Progress: 100 percent', 'SE160001'),
('Enrollment', 'INSERT', '1', NULL, 'SE160001, DBI202, Fall2024, INS00001, 8.5, 9.0', 'SYSTEM'),
('AdvisorAssignment', 'UPDATE', '4', 'UnassignedDate: NULL', 'UnassignedDate: 2025-01-31', 'HE160001'),
('Student', 'UPDATE', 'HE160001', 'GPA: 3.60', 'GPA: 3.65', 'SYSTEM'),
('Milestone', 'UPDATE', '1', 'CompletedDate: NULL', 'CompletedDate: 2024-10-30', 'SE160001');
