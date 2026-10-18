CREATE TABLE Clinical_Notes (
    note_id SERIAL PRIMARY KEY,
    admission_id INT NOT NULL,
    professional_id INT NOT NULL,

    treatment_plan TEXT,
    suspected_condition TEXT,
    physical_exam_description TEXT,
    patient_symptoms TEXT,
    initial_clinical_findings TEXT,
    planned_diagnostic_examinations TEXT,
    

    FOREIGN KEY (admission_id)
        REFERENCES Admissions(admission_id),

    FOREIGN KEY (professional_id)
        REFERENCES Healthcare_Professionals(professional_id)
);