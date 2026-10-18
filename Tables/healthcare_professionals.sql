CREATE TABLE Healthcare_Professionals (
    professional_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    role VARCHAR(50) NOT NULL,
    specialty VARCHAR(100)
);