-- Admissions where the final status or discharge condition is Deceased
-- Discharge date-time is used as the date of death
-- LEFT JOIN so admissions with no primary diagnosis still show up

SELECT p.name, a.admission_datetime, dr.discharge_datetime AS date_of_death,
       d.icd9_code AS primary_icd9_code, i.diagnosis_title AS primary_diagnosis
FROM Patients p
JOIN Admissions a ON a.patient_id = p.patient_id
JOIN Discharge_Records dr ON dr.admission_id = a.admission_id
LEFT JOIN Diagnoses d ON d.admission_id = a.admission_id AND d.diagnosis_type = 'Primary'
LEFT JOIN ICD9_Dictionary i ON i.icd9_code = d.icd9_code
WHERE a.final_admission_status = 'Deceased'
   OR dr.patient_condition = 'Deceased';
