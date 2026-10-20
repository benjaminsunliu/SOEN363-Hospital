-- Join Patients and Admissions to match patients with their admissions
-- Use EXISTS to require both a surgical procedure and a completed radiology examination linked through Diagnostic_Orders for the same admission
SELECT p.patient_id, p.name, a.admission_id
FROM Patients p
JOIN Admissions a ON a.patient_id = p.patient_id
WHERE EXISTS (
    SELECT 1
    FROM Surgical_Procedures s
    WHERE s.admission_id = a.admission_id
)
AND EXISTS (
    SELECT 1
    FROM Diagnostic_Orders o
    JOIN Radiology_Examinations r
        ON r.order_id = o.order_id
    WHERE o.admission_id = a.admission_id
      AND r.exam_status = 'Completed'
)
