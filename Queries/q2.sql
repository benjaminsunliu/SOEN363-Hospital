-- Join Patients and Admissions to match patients with their admissions, grouping by patient ID and name to count admissions per patient
-- Use HAVING to return only patients with more than three admissions
SELECT p.patient_id, p.name, COUNT(a.admission_id) AS total_admissions
FROM Patients p
JOIN Admissions a ON a.patient_id = p.patient_id
GROUP BY p.patient_id, p.name
HAVING COUNT(a.admission_id) > 3
