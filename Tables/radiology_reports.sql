CREATE TABLE Radiology_Reports (
    report_id SERIAL PRIMARY KEY,
    exam_id INT NOT NULL UNIQUE,
    radiologist_id INT NOT NULL,

    finding TEXT,
    interpretation TEXT,
    conclusion TEXT,

    FOREIGN KEY (exam_id)
        REFERENCES Radiology_Examinations(exam_id),

    FOREIGN KEY (radiologist_id)
        REFERENCES Healthcare_Professionals(professional_id)
);
