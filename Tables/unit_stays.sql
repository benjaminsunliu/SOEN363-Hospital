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