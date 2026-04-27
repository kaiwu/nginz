DROP TABLE IF EXISTS bench_users;

CREATE TABLE bench_users (
    id         INTEGER PRIMARY KEY,
    org_id     INTEGER NOT NULL,
    status     TEXT NOT NULL,
    name       TEXT NOT NULL,
    email      TEXT NOT NULL,
    bio        TEXT,
    created_at TIMESTAMPTZ NOT NULL
);

INSERT INTO bench_users (id, org_id, status, name, email, bio, created_at)
SELECT
    gs,
    ((gs - 1) % 50) + 1,
    CASE WHEN gs % 5 = 0 THEN 'inactive' ELSE 'active' END,
    'User ' || gs,
    'user' || gs || '@example.com',
    CASE
        WHEN gs % 3 = 0 THEN repeat('benchmark-bio-', 8) || gs
        ELSE NULL
    END,
    TIMESTAMPTZ '2024-01-01 00:00:00+00' + ((gs - 1) * INTERVAL '1 minute')
FROM generate_series(1, 5000) AS gs;

CREATE INDEX bench_users_status_id_idx ON bench_users (status, id);
CREATE INDEX bench_users_org_id_id_idx ON bench_users (org_id, id);
CREATE INDEX bench_users_created_at_id_idx ON bench_users (created_at DESC, id DESC);

ANALYZE bench_users;
