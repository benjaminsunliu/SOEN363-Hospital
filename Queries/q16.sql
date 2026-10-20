-- Match each admission to its ICU/CCU stays
-- Keep admissions that were in more than one unit type

SELECT p.patient_id, p.name, a.admission_id, COUNT(DISTINCT u.unit_type) AS critical_unit_types
FROM Patients p
JOIN Admissions a ON a.patient_id = p.patient_id
JOIN Unit_Stays u ON u.admission_id = a.admission_id
WHERE u.unit_type IN ('ICU', 'CCU')
GROUP BY p.patient_id, p.name, a.admission_id
HAVING COUNT(DISTINCT u.unit_type) > 1;
