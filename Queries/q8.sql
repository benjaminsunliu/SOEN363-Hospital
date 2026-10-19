-- Join tables to find admission related to ICD9 codes, group by the codes and count them, limit result to 1 for top result (descending)
SELECT COUNT(DISTINCT d.diagnosis_id) AS c, i.icd9_code, i.description
FROM Unit_Stays u
    JOIN Admissions a ON u.admission_id = a.admission_id
    JOIN Diagnoses d ON d.admission_id = a.admission_id
    JOIN ICD9_Dictionary i ON i.icd9_code = d.icd9_code
WHERE u.unit_type IN ('ICU', 'CCU')
    AND d.diagnosis_type = 'Primary'
GROUP BY i.icd9_code, i.description
ORDER BY c DESC
LIMIT 1;