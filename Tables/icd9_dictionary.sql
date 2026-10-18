CREATE TABLE ICD9_Dictionary (
    icd9_code VARCHAR(10) PRIMARY KEY,
    diagnosis_title VARCHAR(255) NOT NULL,
    description TEXT,
    disease_category VARCHAR(100)
);