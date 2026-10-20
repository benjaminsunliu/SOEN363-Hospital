-- Return every completed admission tied for the longest hospital stay
WITH completed_admissions AS (
    SELECT
        a.admission_id,
        a.patient_id,
        a.admission_datetime,
        a.discharge_datetime,
        a.discharge_datetime - a.admission_datetime AS length_of_stay
    FROM Admissions a
    WHERE a.discharge_datetime IS NOT NULL
)
SELECT
    p.patient_id,
    p.name,
    ca.admission_id,
    ca.admission_datetime,
    ca.discharge_datetime,
    ca.length_of_stay
FROM completed_admissions ca
JOIN Patients p
    ON p.patient_id = ca.patient_id
WHERE ca.length_of_stay = (
    SELECT MAX(length_of_stay)
    FROM completed_admissions
);
