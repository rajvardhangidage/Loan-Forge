CREATE TABLE payments
(
    id                 VARCHAR(36) PRIMARY KEY,
    loan_id            VARCHAR(36)    NOT NULL,
    customer_id        VARCHAR(36)    NOT NULL,
    amount             DECIMAL(15, 2) NOT NULL,
    idempotency_key    VARCHAR(120)   NOT NULL UNIQUE,
    status             VARCHAR(30)    NOT NULL,
    provider_reference VARCHAR(120),
    created_at         DATETIME(6)    NOT NULL,
    updated_at         DATETIME(6)    NOT NULL
);
CREATE INDEX idx_payments_loan ON payments (loan_id);
CREATE INDEX idx_payments_customer ON payments (customer_id);