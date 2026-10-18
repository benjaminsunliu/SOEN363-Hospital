CREATE TABLE Surgical_Procedures (
    procedure_id SERIAL PRIMARY KEY,
    admission_id INT NOT NULL,
    professional_id INT NOT NULL,

    procedure_type VARCHAR(100) NOT NULL,
    procedure_datetime TIMESTAMP NOT NULL,

    FOREIGN KEY (admission_id)
        REFERENCES Admissions(admission_id),

    FOREIGN KEY (professional_id)
        REFERENCES Healthcare_Professionals(professional_id)
);