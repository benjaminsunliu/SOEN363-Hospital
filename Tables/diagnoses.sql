CREATE TABLE Diagnoses (
    diagnosis_id SERIAL PRIMARY KEY,
    patient_id INT NOT NULL,
    admission_id INT NOT NULL,
    icd9_code VARCHAR(10) NOT NULL,
    diagnosing_physician_id INT NOT NULL,

    diagnosis_datetime TIMESTAMP NOT NULL,
    diagnosis_type VARCHAR(20) NOT NULL,

    FOREIGN KEY (patient_id)
        REFERENCES Patients(patient_id),

    FOREIGN KEY (admission_id)
        REFERENCES Admissions(admission_id),

    FOREIGN KEY (icd9_code)
        REFERENCES ICD9_Dictionary(icd9_code),

    FOREIGN KEY (diagnosing_physician_id)
        REFERENCES Healthcare_Professionals(professional_id),

    CHECK (diagnosis_type IN ('Primary', 'Secondary'))
);