-- Count the number of treatments by specific nurses
SELECT COUNT(*)
FROM treatment
WHERE NurseID = 1 OR NurseID = 2 OR NurseID = 3 OR NurseID = 4 OR NurseID = 5 OR NurseID = 6 OR NurseID = 7 OR NurseID = 8;

-- Count the number of examinations by specific doctors
SELECT COUNT(*)
FROM examination
WHERE DoctorID = 1 OR DoctorID = 2 OR DoctorID = 3 OR DoctorID = 4 OR DoctorID = 5 OR DoctorID = 6 OR DoctorID = 7 OR DoctorID = 8;

-- Explain the count query for the treatment table
EXPLAIN SELECT COUNT(*)
FROM treatment
WHERE NurseID = 1 OR NurseID = 2 OR NurseID = 3 OR NurseID = 4 OR NurseID = 5 OR NurseID = 6 OR NurseID = 7 OR NurseID = 8;

-- Explain the count query for the examination table
EXPLAIN SELECT COUNT(*)
FROM examination
WHERE DoctorID = 1 OR DoctorID = 2 OR DoctorID = 3 OR DoctorID = 4 OR DoctorID = 5 OR DoctorID = 6 OR DoctorID = 7 OR DoctorID = 8;

-- Create an index on the DoctorID column of the examination table
CREATE INDEX idx_doctor_id ON examination (DoctorID) USING BTREE;

-- Create an index on the NurseID column of the treatment table
CREATE INDEX idx_nurse_id ON treatment (NurseID) USING BTREE;

-- Show all indexes from the examination table
SHOW INDEX FROM examination;

-- Show all indexes from the treatment table
SHOW INDEX FROM treatment;
