-- Pull every note for each patient
-- NOT EXISTS keeps only the most recent note per patient

SELECT p.name, n.note_type, n.note_datetime, n.note_contents
FROM Patients p
JOIN Admissions a ON a.patient_id = p.patient_id
JOIN Clinical_Notes n ON n.admission_id = a.admission_id
WHERE NOT EXISTS (
    SELECT 1
    FROM Admissions a2
    JOIN Clinical_Notes n2 ON n2.admission_id = a2.admission_id
    WHERE a2.patient_id = p.patient_id
      AND n2.note_datetime > n.note_datetime
);
