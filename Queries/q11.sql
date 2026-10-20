-- Count radiology examinations across all admissions, including patients with none
SELECT
    p.patient_id,
    p.name,
    COUNT(DISTINCT r.exam_id) AS total_radiology_examinations
FROM Patients p
LEFT JOIN Admissions a
    ON a.patient_id = p.patient_id
LEFT JOIN Diagnostic_Orders o
    ON o.admission_id = a.admission_id
LEFT JOIN Radiology_Examinations r
    ON r.order_id = o.order_id
GROUP BY p.patient_id, p.name;
