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