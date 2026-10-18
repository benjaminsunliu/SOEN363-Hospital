CREATE TABLE Admissions (
    admission_id SERIAL PRIMARY KEY,
    patient_id INT NOT NULL,
    admitting_professional_id INT NOT NULL,

    admission_datetime TIMESTAMP NOT NULL,
    discharge_datetime TIMESTAMP,
    admission_type VARCHAR(50) NOT NULL,
    reason_for_admission TEXT NOT NULL,
    admission_source VARCHAR(100),
    insurance_information VARCHAR(100),
    
    final_admission_status VARCHAR(50) NOT NULL,

    FOREIGN KEY (patient_id)
        REFERENCES Patients(patient_id),

    FOREIGN KEY (admitting_professional_id)
        REFERENCES Healthcare_Professionals(professional_id),

    CHECK (
        discharge_datetime IS NULL
        OR discharge_datetime > admission_datetime
    )
);