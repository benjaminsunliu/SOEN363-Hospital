-- Using COUNT to aggregate patient ids, right join to include patients with no admissions
SELECT COUNT(a.admission_id)
FROM Admissions a
    RIGHT JOIN Patients p ON a.patient_id = p.patient_id
GROUP BY p.patient_id;
