-- Join Patients, Admissions and Unit_Stays to find patients whose individual ICU or CCU stay exceeded seven days
-- Calculate each stay's duration by subtracting entry time from exit time.
SELECT
    p.patient_id,
    p.name AS patient_name,
    u.unit_type,
    u.entry_datetime,
    u.exit_datetime,
    u.exit_datetime - u.entry_datetime AS length_of_stay
FROM Patients p
JOIN Admissions a ON a.patient_id = p.patient_id
JOIN Unit_Stays u ON u.admission_id = a.admission_id
WHERE u.unit_type IN ('ICU', 'CCU')
  AND u.exit_datetime - u.entry_datetime > INTERVAL '7 days'
