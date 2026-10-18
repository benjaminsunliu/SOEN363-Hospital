CREATE TABLE Discharge_Records (
    record_id SERIAL PRIMARY KEY,
    admission_id INT NOT NULL UNIQUE,
    responsible_physician_id INT NOT NULL,

    discharge_datetime TIMESTAMP NOT NULL,
    discharge_destination VARCHAR(100),
    patient_condition TEXT,
    prescribed_medications TEXT,
    follow_up_instructions TEXT,
    scheduled_appointments TEXT,

    FOREIGN KEY (admission_id)
        REFERENCES Admissions(admission_id),

    FOREIGN KEY (responsible_physician_id)
        REFERENCES Healthcare_Professionals(professional_id)
);