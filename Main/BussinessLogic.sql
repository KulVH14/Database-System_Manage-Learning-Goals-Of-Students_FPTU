--1----------------------
SELECT 
    StudentID,
    FirstName + ' ' + LastName AS FullName,
    Major,
    GPA
FROM Student
ORDER BY GPA DESC, StudentID ASC;
--2 ------------------------------
SELECT 
    s.FirstName, 
    s.LastName, 
    c.CourseName, 
    e.MidtermScore, 
    e.FinalScore
FROM 
    Student s
INNER JOIN 
    Enrollment e ON s.StudentID = e.StudentID
INNER JOIN 
    Course c ON e.CourseID = c.CourseID
WHERE 
    s.StudentID = 'SE160002';
--3 --------------------------------------                                    
select (select count(*)
from Student
where IsActive = 1) as ToTalActiveStudents,
(select avg(cast(GPA as decimal(5,2))) from Student) as AverageGPA,
(select count(*)
from LearningGoal lg
join GoalStatusLookup gs on gs.StatusID=lg.StatusID
where gs.StatusName = 'Active') as TotalActiveGoals

-- 4-------------------------------
SELECT
    e.InstructorID,
    AVG(e.FinalScore) AS AvgFinalScore,
    COUNT(*) AS NumEnrollments
FROM Enrollment e
GROUP BY e.InstructorID
HAVING AVG(e.FinalScore) > 8.5
   AND COUNT(*) >= 2
ORDER BY AvgFinalScore DESC;

-- 5-------------------------------
SELECT
    s.StudentID,
    s.FirstName + ' ' + s.LastName AS FullName,
    s.Major,
    s.GPA
FROM Student s
INNER JOIN (
    SELECT Major, AVG(GPA) AS AvgMajorGPA
    FROM Student
    GROUP BY Major
) mg ON s.Major = mg.Major
WHERE s.GPA > mg.AvgMajorGPA
ORDER BY s.Major, s.GPA DESC;
--6----------------------------------
SELECT
    GoalID,
    GoalTitle
FROM
    LearningGoal
WHERE
    (GoalTitle LIKE N'%Docker%' OR GoalTitle LIKE N'%Kubernetes%')
    OR
    (GoalDescription LIKE N'%Docker%' OR GoalDescription LIKE N'%Kubernetes%');
--7-------------------------------------
SELECT
    e1.CourseID,
    e1.StudentID AS Student1_ID,
    e2.StudentID AS Student2_ID
FROM
    Enrollment e1
INNER JOIN
    Enrollment e2 ON e1.CourseID = e2.CourseID 
                 AND e1.SemesterID = e2.SemesterID
WHERE
    e1.StudentID < e2.StudentID;

--8----------------------------------------
CREATE PROCEDURE sp_AddNewCourse
    -- 1. Declare input parameters
    @CourseID VARCHAR(10),
    @CourseName NVARCHAR(200),
    @Credits INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        -- 4. Main DML statement: Insert data
        INSERT INTO Course (CourseID, CourseName, Credits)
        VALUES (@CourseID, @CourseName, @Credits);
 
        PRINT 'New course has been added successfully.';
        SELECT *
        FROM Course
 
    END TRY
    BEGIN CATCH
       
        PRINT 'Error: ' + ERROR_MESSAGE();
        RAISERROR('Unable to add course. An error has occurred.', 16, 1);
    END CATCH
END;
 
-- Example execution:
EXEC sp_AddNewCourse @CourseID = 'NEW101', @CourseName = N'New Course Title', @Credits = 3;

--9----------------------------------------------
CREATE TRIGGER trg_AuditNewStudent
ON Student                    
AFTER INSERT                  
AS
BEGIN
    SET NOCOUNT ON;
 
   
    INSERT INTO AuditLog (
        TableName,
        Operation,
        RecordID,
        NewValue,
        ModifiedBy
    )
 
    
    SELECT
        'Student',                              
        'INSERT',                               
        i.StudentID,                            
        i.FirstName + ' ' + i.LastName,         
        'SYSTEM'                               
    FROM
        inserted i; 
END                 
