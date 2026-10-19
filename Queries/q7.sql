-- Join to match all the unit stays belonging to the same admission id, then checking whether one is ED, the other is CCU or ICU, and making sure ED happens before
SELECT p.name
FROM Patients p
WHERE EXISTS (
    SELECT *
    FROM Admissions a
        JOIN Unit_Stays e ON e.admission_id = a.admission_id
        JOIN Unit_Stays c ON c.admission_id = a.admission_id
    WHERE a.patient_id = p.patient_id
        AND e.unit_type = 'ED'
        AND c.unit_type IN ('ICU', 'CCU')
        AND e.entry_datetime < c.entry_datetime

);