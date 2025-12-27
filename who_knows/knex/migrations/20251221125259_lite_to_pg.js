import knex from 'knex';
import config from '../knexfile.js';

const sqliteDb = knex(config.sqlite); //connections from knexfile.js
const pgDb = knex(config.development);//postgres connection

//convert sqlite users to postgres
export async function up() {
  try {
    const users = await sqliteDb('users').select('*'); //select all users

    if (!users.length) return;

    const insertData = users.map(u => ({
      username: u.username,
      email: u.email,
      pw_hash: u.pw_hash
    }));

    await pgDb.batchInsert('users', insertData, 100); //insert max 100 rows at once.
    console.log(`Migrated ${users.length} users`);

  } catch (err) {
    console.error('Migration error:', err);
    throw err;

  } finally { //disconnect.
    await sqliteDb.destroy();
    await pgDb.destroy();
  }
}

export async function down() {
  try {
    await pgDb('users').del();
    console.log('Rolled back user migration');

  } catch (err) {
    console.error('Rollback error:', err);
    throw err;
  }
}
