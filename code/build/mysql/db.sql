CREATE TABLE accounts
(
    id         bigint auto_increment,
    owner      varchar(255) NOT NULL,
    balance    bigint       NOT NULL,
    currency   varchar(3)   NOT NULL,
    created_at timestamp    NOT NULL DEFAULT (now()),
    constraint accounts_pk
        primary key (id)
);

CREATE TABLE entries
(
    id         bigint auto_increment,
    account_id bigint    NOT NULL,
    amount     bigint    NOT NULL,
    created_at timestamp NOT NULL DEFAULT (now()),
    constraint entries_pk
        primary key (id)
);

CREATE TABLE transfers
(
    id              bigint auto_increment,
    from_account_id bigint    NOT NULL,
    to_account_id   bigint    NOT NULL,
    amount          bigint    NOT NULL,
    created_at      timestamp NOT NULL DEFAULT (now()),
    constraint transfers_pk
        primary key (id)
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

ALTER TABLE entries
    CHANGE amount amount bigint NOT NULL COMMENT 'can be negative or positive';

ALTER TABLE transfers
    CHANGE amount amount bigint NOT NULL COMMENT 'must be positive';

CREATE TABLE users
(
    username            varchar(255),
    hashed_password     varchar(255)        NOT NULL,
    full_name           varchar(255)        NOT NULL,
    email               varchar(255) UNIQUE NOT NULL,
    password_changed_at timestamp           NOT NULL DEFAULT ('0001-01-01 00:00:00Z'),
    created_at          timestamp           NOT NULL DEFAULT (now()),
    constraint users_pk
        primary key (username)
);

ALTER TABLE accounts
    ADD FOREIGN KEY (owner) REFERENCES users (username);

ALTER TABLE accounts
    ADD CONSTRAINT owner_currency_key UNIQUE (owner, currency);

CREATE TABLE sessions
(
    id            binary(16),
    username      varchar(255) NOT NULL,
    refresh_token varchar(255) NOT NULL,
    user_agent    varchar(255) NOT NULL,
    client_ip     varchar(15)  NOT NULL,
    is_blocked    boolean      NOT NULL DEFAULT false,
    expires_at    timestamp    NOT NULL,
    created_at    timestamp    NOT NULL DEFAULT (now()),
    constraint sessions_pk
        primary key (id)
);

ALTER TABLE sessions
    ADD FOREIGN KEY (username) REFERENCES users (username);
