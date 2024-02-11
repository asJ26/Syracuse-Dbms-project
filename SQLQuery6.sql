use patientAccessRegistration

CREATE TABLE patients (
  patientId INT PRIMARY KEY,
  name VARCHAR(255),
  address VARCHAR(255),
  contactInfo VARCHAR(255),
  dateOfBirth DATE,
  insuranceInfo VARCHAR(255)
);

CREATE TABLE medicalHistory (
  medicalHistoryId INT PRIMARY KEY,
  patientId INT REFERENCES patients(patientId),
  condition VARCHAR(255),
  diagnosisDate DATE,
  diagnosisDetails VARCHAR(255),
  treatment VARCHAR(255)
);

CREATE TABLE physicians (
  physicianId INT PRIMARY KEY,
  name VARCHAR(255),
  specialty VARCHAR(255),
  licenseInfo VARCHAR(255)
);

CREATE TABLE physicianContactInfo (
  physicianContactInfoId INT PRIMARY KEY,
  physicianId INT REFERENCES physicians(physicianId),
  contactInfo VARCHAR(255),
  address VARCHAR(255),
  email VARCHAR(255)
);

CREATE TABLE nurseJobTitles (
  jobTitleId INT PRIMARY KEY,
  title VARCHAR(255)
);

CREATE TABLE nurses (
  nurseId INT PRIMARY KEY,
  name VARCHAR(255),
  department VARCHAR(255),
  jobTitleId INT REFERENCES nurseJobTitles(jobTitleId),
  hireDate DATE
);

CREATE TABLE notes (
  noteId INT PRIMARY KEY,
  patientId INT REFERENCES patients(patientId),
  physicianId INT REFERENCES physicians(physicianId),
  nurseId INT REFERENCES nurses(nurseId),
  noteText VARCHAR(255),
  createdAt DATETIME,
  updatedAt DATETIME
);

CREATE TABLE appointments (
  appointmentId INT PRIMARY KEY,
  patientId INT REFERENCES patients(patientId),
  physicianId INT REFERENCES physicians(physicianId),
  appointmentDatetime DATETIME,
  reason VARCHAR(255)
);

CREATE TABLE admissionTypes (
  admissionTypeId INT PRIMARY KEY,
  type VARCHAR(255)
);

CREATE TABLE admissions (
  admissionId INT PRIMARY KEY,
  patientId INT REFERENCES patients(patientId),
  physicianId INT REFERENCES physicians(physicianId),
  nurseId INT REFERENCES nurses(nurseId),
  admissionTypeId INT REFERENCES admissionTypes(admissionTypeId),
  admissionDate DATE,
  dischargeDate DATE,
  diagnosisDetails VARCHAR(255)
);

CREATE TABLE procedures (
  procedureId INT PRIMARY KEY,
  patientId INT REFERENCES patients(patientId),
  physicianId INT REFERENCES physicians(physicianId),
  procedureDate DATE,
  procedureDetails VARCHAR(255)
);

CREATE TABLE medications (
  medicationId INT PRIMARY KEY,
  patientId INT REFERENCES patients(patientId),
  physicianId INT REFERENCES physicians(physicianId),
  medicationName VARCHAR(255),
  dosage VARCHAR(255),
  frequency VARCHAR(255),
  startDate DATE,
  endDate DATE
);

CREATE TABLE labTests (
  labTestId INT PRIMARY KEY,
  patientId INT REFERENCES patients(patientId),
  physicianId INT REFERENCES physicians(physicianId),
  testName VARCHAR(255),
  testDate DATE,
  testResults VARCHAR(255)
);

CREATE TABLE billing (
  billingId INT PRIMARY KEY,
  patientId INT REFERENCES patients(patientId),
  physicianId INT REFERENCES physicians(physicianId),
  nurseId INT REFERENCES nurses(nurseId),
  serviceCharge DECIMAL,
  insuranceInfo VARCHAR(255),
  paymentInfo VARCHAR(255)
);

CREATE TABLE billingServices (
  billingServiceId INT PRIMARY KEY,
  billingId INT REFERENCES billing(billingId),
  serviceName VARCHAR(255),
  serviceCharge DECIMAL
);

CREATE TABLE rooms (
  roomId INT PRIMARY KEY,
  roomNumber VARCHAR(255),
  roomType VARCHAR(255)
);

CREATE TABLE equipment (
  equipmentId INT PRIMARY KEY,
  equipmentName VARCHAR(255),
  equipmentDescription VARCHAR(255)
);

CREATE TABLE roomReservations (
    reservationId INT PRIMARY KEY,
    roomId INT REFERENCES rooms(roomId),
    patientId INT REFERENCES patients(patientId),
    physicianId INT REFERENCES physicians(physicianId),
    nurseId INT REFERENCES nurses(nurseId),
    startDate DATETIME,
    endDate DATETIME
);

CREATE TABLE surgeryTypes (
    surgeryTypeId INT PRIMARY KEY,
    type VARCHAR(255)
);

CREATE TABLE surgeryRooms (
    surgeryRoomId INT PRIMARY KEY,
    roomId INT REFERENCES rooms(roomId),
    surgeryTypeId INT REFERENCES surgeryTypes(surgeryTypeId)
);

CREATE TABLE surgeryRoomSchedules (
    scheduleId INT PRIMARY KEY,
    surgeryRoomId INT REFERENCES surgeryRooms(surgeryRoomId),
    physicianId INT REFERENCES physicians(physicianId),
    nurseId INT REFERENCES nurses(nurseId),
    startDatetime DATETIME,
    endDatetime DATETIME
);

CREATE TABLE inpatientRooms (
    inpatientRoomId INT PRIMARY KEY,
    roomId INT REFERENCES rooms(roomId),
    bedNumber INT
);

CREATE TABLE inpatientRoomSchedules (
    scheduleId INT PRIMARY KEY,
    inpatientRoomId INT REFERENCES inpatientRooms(inpatientRoomId),
    patientId INT REFERENCES patients(patientId),
    nurseId INT REFERENCES nurses(nurseId),
    startDatetime DATETIME,
    endDatetime DATETIME
);

CREATE TABLE icd10Codes (
    icd10CodeId INT PRIMARY KEY,
    code VARCHAR(255),
    description VARCHAR(255)
);

CREATE TABLE icd10Diagnoses (
    icd10DiagnosisId INT PRIMARY KEY,
    admissionId INT REFERENCES admissions(admissionId),
    icd10CodeId INT REFERENCES icd10Codes(icd10CodeId)
);

CREATE TABLE icd10Procedures (
    icd10ProcedureId INT PRIMARY KEY,
    procedureId INT REFERENCES procedures(procedureId),
    icd10CodeId INT REFERENCES icd10Codes(icd10CodeId)
);


INSERT INTO patients (patientId, name, address, contactInfo, dateOfBirth, insuranceInfo) 
VALUES 
(1, 'Linda Davis', '123 Maple Street, Anytown USA', '555-1234', '1990-01-15', 'XYZ Insurance'),
(2, 'Alex Johnson', '456 Elm Street, Anytown USA', '555-5678', '1985-07-01', 'ABC Insurance'),
(3, 'Emily Parker', '789 Oak Street, Anytown USA', '555-9876', '1977-02-10', 'LMN Insurance'),
(4, 'Ethan Martin', '234 Pine Street, Anytown USA', '555-4321', '1995-11-03', 'QRS Insurance'),
(5, 'Isabella Wright', '567 Oak Street, Anytown USA', '555-8765', '1980-09-18', 'TUV Insurance');

INSERT INTO medicalHistory (medicalHistoryId, patientId, condition, diagnosisDate, diagnosisDetails, treatment) 
VALUES 
(1, 1, 'High Blood Pressure', '2015-01-01', 'BP reading: 140/90', 'Prescription medication'),
(2, 2, 'Type 1 Diabetes', '2010-07-15', 'High blood sugar levels', 'Insulin injections'),
(3, 3, 'Asthma', '2003-04-05', 'Difficulty breathing', 'Inhaler'),
(4, 4, 'Migraine Headaches', '2018-09-01', 'Throbbing pain, sensitivity to light and sound', 'Prescription medication'),
(5, 5, 'Depression', '2005-12-10', 'Persistent sadness, loss of interest', 'Psychotherapy');


INSERT INTO physicians (physicianId, name, specialty, licenseInfo) 
VALUES 
(1, 'Dr. Elizabeth Smith', 'Cardiology', '1234'),
(2, 'Dr. Matthew Johnson', 'Endocrinology', '5678'),
(3, 'Dr. Sarah Lee', 'Neurology', '9012'),
(4, 'Dr. David Brown', 'Psychiatry', '3456'),
(5, 'Dr. Jennifer Davis', 'Dermatology', '7890');


INSERT INTO physicianContactInfo (physicianContactInfoId, physicianId, contactInfo, address, email) 
VALUES 
(1, 1, '555-1111', '456 Main Street, Anytown USA', 'elizabeth.smith@physicians.com'),
(2, 2, '555-2222', '789 Elm Street, Anytown USA', 'matthew.johnson@physicians.com'),
(3, 3, '555-3333', '123 Oak Street, Anytown USA', 'sarah.lee@physicians.com'),
(4, 4, '555-4444', '234 Pine Street, Anytown USA', 'david.brown@physicians.com'),
(5, 5, '555-5555', '567 Maple Street, Anytown USA', 'jennifer.davis@physicians.com');

INSERT INTO nurseJobTitles (jobTitleId, title)
VALUES 
(1, 'Registered Nurse'),
(2, 'Licensed Practical Nurse'),
(3, 'Certified Nursing Assistant'),
(4, 'Nurse Practitioner'),
(5, 'Clinical Nurse Specialist');

INSERT INTO nurses (nurseId, name, department, jobTitleId, hireDate) 
VALUES 
(1, 'Maria Perez', 'Emergency Room', 1, '2015-01-01'),
(2, 'John Smith', 'Intensive Care Unit', 2, '2010-07-15'),
(3, 'Emily Chen', 'Pediatrics', 3, '2003-04-05'),
(4, 'David Lee', 'Operating Room', 4, '2018-09-01'),
(5, 'Sarah Johnson', 'Cardiology', 5, '2005-12-10');


INSERT INTO notes (noteId, patientId, physicianId, nurseId, noteText, createdAt, updatedAt) 
VALUES 
(1, 1, 1, 1, 'Patient is experiencing chest pain', '2023-04-30 08:00:00', '2023-04-30 08:30:00'),
(2, 2, 2, 2, 'Patient is due for insulin injection', '2023-04-30 10:00:00', '2023-04-30 10:30:00'),
(3, 3, 3, 3, 'Patient is experiencing shortness of breath', '2023-04-30 12:00:00', '2023-04-30 12:30:00'),
(4, 4, 4, 4, 'Patient is anxious and experiencing panic attacks', '2023-04-30 14:00:00', '2023-04-30 14:30:00'),
(5, 5, 5, 5, 'Patient has a rash on their arm', '2023-04-30 16:00:00', '2023-04-30 16:30:00');


INSERT INTO appointments (appointmentId, patientId, physicianId, appointmentDatetime, reason) 
VALUES 
(1, 1, 1, '2023-05-01 10:00:00', 'Follow-up for high blood pressure'),
(2, 2, 2, '2023-05-02 14:00:00', 'Diabetes management'),
(3, 3, 3, '2023-05-03 09:00:00', 'Asthma check-up'),
(4, 4, 4, '2023-05-04 11:00:00', 'Anxiety and depression therapy'),
(5, 5, 5, '2023-05-05 13:00:00', 'Skin condition evaluation');


-- admissionTypes table
INSERT INTO admissionTypes (admissionTypeId, type)
VALUES
  (1, 'Emergency'),
  (2, 'Urgent'),
  (3, 'Elective'),
  (4, 'Maternity'),
  (5, 'Trauma');

-- admissions table
INSERT INTO admissions (admissionId, patientId, physicianId, nurseId, admissionTypeId, admissionDate, dischargeDate, diagnosisDetails)
VALUES
  (10, 1, 1, 1, 1, '2022-03-15', '2022-03-20', 'Pneumonia'),
  (12, 2, 2, 2, 2, '2022-04-01', '2022-04-05', 'Appendicitis'),
  (13, 3, 3, 3, 3, '2022-05-10', '2022-05-12', 'Hernia'),
  (14, 4, 4, 4, 4, '2022-06-20', '2022-06-22', 'Delivery'),
  (15, 5, 5, 5, 5, '2022-07-15', '2022-07-30', 'Fractured leg');

-- procedures table
INSERT INTO procedures (procedureId, patientId, physicianId, procedureDate, procedureDetails)
VALUES
  (1, 1, 1, '2022-03-22', 'Appendectomy'),
  (2, 2, 2, '2022-04-03', 'Hernia repair'),
  (3, 3, 3, '2022-05-12', 'Gallbladder removal'),
  (4, 4, 4, '2022-06-21', 'C-section'),
  (5, 5, 5, '2022-07-20', 'Arm surgery');

-- medications table
INSERT INTO medications (medicationId, patientId, physicianId, medicationName, dosage, frequency, startDate, endDate)
VALUES
  (1, 1, 1, 'Ibuprofen', '400mg', '3 times a day', '2022-03-15', '2022-03-20'),
  (2, 2, 2, 'Amoxicillin', '500mg', '2 times a day', '2022-04-01', '2022-04-05'),
  (3, 3, 3, 'Omeprazole', '20mg', 'once a day', '2022-05-10', '2022-05-12'),
  (4, 4, 4, 'Folic acid', '400mcg', 'once a day', '2022-06-20', '2022-06-22'),
  (5, 5, 5, 'Morphine', '10mg', 'as needed', '2022-07-15', '2022-07-30');

INSERT INTO labTests (labTestId, patientId, physicianId, testName, testDate, testResults)
VALUES 
  (1, 2, 3, 'Blood Test', '2023-04-15', 'Normal'),
  (2, 1, 4, 'Urine Test', '2023-04-17', 'Abnormal'),
  (3, 3, 2, 'X-ray', '2023-04-18', 'Fracture'),
  (4, 4, 1, 'MRI', '2023-04-20', 'Normal'),
  (5, 2, 4, 'Blood Test', '2023-04-25', 'Abnormal');

INSERT INTO billing (billingId, patientId, physicianId, nurseId, serviceCharge, insuranceInfo, paymentInfo)
VALUES 
  (1, 2, 3, 4, 500.00, 'XYZ Insurance', 'Paid'),
  (2, 1, 4, 2, 2500.00, 'ABC Insurance', 'Unpaid'),
  (3, 3, 2, 1, 800.00, 'PQR Insurance', 'Paid'),
  (4, 4, 1, 3, 1200.00, 'XYZ Insurance', 'Paid'),
  (5, 2, 4, 1, 400.00, 'ABC Insurance', 'Unpaid');

INSERT INTO billingServices (billingServiceId, billingId, serviceName, serviceCharge)
VALUES 
  (1, 1, 'Consultation', 100.00),
  (2, 1, 'Lab Test', 200.00),
  (3, 2, 'Surgery', 2000.00),
  (4, 3, 'Medication', 400.00),
  (5, 4, 'MRI', 1000.00);

INSERT INTO rooms (roomId, roomNumber, roomType)
VALUES 
  (1, '101', 'Single'),
  (2, '102', 'Double'),
  (3, '201', 'Single'),
  (4, '202', 'Double'),
  (5, '301', 'Single');

-- Equipment
INSERT INTO equipment (equipmentId, equipmentName, equipmentDescription)
VALUES
(1, 'X-ray machine', 'A machine used for medical imaging'),
(2, 'CT scanner', 'A machine used for diagnostic imaging'),
(3, 'MRI machine', 'A machine used for diagnostic imaging');

-- Room Reservations
INSERT INTO roomReservations (reservationId, roomId, patientId, physicianId, nurseId, startDate, endDate)
VALUES
(1, 1, 1, 1, 1, '2023-05-01 10:00:00', '2023-05-01 12:00:00'),
(2, 2, 2, 2, 2, '2023-05-02 13:00:00', '2023-05-02 15:00:00'),
(3, 3, 3, 3, 3, '2023-05-03 16:00:00', '2023-05-03 18:00:00');

-- Surgery Types
INSERT INTO surgeryTypes (surgeryTypeId, type)
VALUES
(1, 'Open surgery'),
(2, 'Minimally invasive surgery'),
(3, 'Robotic surgery');

-- Surgery Rooms
INSERT INTO surgeryRooms (surgeryRoomId, roomId, surgeryTypeId)
VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3);

-- Surgery Room Schedules
INSERT INTO surgeryRoomSchedules (scheduleId, surgeryRoomId, physicianId, nurseId, startDatetime, endDatetime)
VALUES
(1, 1, 1, 1, '2023-05-01 10:00:00', '2023-05-01 12:00:00'),
(2, 2, 2, 2, '2023-05-02 13:00:00', '2023-05-02 15:00:00'),
(3, 3, 3, 3, '2023-05-03 16:00:00', '2023-05-03 18:00:00');

-- Inpatient Rooms
INSERT INTO inpatientRooms (inpatientRoomId, roomId, bedNumber)
VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3);

-- Inpatient Room Schedules
INSERT INTO inpatientRoomSchedules (scheduleId, inpatientRoomId, patientId, nurseId, startDatetime, endDatetime)
VALUES
(1, 1, 1, 1, '2023-05-01 10:00:00', '2023-05-03 12:00:00'),
(2, 2, 2, 2, '2023-05-02 13:00:00', '2023-05-04 15:00:00'),
(3, 3, 3, 3, '2023-05-03 16:00:00', '2023-05-05 18:00:00');


INSERT INTO icd10Codes (icd10CodeId, code, description) 
VALUES 
(1, 'C34.11', 'Malignant neoplasm of upper lobe, right bronchus or lung'),
(2, 'C50.511', 'Malignant neoplasm of lower-inner quadrant of right female breast'),
(3, 'F10.20', 'Alcohol dependence, uncomplicated'),
(4, 'J45.20', 'Mild intermittent asthma, uncomplicated'),
(5, 'R05', 'Cough')

-- icd10Diagnoses table
INSERT INTO icd10Diagnoses (icd10DiagnosisId, admissionId, icd10CodeId)
VALUES 
(1, 10, 1),
(2, 10, 4),
(3, 12, 2),
(4, 12, 5),
(5, 13, 3)

-- icd10Procedures table
INSERT INTO icd10Procedures (icd10ProcedureId, procedureId, icd10CodeId)
VALUES 
(1, 1, 2),
(2, 2, 1),
(3, 3, 4),
(4, 4, 5),
(5, 5, 3)


select *
from patients

select *
from nurses

select*
from medications

select* 
from admissions

CREATE VIEW patientMedicalHistory AS
SELECT p.patientId, p.name, p.address, p.contactInfo, p.dateOfBirth, p.insuranceInfo,
       mh.condition, mh.diagnosisDate, mh.diagnosisDetails, mh.treatment
FROM patients p
JOIN medicalHistory mh ON p.patientId = mh.patientId;



CREATE VIEW patientMedications AS
SELECT p.name AS patientName, m.medicationName, m.dosage, m.frequency, md.name AS physicianName, md.specialty
FROM patients p
JOIN medications m ON p.patientId = m.patientId
JOIN physicians md ON m.physicianId = md.physicianId;




CREATE VIEW labTestResults AS
SELECT p.name AS patientName, l.testName, l.testDate, l.testResults, md.name AS physicianName, md.specialty
FROM patients p
JOIN labTests l ON p.patientId = l.patientId
JOIN physicians md ON l.physicianId = md.physicianId;




CREATE VIEW patientBilling AS
SELECT p.name AS patientName, bs.serviceName, bs.serviceCharge, b.serviceCharge AS totalCharge
FROM patients p
JOIN billing b ON p.patientId = b.patientId
JOIN billingServices bs ON b.billingId = bs.billingId;




select * from patientMedicalHistory;
select * from patientMedications;
select * from labTestResults;
select * from patientBilling;



CREATE PROCEDURE sp_get_patient_history
    @patientId INT
AS
BEGIN
    SELECT mh.condition, mh.diagnosisDate, mh.diagnosisDetails, mh.treatment, p.procedureDate, p.procedureDetails
    FROM medicalHistory mh
    LEFT JOIN procedures p ON p.patientId = mh.patientId
    WHERE mh.patientId = @patientId;
END

EXEC sp_get_patient_history @patientId = 2



CREATE PROCEDURE sp_get_appointments_by_date
    @appointmentDate DATE
AS
BEGIN
    SELECT a.appointmentDatetime, p.name AS patientName, ph.name AS physicianName, a.reason
    FROM appointments a
    JOIN patients p ON p.patientId = a.patientId
    JOIN physicians ph ON ph.physicianId = a.physicianId
    WHERE CONVERT(DATE, a.appointmentDatetime) = @appointmentDate
    ORDER BY ph.name, p.name;
END
EXEC sp_get_appointments_by_date '2023-05-01';


CREATE PROCEDURE sp_get_billing_by_patient
    @patientId INT
AS
BEGIN
    SELECT b.serviceName, b.serviceCharge
    FROM billingServices b
    JOIN billing bl ON bl.billingId = b.billingId
    WHERE bl.patientId = @patientId;
END
EXEC sp_get_billing_by_patient @patientId = 3;


CREATE PROCEDURE sp_get_available_rooms
    @startDate DATETIME,
    @endDate DATETIME,
    @roomType VARCHAR(255)
AS
BEGIN
    SELECT r.roomNumber, r.roomType
    FROM rooms r
    WHERE r.roomType = @roomType
    AND NOT EXISTS (
        SELECT *
        FROM roomReservations rr
        WHERE rr.roomId = r.roomId
        AND (@startDate >= rr.startDate AND @startDate < rr.endDate)
        OR (@endDate > rr.startDate AND @endDate <= rr.endDate)
        OR (@startDate <= rr.startDate AND @endDate >= rr.endDate)
    );
END


EXEC sp_get_available_rooms '2023-05-01 12:00:00', '2023-05-05 12:00:00', 'single'


CREATE FUNCTION getPatientAdmissions(@patientId INT) 
RETURNS @output TABLE (
  admissionId INT,
  physicianId INT,
  nurseId INT,
  admissionType VARCHAR(255),
  admissionDate DATE,
  dischargeDate DATE,
  diagnosisDetails VARCHAR(255)
) AS BEGIN
	insert @output
  SELECT 
    admissions.admissionId, 
    admissions.physicianId, 
    admissions.nurseId, 
    admissionTypes.type, 
    admissions.admissionDate, 
    admissions.dischargeDate, 
    admissions.diagnosisDetails
  FROM 
    admissions
    JOIN admissionTypes ON admissions.admissionTypeId = admissionTypes.admissionTypeId
  WHERE 
    admissions.patientId = @patientId
	return
	END

SELECT * FROM dbo.getPatientAdmissions(3);




CREATE FUNCTION findPatientNotes(@patientId INT, @condition varchar)
RETURNS @output TABLE(noteText VARCHAR(255), diagnosisDetails VARCHAR(255))
BEGIN
  insert @output
    SELECT notes.noteText, medicalHistory.diagnosisDetails
    FROM notes
    JOIN physicians ON physicians.physicianId = notes.physicianId
    JOIN medicalHistory ON medicalHistory.patientId = notes.patientId
    WHERE notes.patientId = @patientId
    AND medicalHistory.condition = @condition
 return
END;

SELECT * from dbo.findPatientNotes(3,'Diabetes')
select *
    FROM notes
    JOIN physicians ON physicians.physicianId = notes.physicianId
    JOIN medicalHistory ON medicalHistory.patientId = notes.patientId
	WHERE notes.patientId = 3
    AND medicalHistory.condition = 'Diabetes'



---A function to find all patients who have not had any appointments in the past 30 days:
CREATE FUNCTION findInactivePatients()
RETURNS @output TABLE(patientName VARCHAR(255), lastAppointmentDate DATE)
BEGIN
  insert @output
    SELECT patients.name, MAX(appointments.appointmentDatetime)
    FROM patients
    LEFT JOIN appointments ON appointments.patientId = patients.patientId
    GROUP BY patients.patientId, patients.name
    HAVING MAX(appointments.appointmentDatetime) < DATEADD(day, -30, GETDATE())
  return
END;

select * from dbo.findInactivePatients();


--- A function to find the most commonly diagnosed condition among all patients:
CREATE FUNCTION findMostCommonDiagnosis()
RETURNS VARCHAR(255)
BEGIN
  DECLARE @mostCommonCondition VARCHAR(255);
  SELECT TOP 1 @mostCommonCondition = medicalHistory.condition
  FROM medicalHistory
  GROUP BY medicalHistory.condition
  ORDER BY COUNT(*) DESC;
  RETURN @mostCommonCondition;
END;


SELECT dbo.findMostCommonDiagnosis();



CREATE TRIGGER update_notes_updatedAt
ON notes AFTER UPDATE 
AS
BEGIN
    UPDATE notes
    SET updatedAt = CURRENT_TIMESTAMP
    WHERE noteId IN (SELECT noteId FROM INSERTED);
END;

SELECT updatedAt
FROM notes
WHERE noteId = 1;





CREATE TRIGGER update_billing_insurance
ON patients
AFTER UPDATE
AS
BEGIN
    IF UPDATE(insuranceInfo)
    BEGIN
        UPDATE billing
        SET insuranceInfo = i.insuranceInfo
        FROM inserted i
        WHERE billing.patientId = i.patientId;
    END
END;

UPDATE patients
SET insuranceInfo = 'New Insurance Info'
WHERE patientId = 4;


CREATE TRIGGER updateMedicalHistory ON admissions 
AFTER INSERT 
AS
BEGIN
    INSERT INTO medicalHistory (medicalHistoryId, patientId, condition, diagnosisDate, diagnosisDetails, treatment)
    SELECT RAND(),i.patientId, 'Admission', i.admissionDate, i.diagnosisDetails, i.admissionTypeId
    FROM inserted i;
END;

drop trigger updateMedicalHistory

INSERT INTO admissions (admissionId, patientId, physicianId, nurseId, admissionTypeId, admissionDate, dischargeDate, diagnosisDetails)
VALUES (6, 3, 1, 2, 1, '2022-05-28', '2022-06-01', 'Myocardial infarction');

select * from medicalHistory



CREATE TRIGGER update_billing_and_services ON medications
AFTER INSERT 
AS
BEGIN
  UPDATE billing
  SET serviceCharge = serviceCharge + 50
  WHERE patientId = (SELECT patientId FROM inserted);
  
  INSERT INTO billingServices (billingId, serviceName, serviceCharge)
  SELECT billingId, 'Medication', 50
  FROM billing 
  WHERE patientId = (SELECT patientId FROM inserted);
END;










BEGIN TRANSACTION;

INSERT INTO notes (patientId, physicianId, noteText, createdAt, updatedAt) 
VALUES (1, 1, 'Patient appears to be responding well to treatment.', 1, 1);

COMMIT TRANSACTION;



CREATE USER 'readonly_user'@'localhost' IDENTIFIED BY 'password123';
GRANT SELECT ON patients TO 'readonly_user'@'localhost';
GRANT SELECT ON medicalHistory TO 'readonly_user'@'localhost';
GRANT SELECT ON physicians TO 'readonly_user'@'localhost';
GRANT SELECT ON physicianContactInfo TO 'readonly_user'@'localhost';
GRANT SELECT ON nurses TO 'readonly_user'@'localhost';
GRANT SELECT ON notes TO 'readonly_user'@'localhost';
GRANT SELECT ON appointments TO 'readonly_user'@'localhost';
GRANT SELECT ON admissionTypes TO 'readonly_user'@'localhost';
GRANT SELECT ON admissions TO 'readonly_user'@'localhost';
GRANT SELECT ON procedures TO 'readonly_user'@'localhost';
GRANT SELECT ON medications TO 'readonly_user'@'localhost';
GRANT SELECT ON labTests TO 'readonly_user'@'localhost';
GRANT SELECT ON billing TO 'readonly_user'@'localhost';
GRANT SELECT ON billingServices TO 'readonly_user'@'localhost';
GRANT SELECT ON rooms TO 'readonly_user'@'localhost';
GRANT SELECT ON equipment TO 'readonly_user'@'localhost';
GRANT SELECT ON roomReservations TO 'readonly_user'@'localhost';
GRANT SELECT ON surgeryTypes TO 'readonly_user'@'localhost';
GRANT SELECT ON surgeryRooms TO 'readonly_user'@'localhost';
GRANT SELECT ON surgeryRoomSchedules TO 'readonly_user'@'localhost';
GRANT SELECT ON inpatientRooms TO 'readonly_user'@'localhost';
GRANT SELECT ON inpatientRoomSchedules TO 'readonly_user'@'localhost';
GRANT SELECT ON icd10Codes TO 'readonly_user'@'localhost';
GRANT SELECT ON icd10Diagnoses TO 'readonly_user'@'localhost';
GRANT SELECT ON icd10Procedures TO 'readonly_user'@'localhost';
```

-- 2. Create a user with read and write access to notes and appointments:
```
CREATE USER 'notes_user'@'localhost' IDENTIFIED BY 'password123';
GRANT SELECT, INSERT, UPDATE, DELETE ON notes TO 'notes_user'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON appointments TO 'notes_user'@'localhost';
```

-- 3. Create a user with read and write access to medicalHistory, procedures, and medications:
```
CREATE USER 'medical_user'@'localhost' IDENTIFIED BY 'password123';
GRANT SELECT, INSERT, UPDATE, DELETE ON medicalHistory TO 'medical_user'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON procedures TO 'medical_user'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON medications TO 'medical_user'@'localhost';
```

-- 4. Create an admin user with full access to all tables:
```
CREATE USER 'admin_user'@'localhost' IDENTIFIED BY 'password123';
GRANT ALL PRIVILEGES ON patients TO 'admin_user'@'localhost';
GRANT ALL PRIVILEGES ON medicalHistory TO 'admin_user'@'localhost';
GRANT ALL PRIVILEGES ON physicians TO 'admin_user'@'localhost';
GRANT ALL PRIVILEGES ON physicianContactInfo TO 'admin_user'@'localhost';
GRANT ALL PRIVILEGES ON nurses TO 'admin_user'@'localhost';
GRANT ALL PRIVILEGES ON notes TO 'admin_user'@'localhost';
GRANT ALL PRIVILEGES ON appointments TO 'admin_user'@'localhost';
GRANT ALL PRIVILEGES ON admissionTypes TO 'admin_user'@'localhost';
GRANT ALL PRIVILEGES ON admissions

