-- Hospital database schema
-- PostgreSQL

CREATE TABLE Patients (
    patient_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender VARCHAR(20) NOT NULL,
    address VARCHAR(255),
    phone_number VARCHAR(20),
    emergency_contact VARCHAR(100),
    life_status VARCHAR(20) NOT NULL DEFAULT 'Alive',
    health_insurance_number VARCHAR(20) NOT NULL UNIQUE,

    CONSTRAINT chk_life_status
        CHECK (life_status IN ('Alive', 'Deceased'))
);

CREATE TABLE Healthcare_Professionals (
    professional_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    role VARCHAR(50) NOT NULL,
    specialty VARCHAR(100)
);

CREATE TABLE ICD9_Dictionary (
    icd9_code VARCHAR(10) PRIMARY KEY,
    diagnosis_title VARCHAR(255) NOT NULL,
    description TEXT,
    disease_category VARCHAR(100)
);

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

CREATE TABLE Unit_Stays (
    unit_stay_id SERIAL PRIMARY KEY,
    admission_id INT NOT NULL,
    responsible_physician_id INT NOT NULL,

    unit_type VARCHAR(50) NOT NULL,
    entry_datetime TIMESTAMP NOT NULL,
    exit_datetime TIMESTAMP,
    hospital_ward VARCHAR(100),
    room_number VARCHAR(20),
    bed_number VARCHAR(20),
    reason_for_transfer TEXT,

    FOREIGN KEY (admission_id)
        REFERENCES Admissions(admission_id),

    FOREIGN KEY (responsible_physician_id)
        REFERENCES Healthcare_Professionals(professional_id),

    CHECK (
        exit_datetime IS NULL
        OR exit_datetime > entry_datetime
    ),

    CHECK (
        unit_type IN ('ED', 'ICU', 'CCU', 'General Ward')
    )
);

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
    note_type VARCHAR(50),
    note_datetime TIMESTAMP,
    note_contents TEXT,

    FOREIGN KEY (admission_id)
        REFERENCES Admissions(admission_id),

    FOREIGN KEY (professional_id)
        REFERENCES Healthcare_Professionals(professional_id)
);

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

CREATE TABLE Radiology_Examinations (
    exam_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    referring_physician_id INT NOT NULL,
    radiology_technician_id INT,

    exam_type VARCHAR(100) NOT NULL,
    exam_datetime TIMESTAMP NOT NULL,
    examined_body_area VARCHAR(100),
    exam_status VARCHAR(50) NOT NULL,
    medical_images_link TEXT,

    FOREIGN KEY (order_id)
        REFERENCES Diagnostic_Orders(order_id),

    FOREIGN KEY (referring_physician_id)
        REFERENCES Healthcare_Professionals(professional_id),

    FOREIGN KEY (radiology_technician_id)
        REFERENCES Healthcare_Professionals(professional_id)
);

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
