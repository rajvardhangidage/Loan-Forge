CREATE TABLE loan_products
(
    id                   VARCHAR(36) PRIMARY KEY,
    name                 VARCHAR(120)   NOT NULL,
    min_amount           DECIMAL(15, 2) NOT NULL,
    max_amount           DECIMAL(15, 2) NOT NULL,
    annual_interest_rate DECIMAL(7, 4)  NOT NULL,
    max_tenure_months    INT            NOT NULL,
    active               BOOLEAN        NOT NULL DEFAULT TRUE
);

CREATE TABLE loan_applications
(
    id            VARCHAR(36) PRIMARY KEY,
    customer_id   VARCHAR(36)    NOT NULL,
    product_id    VARCHAR(36)    NOT NULL,
    amount        DECIMAL(15, 2) NOT NULL,
    tenure_months INT            NOT NULL,
    status        VARCHAR(40)    NOT NULL,
    created_at    DATETIME(6)    NOT NULL,
    updated_at    DATETIME(6)    NOT NULL,
    CONSTRAINT fk_loan_app_product FOREIGN KEY (product_id) REFERENCES loan_products (id)
);

CREATE TABLE repayment_schedule
(
    id                  VARCHAR(36) PRIMARY KEY,
    loan_application_id VARCHAR(36)    NOT NULL,
    installment_number  INT            NOT NULL,
    due_date            DATE           NOT NULL,
    principal           DECIMAL(15, 2) NOT NULL,
    interest            DECIMAL(15, 2) NOT NULL,
    total_amount        DECIMAL(15, 2) NOT NULL,
    status              VARCHAR(30)    NOT NULL,
    CONSTRAINT fk_schedule_loan FOREIGN KEY (loan_application_id) REFERENCES loan_applications (id)
);

CREATE INDEX idx_loan_app_customer ON loan_applications (customer_id);
CREATE INDEX idx_loan_app_status ON loan_applications (status);
CREATE INDEX idx_schedule_due_date ON repayment_schedule (due_date);

INSERT INTO loan_products(id, name, min_amount, max_amount, annual_interest_rate, max_tenure_months, active)
VALUES ('00000000-0000-0000-0000-000000000001', 'Personal Micro Loan', 5000, 200000, 18.0, 24, TRUE);
