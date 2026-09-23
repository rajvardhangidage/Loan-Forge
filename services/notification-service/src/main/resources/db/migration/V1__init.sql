CREATE TABLE notifications
(
    id           VARCHAR(36) PRIMARY KEY,
    event_type   VARCHAR(80)  NOT NULL,
    aggregate_id VARCHAR(120) NOT NULL,
    channel      VARCHAR(30)  NOT NULL,
    recipient    VARCHAR(255),
    status       VARCHAR(30)  NOT NULL,
    created_at   DATETIME(6)  NOT NULL
);
CREATE INDEX idx_notifications_aggregate ON notifications (aggregate_id);