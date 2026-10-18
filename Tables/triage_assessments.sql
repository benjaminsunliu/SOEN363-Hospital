CREATE TABLE Triage_Assessments (
    triage_id SERIAL PRIMARY KEY,
    admission_id INT NOT NULL,

    assessment_datetime TIMESTAMP NOT NULL,
    reported_symptoms TEXT,
    known_allergies TEXT,
    current_medications TEXT,
    priority_level VARCHAR(50) NOT NULL,
    pain_level INT,
    oxygen_saturation DECIMAL(5,2),
    body_temperature DECIMAL(4,1),
    respiratory_rate INT,
    heart_rate INT,
    blood_pressure VARCHAR(20),

    FOREIGN KEY (admission_id)
        REFERENCES Admissions(admission_id),

    CHECK (pain_level BETWEEN 0 AND 10),
    CHECK (oxygen_saturation BETWEEN 0 AND 100)
);