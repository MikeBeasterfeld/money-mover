-- CREATE TABLE
DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (
    account_number INTEGER PRIMARY KEY,
    name VARCHAR NOT NULL,
    amount INTEGER NOT NULL,
    type VARCHAR NOT NULL,
    credit_limit INTEGER
);

ALTER TABLE accounts ADD CONSTRAINT verify_type
CHECK (type IN ('checking', 'savings', 'credit'));

-- LOAD DATAS
INSERT INTO accounts 
    (account_number, name, amount, type)
VALUES
    (1, 'Johns Checking', 1000, 'checking'),
    (2, 'Janes Savings', 2000, 'savings'),
    (4, 'Bobs Checking', 40000, 'checking'),
    (5, 'Bills Savings', 50000, 'savings'),
    (7, 'Nancy Checking', 70000, 'checking'),
    (8, 'Nancy Savings', 80000, 'savings'),
    (10, 'Bob Savings', 50, 'savings');

INSERT INTO accounts
    (account_number, name, amount, type, credit_limit)
VALUES
    (3, 'Jills Credit', -3000, 'credit', 10000),
    (6, 'Bills Credit', -60000, 'credit', 60000),
    (9, 'Nancy Credit', -90000, 'credit', 100000),
    (11, 'Bob Credit', -1000, 'credit', 900);


DROP TABLE IF EXISTS transaction;
CREATE TABLE transaction (
    account_number INTEGER NOT NULL,
    amount INTEGER,
    date TIMESTAMP NOT NULL
      DEFAULT current_timestamp,
    CONSTRAINT transactions_fk_accounts
      FOREIGN KEY(account_number)
        REFERENCES accounts(account_number)
);

INSERT INTO transaction
    (account_number, amount)
VALUES
    (1, -300),
    (1, -300)
