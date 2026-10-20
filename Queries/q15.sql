-- Count each unit stay after the first in an admission as a transfer
WITH unit_stay_counts AS (
    SELECT
        admission_id,
        COUNT(*) AS unit_stay_count
    FROM Unit_Stays
    GROUP BY admission_id
),
patient_transfers AS (
    SELECT
        a.patient_id,
        SUM(GREATEST(COALESCE(usc.unit_stay_count, 0) - 1, 0)) AS total_transfers
    FROM Admissions a
    LEFT JOIN unit_stay_counts usc
        ON usc.admission_id = a.admission_id
    GROUP BY a.patient_id
)
SELECT
    p.patient_id,
    p.name,
    COALESCE(pt.total_transfers, 0) AS total_transfers
FROM Patients p
LEFT JOIN patient_transfers pt
    ON pt.patient_id = p.patient_id;
