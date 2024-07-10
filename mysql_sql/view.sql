CREATE VIEW ExaminationSummary AS
SELECT 
    p.Name AS PatientName,
    e.ExaminationDateTime,
    e.ExaminationDetails,
    d.DepartmentName
FROM 
    examination e
JOIN 
    patient p ON e.PatientID = p.PatientID
JOIN 
    doctor doc ON e.DoctorID = doc.DoctorID
JOIN 
    department d ON doc.DepartmentID = d.DepartmentID;



CREATE VIEW TreatmentSummary AS
SELECT 
    n.Name AS NurseName,
    p.Name AS PatientName,
    t.TreatmentDateTime,
    t.TreatmentDetails,
    d.DepartmentName
FROM 
    treatment t
JOIN 
    nurse n ON t.NurseID = n.NurseID
JOIN 
    patient p ON t.PatientID = p.PatientID
JOIN 
    department d ON n.DepartmentID = d.DepartmentID;
