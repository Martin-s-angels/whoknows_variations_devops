import knex from 'knex';
import config from '../knexfile.js';

const sqliteDb = knex(config.sqlite);
const pgDb = knex(config.development);

export async function up() {
  try {
    const pages = await sqliteDb('pages').select('*');

    if (!pages.length) return;

    const insertData = pages.map(p => ({
      title: p.title,
      url: p.url,
      language: p.language,
      last_updated: p.last_updated,
      content: p.content
    }));

    await pgDb.batchInsert('pages', insertData, 100);

    console.log(`Migrated ${pages.length} pages`);
  } catch (err) {
    console.error('Migration error:', err);
    throw err;
  } finally {
    await sqliteDb.destroy();
    await pgDb.destroy();
  }
}

export async function down() {
  try {
    await pgDb('pages').del();
    console.log('Rolled back pages migration');
  } catch (err) {
    console.error('Rollback error:', err);
    throw err;
  }
}
