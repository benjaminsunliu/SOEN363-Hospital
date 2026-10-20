-- Find patients whose discharge-summary clinical note mentions recovery
SELECT DISTINCT
    p.patient_id,
    p.name
FROM Patients p
JOIN Admissions a
    ON a.patient_id = p.patient_id
JOIN Clinical_Notes n
    ON n.admission_id = a.admission_id
WHERE n.note_type ILIKE 'Discharge Summary'
  AND n.note_contents ILIKE '%recovery%';
