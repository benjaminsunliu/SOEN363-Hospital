CREATE TABLE Diagnostic_Orders (
    order_id SERIAL PRIMARY KEY,
    patient_id INT NOT NULL,
    admission_id INT NOT NULL,
    requesting_physician_id INT NOT NULL,

    requested_examination VARCHAR(100) NOT NULL,
    request_datetime TIMESTAMP NOT NULL,
    clinical_reason TEXT,
    priority VARCHAR(50),
    order_status VARCHAR(50) NOT NULL,

    FOREIGN KEY (patient_id)
        REFERENCES Patients(patient_id),

    FOREIGN KEY (admission_id)
        REFERENCES Admissions(admission_id),

    FOREIGN KEY (requesting_physician_id)
        REFERENCES Healthcare_Professionals(professional_id)
);
