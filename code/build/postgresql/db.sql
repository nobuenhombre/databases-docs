CREATE TABLE accounts
(
    id         bigserial
        constraint accounts_pk primary key,
    owner      varchar     NOT NULL,
    balance    bigint      NOT NULL,
    currency   varchar     NOT NULL,
    created_at timestamptz NOT NULL DEFAULT (now())
);

CREATE TABLE entries
(
    id         bigserial
        constraint entries_pk primary key,
    account_id bigint      NOT NULL,
    amount     bigint      NOT NULL,
    created_at timestamptz NOT NULL DEFAULT (now())
);

CREATE TABLE transfers
(
    id              bigserial
        constraint transfers_pk primary key,
    from_account_id bigint      NOT NULL,
    to_account_id   bigint      NOT NULL,
    amount          bigint      NOT NULL,
    created_at      timestamptz NOT NULL DEFAULT (now())
);

ALTER TABLE entries
    ADD FOREIGN KEY (account_id) REFERENCES accounts (id);

ALTER TABLE transfers
    ADD FOREIGN KEY (from_account_id) REFERENCES accounts (id);

ALTER TABLE transfers
    ADD FOREIGN KEY (to_account_id) REFERENCES accounts (id);

CREATE INDEX index_accounts_owner ON accounts (owner);

CREATE INDEX index_entries_account_id ON entries (account_id);

CREATE INDEX index_transfers_from_account_id ON transfers (from_account_id);

CREATE INDEX index_transfers_to_account_id ON transfers (to_account_id);

CREATE INDEX index_transfers_from_account_id_to_account_id ON transfers (from_account_id, to_account_id);

COMMENT ON COLUMN entries.amount IS 'can be negative or positive';

COMMENT ON COLUMN transfers.amount IS 'must be positive';

CREATE TABLE users
(
    username            varchar
        constraint users_pk primary key,
    hashed_password     varchar        NOT NULL,
    full_name           varchar        NOT NULL,
    email               varchar UNIQUE NOT NULL,
    password_changed_at timestamptz    NOT NULL DEFAULT ('0001-01-01 00:00:00Z'),
    created_at          timestamptz    NOT NULL DEFAULT (now())
);

ALTER TABLE accounts
    ADD FOREIGN KEY (owner) REFERENCES users (username);

ALTER TABLE accounts
    ADD CONSTRAINT owner_currency_key UNIQUE (owner, currency);

CREATE TABLE sessions
(
    id            uuid
        constraint sessions_pk primary key,
    username      varchar     NOT NULL,
    refresh_token varchar     NOT NULL,
    user_agent    varchar     NOT NULL,
    client_ip     varchar     NOT NULL,
    is_blocked    boolean     NOT NULL DEFAULT false,
    expires_at    timestamptz NOT NULL,
    created_at    timestamptz NOT NULL DEFAULT (now())
);

ALTER TABLE sessions
    ADD FOREIGN KEY (username) REFERENCES users (username);
