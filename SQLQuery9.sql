CREATE LOGIN Akhilesh_DBMS1 WITH PASSWORD ='password123', DEFAULT_DATABASE = patientAccessRegistration;

CREATE ROLE readuser;

GRANT SELECT ON patients TO readuser;
GRANT SELECT ON medicalHistory TO readuser;
GRANT SELECT ON physicians TO readuser;
GRANT SELECT ON physicianContactInfo TO readuser;
GRANT SELECT ON nurses TO readuser;
GRANT SELECT ON notes TO readuser;
GRANT SELECT ON appointments TO readuser;
GRANT SELECT ON admissionTypes TO readuser;
GRANT SELECT ON admissions TO readuser;
GRANT SELECT ON procedures TO readuser;
GRANT SELECT ON medications TO readuser;
GRANT SELECT ON labTests TO readuser;
GRANT SELECT ON billing TO readuser;
GRANT SELECT ON billingServices TO readuser;
GRANT SELECT ON rooms TO readuser;
GRANT SELECT ON equipment TO readuser;
GRANT SELECT ON roomReservations TO readuser;
GRANT SELECT ON surgeryTypes TO readuser;
GRANT SELECT ON surgeryRooms TO readuser;
GRANT SELECT ON surgeryRoomSchedules TO readuser;
GRANT SELECT ON inpatientRooms TO readuser;
GRANT SELECT ON inpatientRoomSchedules TO readuser;
GRANT SELECT ON icd10Codes TO readuser;
GRANT SELECT ON icd10Diagnoses TO readuser;
GRANT SELECT ON icd10Procedures TO readuser;




CREATE ROLE notesuser;

GRANT SELECT, INSERT, UPDATE, DELETE ON notes TO notesuser;
GRANT SELECT, INSERT, UPDATE, DELETE ON appointments TO notesuser;


CREATE ROLE medicaluser
GRANT SELECT, INSERT, UPDATE, DELETE ON medicalHistory TO medicaluser
GRANT SELECT, INSERT, UPDATE, DELETE ON procedures TO medicaluser
GRANT SELECT, INSERT, UPDATE, DELETE ON medications TO medicaluser


CREATE ROLE admin_user
GRANT ALL PRIVILEGES ON patients TO admin_user;
GRANT ALL PRIVILEGES ON medicalHistory TO admin_user;
GRANT ALL PRIVILEGES ON physicians TO admin_user;
GRANT ALL PRIVILEGES ON physicianContactInfo TO admin_user;
GRANT ALL PRIVILEGES ON nurses TO admin_user;
GRANT ALL PRIVILEGES ON notes TO admin_user;
GRANT ALL PRIVILEGES ON appointments TO admin_user;
GRANT ALL PRIVILEGES ON admissionTypes TO admin_user;
GRANT ALL PRIVILEGES ON admissions TO admin_user;
GRANT ALL PRIVILEGES ON procedures TO admin_user;
GRANT ALL PRIVILEGES ON medications TO admin_user;
GRANT ALL PRIVILEGES ON labTests TO admin_user;
GRANT ALL PRIVILEGES ON billing TO admin_user;
GRANT ALL PRIVILEGES ON billingServices TO admin_user;
GRANT ALL PRIVILEGES ON rooms TO admin_user;
GRANT ALL PRIVILEGES ON equipment TO admin_user;
GRANT ALL PRIVILEGES ON roomReservations TO admin_user;
GRANT ALL PRIVILEGES ON surgeryTypes TO admin_user;
GRANT ALL PRIVILEGES ON surgeryRooms TO admin_user;
GRANT ALL PRIVILEGES ON surgeryRoomSchedules TO admin_user;
GRANT ALL PRIVILEGES ON inpatientRooms TO admin_user;
GRANT ALL PRIVILEGES ON inpatientRoomSchedules TO admin_user;
GRANT ALL PRIVILEGES ON icd10Codes TO admin_user;
GRANT ALL PRIVILEGES ON icd10Diagnoses TO admin_user;
GRANT ALL PRIVILEGES ON icd10Procedures TO admin_user;


