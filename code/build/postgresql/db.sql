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
    password_changed_at timestamptz    NOT NULL DEFAULT (now()),
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

INSERT INTO users (username, hashed_password, full_name, email)
VALUES
    ('one', MD5('one'), 'One Ivan', 'one.ivan@gmail.com'),
    ('two', MD5('two'), 'Two Stepan', 'two.stepan@mail.ru'),
    ('three', MD5('three'), 'Three Boromeer', 'three.boromeer@bomail.io');

INSERT INTO accounts (owner, balance, currency)
VALUES
    ('one', 100, 'USD'),
    ('two', 100, 'USD'),
    ('three', 100, 'USD');


create table languages
(
    id   bigserial
        constraint languages_pk
            primary key,
    name varchar(255)
);

create unique index languages_name_uindex
    on languages (name);

INSERT INTO public.languages (id, name) VALUES (1, 'РУССКИЙ');
INSERT INTO public.languages (id, name) VALUES (2, '中文');
INSERT INTO public.languages (id, name) VALUES (3, 'TÜRKÇE');
INSERT INTO public.languages (id, name) VALUES (4, 'ESPAÑOL');
INSERT INTO public.languages (id, name) VALUES (5, 'ENGLISH');
INSERT INTO public.languages (id, name) VALUES (6, 'FRANÇAIS');
INSERT INTO public.languages (id, name) VALUES (7, 'PORTUGUÊS');
INSERT INTO public.languages (id, name) VALUES (8, 'DEUTSCH');
INSERT INTO public.languages (id, name) VALUES (9, 'POLSKI');

create table words
(
    id      bigserial
        constraint words_pk
            primary key,
    lang_id bigint not null
        constraint words_languages_id_fk
            references languages
            on update cascade on delete cascade,
    name    varchar(255)
);

create unique index words_lang_id_name_uindex
    on words (lang_id, name);

alter table words
    drop constraint words_languages_id_fk;

INSERT INTO public.words (id, lang_id, name) VALUES (1, 5, 'Hello');
INSERT INTO public.words (id, lang_id, name) VALUES (2, 6, 'Bonjour');
INSERT INTO public.words (id, lang_id, name) VALUES (3, 7, 'Hola');
INSERT INTO public.words (id, lang_id, name) VALUES (5, 10, 'हैलो।');
