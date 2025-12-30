import dotenv from 'dotenv';
import bcrypt from 'bcrypt';

dotenv.config({ path: '../dotenv/.env' }); // adjust path if needed

/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
export async function seed(knex) {
  // Read admin info from environment
  const username = process.env.ADMIN_USERNAME;
  const email = process.env.ADMIN_EMAIL;
  const password = process.env.ADMIN_PASSWORD; 

  if (!username || !email || !password) {
    throw new Error('Missing ADMIN_USERNAME, ADMIN_EMAIL, or ADMIN_PASSWORD in .env');
  }


  const pw_hash = await bcrypt.hash(password, 10);


  await knex('users')
    .insert({
      username,
      email,
      pw_hash,
      role: 'admin'
    })
    .onConflict('username') 
    .ignore();
}
