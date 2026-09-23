CREATE TABLE customers
(
    id            VARCHAR(36) PRIMARY KEY,
    user_id       VARCHAR(36)  NOT NULL UNIQUE,
    full_name     VARCHAR(150) NOT NULL,
    phone         VARCHAR(30),
    date_of_birth DATE,
    kyc_status    VARCHAR(30)  NOT NULL,
    created_at    DATETIME(6)  NOT NULL,
    updated_at    DATETIME(6)  NOT NULL
);
CREATE INDEX idx_customers_user_id ON customers (user_id);
