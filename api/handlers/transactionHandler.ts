import { query } from "../utils/db";
import { getAccount } from "./accountHandler";

const getTodaysWithdrawlTotal = async (accountID: string) => {
  const res = await query(`
    SELECT COUNT(amount) as total
    FROM transaction 
    WHERE account_number = $1
    AND amount < 0`,
    [accountID]
  );

  return Number(res.rows[0].total);
};

export const withdrawal = async (accountID: string, amount: number) => {
  if (amount > 200) {
    throw new Error("Cannot withdraw more than $200 in one transaction");
  }

  if (amount % 5 !== 0) {
    throw new Error("You can only withdraw in increments of 5");
  }

  const todaysWithdrawlTotal = await getTodaysWithdrawlTotal(accountID);

  console.log(amount)
  console.log(todaysWithdrawlTotal)
  console.log(amount + todaysWithdrawlTotal);

  if ((amount + todaysWithdrawlTotal) > 400) {
    throw new Error("Cannot withdraw more than $400 per day")
  }

  const account = await getAccount(accountID);

  if (!account.credit_limit && amount > account.amount) {
    throw new Error("Cannot withdraw more money than you have")
  }

  account.amount -= amount;

  const res = await query(`
    UPDATE accounts
    SET amount = $1 
    WHERE account_number = $2`,
    [account.amount, accountID]
  );

  if (res.rowCount === 0) {
    throw new Error("Transaction failed");
  }

  return account;
}

export const deposit = async (accountID: string, amount: number) => {
  const account = await getAccount(accountID);
  account.amount += amount;
  const res = await query(`
    UPDATE accounts
    SET amount = $1 
    WHERE account_number = $2`,
    [account.amount, accountID]
  );

  if (res.rowCount === 0) {
    throw new Error("Transaction failed");
  }

  return account;
}
