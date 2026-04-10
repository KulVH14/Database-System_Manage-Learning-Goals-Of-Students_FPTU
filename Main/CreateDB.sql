
CREATE DATABASE FPTU_LearningGoalManagement


-- SECTION I: LOOKUP TABLES (REFERENCE DATA)


-- Table: GoalCategoryLookup
-- Purpose: Master list of goal categories
CREATE TABLE GoalCategoryLookup (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),
    CategoryName NVARCHAR(50) NOT NULL UNIQUE,
    Description NVARCHAR(200),
    IsActive BIT DEFAULT 1
);

-- Table: GoalStatusLookup
-- Purpose: Master list of goal statuses (Active, Completed, Failed, Cancelled)
CREATE TABLE GoalStatusLookup (
    StatusID INT PRIMARY KEY IDENTITY(1,1),
    StatusName NVARCHAR(30) NOT NULL UNIQUE 
        CHECK(StatusName IN ('Active', 'Completed', 'Failed', 'Cancelled')),
    Description NVARCHAR(200),
    IsActive BIT DEFAULT 1
);

-- Table: SemesterLookup
-- Purpose: Academic semester information
CREATE TABLE SemesterLookup (
    SemesterID INT PRIMARY KEY IDENTITY(1,1),
    SemesterCode VARCHAR(20) NOT NULL UNIQUE,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    IsActive BIT DEFAULT 1,
    CHECK(EndDate > StartDate)
);

-- SECTION II: CORE ENTITY TABLES



-- Table: Instructor
-- Purpose: Faculty members who teach courses and advise students
CREATE TABLE Instructor (
    InstructorID VARCHAR(10) PRIMARY KEY 
        CHECK(InstructorID LIKE 'INS[0-9][0-9][0-9][0-9][0-9]'),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE 
        CHECK(Email LIKE '%_@__%.__%'),
    Department NVARCHAR(100) NOT NULL,
    Phone VARCHAR(15),
    HireDate DATE DEFAULT GETDATE(),
    IsActive BIT DEFAULT 1
);

-- Table: Student
-- Purpose: Students enrolled in the university
CREATE TABLE Student (
    StudentID VARCHAR(10) PRIMARY KEY 
        CHECK(
            (StudentID LIKE 'SE[0-9][0-9][0-9][0-9][0-9][0-9]') OR
            (StudentID LIKE 'HE[0-9][0-9][0-9][0-9][0-9][0-9]') OR
            (StudentID LIKE 'SS[0-9][0-9][0-9][0-9][0-9][0-9]')
        ),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE 
        CHECK(Email LIKE '%_@__%.__%'),
    Major NVARCHAR(100) NOT NULL,
    GPA DECIMAL(3,2) DEFAULT 0.00 
        CHECK(GPA >= 0.00 AND GPA <= 4.00),
    EnrollmentDate DATE DEFAULT GETDATE(),
    Phone VARCHAR(15),
    IsActive BIT DEFAULT 1
);

-- Table: Course
-- Purpose: Course catalog (template for all offerings)

CREATE TABLE Course (
    CourseID VARCHAR(10) PRIMARY KEY 
        CHECK(CourseID LIKE '[A-Z][A-Z][A-Z][0-9][0-9][0-9]'),
    CourseName NVARCHAR(200) NOT NULL,
    Credits INT NOT NULL CHECK(Credits > 0 AND Credits <= 6),
    Description NVARCHAR(500),
    IsActive BIT DEFAULT 1
);

-- Table: Enrollment
-- Purpose: Records of student course registrations


CREATE TABLE Enrollment (
    EnrollmentID INT PRIMARY KEY IDENTITY(1,1),
    StudentID VARCHAR(10) NOT NULL,
    CourseID VARCHAR(10) NOT NULL,
    SemesterID INT NOT NULL,
    
   
    InstructorID VARCHAR(10) NULL,
    
    MidtermScore DECIMAL(5,2) CHECK(MidtermScore >= 0 AND MidtermScore <= 10),
    FinalScore DECIMAL(5,2) CHECK(FinalScore >= 0 AND FinalScore <= 10),
    EnrollmentDate DATE DEFAULT GETDATE(),
    
   
    -- Allows flexible score entry: Midterm first, Final later
    
    UNIQUE(StudentID, CourseID, SemesterID),
    
    
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID) 
        ON DELETE NO ACTION ON UPDATE CASCADE,
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID) 
        ON DELETE NO ACTION ON UPDATE CASCADE,
    FOREIGN KEY (SemesterID) REFERENCES SemesterLookup(SemesterID)
        ON DELETE NO ACTION,
    FOREIGN KEY (InstructorID) REFERENCES Instructor(InstructorID)
        ON DELETE SET NULL
);

-- Table: LearningGoal
-- Purpose: Student-defined learning objectives
CREATE TABLE LearningGoal (
    GoalID INT PRIMARY KEY IDENTITY(1,1),
    StudentID VARCHAR(10) NOT NULL,
    CategoryID INT NOT NULL, 
    GoalTitle NVARCHAR(200) NOT NULL,
    GoalDescription NVARCHAR(500),
    TargetValue NVARCHAR(100) NOT NULL,
    StartDate DATE NOT NULL DEFAULT GETDATE(),
    Deadline DATE NOT NULL,
    StatusID INT NOT NULL DEFAULT 1,
    CreatedDate DATETIME DEFAULT GETDATE(),
    LastModifiedDate DATETIME DEFAULT GETDATE(),
    
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID) 
        ON DELETE NO ACTION ON UPDATE CASCADE,
    FOREIGN KEY (CategoryID) REFERENCES GoalCategoryLookup(CategoryID),
    FOREIGN KEY (StatusID) REFERENCES GoalStatusLookup(StatusID),
    CHECK(Deadline > StartDate)
);

-- Table: ProgressTracking
-- Purpose: Historical records of goal progress updates

CREATE TABLE ProgressTracking (
    TrackingID INT PRIMARY KEY IDENTITY(1,1),
    GoalID INT NOT NULL,
    ProgressPercent DECIMAL(5,2) NOT NULL 
        CHECK(ProgressPercent >= 0 AND ProgressPercent <= 100),
    Notes NVARCHAR(500),
    TrackingDate DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedBy VARCHAR(10) NOT NULL,
    
    FOREIGN KEY (GoalID) REFERENCES LearningGoal(GoalID) 
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Table: Milestone
-- Purpose: Sub-goals or checkpoints within a learning goal

CREATE TABLE Milestone (
    MilestoneID INT PRIMARY KEY IDENTITY(1,1),
    GoalID INT NOT NULL,
    MilestoneName NVARCHAR(200) NOT NULL,
    Description NVARCHAR(500),
    DueDate DATE NOT NULL,
    CompletedDate DATE,
    
   
    CreatedDate DATETIME NOT NULL,
    
    CHECK(CompletedDate IS NULL OR CompletedDate >= CreatedDate),
    
    FOREIGN KEY (GoalID) REFERENCES LearningGoal(GoalID) 
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Table: AdvisorAssignment
-- Purpose: Tracks student-advisor relationships over time

CREATE TABLE AdvisorAssignment (
    AssignmentID INT PRIMARY KEY IDENTITY(1,1),
    StudentID VARCHAR(10) NOT NULL,
    InstructorID VARCHAR(10) NOT NULL,
    AssignedDate DATE NOT NULL DEFAULT GETDATE(),
    UnassignedDate DATE,
    
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID) 
        ON DELETE NO ACTION ON UPDATE CASCADE,
    FOREIGN KEY (InstructorID) REFERENCES Instructor(InstructorID) 
        ON DELETE NO ACTION ON UPDATE CASCADE,
    CHECK(UnassignedDate IS NULL OR UnassignedDate > AssignedDate)
);

-- Table: AuditLog
-- Purpose: Comprehensive audit trail for all data modifications

CREATE TABLE AuditLog (
    LogID INT PRIMARY KEY IDENTITY(1,1),
    TableName NVARCHAR(50) NOT NULL,
    Operation NVARCHAR(20) NOT NULL CHECK(Operation IN ('INSERT', 'UPDATE', 'DELETE')),
    RecordID NVARCHAR(100) NOT NULL,
    OldValue NVARCHAR(MAX),
    NewValue NVARCHAR(MAX),
    ModifiedBy VARCHAR(10),
    ModifiedDate DATETIME DEFAULT GETDATE()
);



