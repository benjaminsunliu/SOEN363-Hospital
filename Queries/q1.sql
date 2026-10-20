-- Join Patients, Admissions and Triage_Assessments to match patients with their admissions and triage assessments
-- Filter for emergency admissions with high triage priority, using DISTINCT to return unique patient name and admission time pairs
SELECT DISTINCT p.name, a.admission_datetime
FROM Patients p
JOIN Admissions a ON p.patient_id = a.patient_id
JOIN Triage_Assessments t ON a.admission_id = t.admission_id
WHERE a.admission_type = 'Emergency' AND t.priority_level = 'High'
