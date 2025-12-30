import path from 'path';
import dotenv from 'dotenv';

dotenv.config({
  path: path.resolve(process.cwd(), '../dotenv/.env'),
});

/**
 * @type { Object.<string, import("knex").Knex.Config> }
 */
export default { 
    development: { //configurations for postgres. While db hosted on same machine as webapp, this does fine.
        client: 'pg', 
        connection: {
            host: '127.0.0.1',
            port: 5432,
            user: process.env.POSTGRES_USER,
            password: process.env.POSTGRES_PASSWORD,
            database: process.env.POSTGRES_DB
        },
        pool: { min: 2, max: 10 }, //amount of connections
        migrations: { tableName: 'knex_migrations' } //for backups
    },

    staging: { //establish connection (automatic after development)
        client: 'pg',
        connection: {
            connectionString: process.env.DB_URI_DEV,
            ssl: { rejectUnauthorized: false }
        },
        pool: { min: 2, max: 10 },
        migrations: { tableName: 'knex_migrations' }
    },

    sqlite: { 
        client: 'sqlite3',
        connection: {
            filename: '../db/whoknows.db'
        },
        useNullAsDefault: true,
    },

    staging: { //staging for sqlite
        client: 'pg',
        connection: {
            connectionString: process.env.DB_URI_DEV,
            ssl: { rejectUnauthorized: false }
        },
        pool: { min: 2, max: 10 },
        migrations: { tableName: 'knex_migrations' }
    },

  production: {
    client: 'pg',
    connection: {
      connectionString: process.env.DB_URI_PROD,
      ssl: false
    },
    pool: { min: 2, max: 10 },
    migrations: { tableName: 'knex_migrations' }
  }

}
