-- Join Patients and Admissions to find discharged patients with a recorded discharge time
-- Use NOT EXISTS to exclude admissions with surgical procedures
SELECT p.name, a.admission_datetime, a.discharge_datetime
FROM Patients p
JOIN Admissions a ON a.patient_id = p.patient_id
WHERE a.final_admission_status = 'Discharged' AND a.discharge_datetime IS NOT NULL
  AND NOT EXISTS (
      SELECT 1
      FROM Surgical_Procedures s
      WHERE s.admission_id = a.admission_id
  )