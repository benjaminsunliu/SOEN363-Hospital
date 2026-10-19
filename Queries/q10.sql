-- Join Admissions, Patients, Unit_Stays and Surgical_Procedures tables to find relationship between patient name, stay type and procedure time
-- Filter to find patients who entered ICU/CCU AFTER a surgical procedure
SELECT p.name, s.procedure_datetime, u.unit_type, u.entry_datetime
FROM Admissions a
    JOIN Patients p ON a.patient_id = p.patient_id
    JOIN Unit_Stays u ON u.admission_id = a.admission_id
    JOIN Surgical_Procedures s ON s.admission_id = u.admission_id
WHERE u.unit_type IN ('ICU', 'CCU')
    AND s.procedure_datetime < u.entry_datetime