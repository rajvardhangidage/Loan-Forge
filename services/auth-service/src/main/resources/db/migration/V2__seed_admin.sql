INSERT IGNORE INTO users (id, email, password_hash, role, enabled, created_at)
VALUES 
    ('10000000-0000-0000-0000-000000000001', 'admin@lending.com', '$2a$10$5EylXuSPQcDnuWYzgQ2tSe0gyiH2MtBFRq1nWGgt9SWbksVS6IOOu', 'ADMIN', TRUE, NOW(6)),
    ('10000000-0000-0000-0000-000000000002', 'officer@lending.com', '$2a$10$7Ym9J9fFeHGEaQBP2n3s3e7bloaGynw3JKJp0hCxBeo9zfXD15IyW', 'LOAN_OFFICER', TRUE, NOW(6));
