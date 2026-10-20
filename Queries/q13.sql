-- Find admissions with a radiology examination and no ICU or CCU stay
SELECT
    a.admission_id,
    p.patient_id,
    p.name
FROM Admissions a
JOIN Patients p
    ON p.patient_id = a.patient_id
WHERE EXISTS (
    SELECT 1
    FROM Diagnostic_Orders o
    JOIN Radiology_Examinations r
        ON r.order_id = o.order_id
    WHERE o.admission_id = a.admission_id
)
AND NOT EXISTS (
    SELECT 1
    FROM Unit_Stays u
    WHERE u.admission_id = a.admission_id
      AND u.unit_type IN ('ICU', 'CCU')
);
