-- Procedure and exam have to be from the same admission
-- Cast both timestamps to DATE so only the day is compared


SELECT p.name, a.admission_id, s.procedure_type, r.exam_type,
       CAST(s.procedure_datetime AS DATE) AS common_date
FROM Patients p
JOIN Admissions a ON a.patient_id = p.patient_id
JOIN Surgical_Procedures s ON s.admission_id = a.admission_id
JOIN Diagnostic_Orders o ON o.admission_id = a.admission_id
JOIN Radiology_Examinations r ON r.order_id = o.order_id
WHERE CAST(s.procedure_datetime AS DATE) = CAST(r.exam_datetime AS DATE);
