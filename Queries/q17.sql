-- Match each admission to its diagnoses
-- Keep admissions with more than one distinct ICD9 code


SELECT p.name, a.admission_id, COUNT(DISTINCT d.icd9_code) AS distinct_icd9_codes
FROM Patients p
    JOIN Admissions a ON a.patient_id = p.patient_id
    
    JOIN Diagnoses d ON d.admission_id = a.admission_id
GROUP BY p.patient_id, p.name, a.admission_id
HAVING COUNT(DISTINCT d.icd9_code) > 1;
