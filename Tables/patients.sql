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